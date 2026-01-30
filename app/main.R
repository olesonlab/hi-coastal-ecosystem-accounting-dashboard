# app/main.R

# Purpose
# - App entrypoint and wiring diagram.
# - Owns parent/global reactive state (navigation, filter state, data).
# - Wires layout slots (sidebar/body/controlbar) and routes what is shown based on nav scope.

# Rules
# - Keep main.R focused on orchestration.
# - Parent owns all state; feature and controls modules stay stateless.
# - Use shiny:: for reactive primitives (reactiveValues, observeEvent, req, renderUI, etc.).
# - Use box::use() for imports; do not use library().

# Current status
# - Data loading from targets pipeline.
# - Global filters (Island, Moku, Year) with cascading.
# - Extents-specific filters (Realm, Ecosystem Type).
# - Filtered data reactives passed to page modules.
# - Filter values use `island`/`moku` columns, display uses `island_olelo`/`moku_olelo`.

# Imports
box::use(
  shiny[
    NS,
    moduleServer,
    uiOutput,
    reactive,
    reactiveValues,
    observeEvent,
    renderUI,
    req,
    tagList,
    div,
    updateSelectInput
  ],
  dplyr[filter]
)

# Modules
box::use(
  app/view/layout/nav_model[
    HOME,
    CONDITIONS,
    EXTENTS,
    USES_FISHERIES_VALUATION,
    USES_RECREATION
  ],
  app/view/layout/dashboard_shell,
  app/view/layout/nav,
  app/view/controls/controls_global,
  app/view/controls/controls_extents,
  app/view/controls/controls_conditions,
  app/view/controls/controls_uses_fisheries_valuation,
  app/view/controls/controls_uses_recreation,
  app/view/tabs/extents/extents_page,
  app/logic/routing_spec,
  app/logic/data_loader
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  dashboard_shell$ui(
    id = ns("shell"),
    sidebar = nav$ui(ns("nav")),
    body = uiOutput(ns("body")),
    controlbar = uiOutput(ns("controlbar"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    ########################
    # Data Loading
    ########################

    # Load data once at startup
    extents_sf <- data_loader$load_extents_sf()
    extents_df <- data_loader$load_extents_df()
    filter_choices <- data_loader$get_filter_choices(extents_df)

    # Load fisheries data
    fisheries_comm <- data_loader$load_fisheries_commercial()
    fisheries_noncomm <- data_loader$load_fisheries_noncommercial()
    fisheries_filter_choices <- data_loader$get_fisheries_filter_choices(fisheries_comm, fisheries_noncomm)

    ########################
    # State
    ########################

    state <- reactiveValues(
      # Navigation
      nav_scope = HOME,

      # Applied filter values (updated on "Apply Filters" click)
      # These use the filter key columns (island, moku), not the display columns (olelo)
      applied_island = filter_choices$islands[1],
      applied_moku = filter_choices$mokus[1],
      applied_year = max(filter_choices$years),
      applied_realm = filter_choices$realms[1],
      applied_ecosystem_type = filter_choices$ecosystem_types[1]
    )

    ########################
    # Navigation
    ########################

    selected_scope <- nav$server("nav")

    observeEvent(selected_scope(), {
      req(selected_scope())
      state$nav_scope <- selected_scope()
    })

    ########################
    # Global Controls Server
    ########################

    global_inputs <- controls_global$server("controls_global", extents_df)

    # Cascade: Update moku choices when island changes
    observeEvent(global_inputs$island(), {
      new_mokus <- data_loader$get_mokus_for_island(extents_df, global_inputs$island())
      updateSelectInput(
        session,
        inputId = "controls_global-moku",
        choices = new_mokus,
        selected = new_mokus[1]
      )
    })

    ########################
    # Extents Controls Server
    ########################

    extents_inputs <- controls_extents$server("controls_extents")

    # Cascade: Update ecosystem type choices when realm changes
    observeEvent(extents_inputs$realm(), {
      new_types <- data_loader$get_ecosystem_types_for_realm(extents_df, extents_inputs$realm())
      updateSelectInput(
        session,
        inputId = "controls_extents-ecosystem_type",
        choices = new_types,
        selected = new_types[1]
      )
    })

    # Apply filters when extents Apply button clicked
    observeEvent(extents_inputs$apply(), {
      state$applied_island <- global_inputs$island()
      state$applied_moku <- global_inputs$moku()
      state$applied_year <- global_inputs$year()
      state$applied_realm <- extents_inputs$realm()
      state$applied_ecosystem_type <- extents_inputs$ecosystem_type()
    }, ignoreInit = TRUE)

    ########################
    # Fisheries Controls Server
    ########################

    fisheries_inputs <- controls_uses_fisheries_valuation$server("controls_uses_fisheries_valuation")

    ########################
    # Filtered Data Reactives
    ########################

    # Filtered extents data (sf for map)
    filtered_extents_sf <- reactive({
      dat <- extents_sf

      # Apply filters using the filter key columns (island, moku)
      dat <- dat |> filter(island == state$applied_island)
      dat <- dat |> filter(moku == state$applied_moku)
      dat <- dat |> filter(year == as.integer(state$applied_year))
      dat <- dat |> filter(realm == state$applied_realm)
      dat <- dat |> filter(ecosystem_type == state$applied_ecosystem_type)

      dat
    })

    # Filtered extents data (df for table/charts - all years for change calculation)
    filtered_extents_df <- reactive({
      dat <- extents_df

      # Apply filters (except year - we need all years for accounting table)
      dat <- dat |> filter(island == state$applied_island)
      dat <- dat |> filter(moku == state$applied_moku)
      dat <- dat |> filter(realm == state$applied_realm)
      dat <- dat |> filter(ecosystem_type == state$applied_ecosystem_type)

      dat
    })

    # Selected year reactive
    selected_year <- reactive({
      as.integer(state$applied_year)
    })

    # Selected island reactive (return display name for UI labels)
    selected_island <- reactive({
      # Look up the olelo name from the filter key
      idx <- which(filter_choices$islands == state$applied_island)
      if (length(idx) > 0) {
        names(filter_choices$islands)[idx]
      } else {
        state$applied_island
      }
    })

    ########################
    # Body Rendering
    ########################

    output$body <- renderUI({
      pages <- routing_spec$page_modules_by_scope()
      page <- pages[[state$nav_scope]]

      if (is.null(page)) {
        div("Unknown scope: ", state$nav_scope)
      } else {
        page$ui(ns(paste0("page_", state$nav_scope)))
      }
    })

    # Wire up extents page server when on extents scope
    observeEvent(state$nav_scope, {
      if (state$nav_scope == EXTENTS) {
        extents_page$server(
          paste0("page_", EXTENTS),
          filtered_sf = filtered_extents_sf,
          filtered_df = filtered_extents_df,
          selected_year = selected_year,
          selected_island = selected_island
        )
      }
    })

    ########################
    # Controlbar Rendering
    ########################

    output$controlbar <- renderUI({
      scope_controls <- routing_spec$control_modules_by_scope()
      scope_module <- scope_controls[[state$nav_scope]]

      # Fisheries has its own complete filter set (no global controls)
      if (state$nav_scope == USES_FISHERIES_VALUATION) {
        return(
          controls_uses_fisheries_valuation$ui(
            ns("controls_uses_fisheries_valuation"),
            island_choices = fisheries_filter_choices$islands,
            ecosystem_choices = fisheries_filter_choices$ecosystem_types,
            species_group_choices = fisheries_filter_choices$species_groups,
            year_choices = fisheries_filter_choices$years
          )
        )
      }

      # Build scope-specific controls UI for other scopes
      scope_ui <- if (is.null(scope_module)) {
        NULL
      } else if (state$nav_scope == EXTENTS) {
        # Extents needs filter choices
        controls_extents$ui(
          ns("controls_extents"),
          realm_choices = filter_choices$realms,
          ecosystem_type_choices = filter_choices$ecosystem_types
        )
      } else {
        scope_module$ui(ns(paste0("controls_", state$nav_scope)))
      }

      tagList(
        controls_global$ui(
          ns("controls_global"),
          island_choices = filter_choices$islands,
          moku_choices = filter_choices$mokus,
          year_choices = filter_choices$years
        ),
        scope_ui
      )
    })

  })
}
