# app/main.R

# Purpose
# - App entrypoint and wiring diagram.
# - Owns parent/global reactive state (navigation now; filters later).
# - Wires layout slots (sidebar/body/controlbar) and routes what is shown based on nav scope.

# Rules
# - Keep main.R short: orchestration only (no data work, no heavy UI).
# - Parent owns all state; feature and controls modules stay stateless.
# - Core reactive calls must use shiny::<function>.
# - Use box::use() for imports; do not use library().

# Current status (scaffolding)
# - bs4Dash shell is in place (dashboard_shell).
# - Sidebar navigation is in place (nav); selection is stored in parent state as state$nav_scope.
# - Body renders a temporary debug output showing the active scope.
# - Controlbar routing is implemented (global + scope-specific placeholders); filters will be added next.
# - No data loading, filtering, maps, tables, or plots yet.

# Imports
box::use(
  shiny[
    NS, moduleServer, uiOutput
  ],
  # bs4Dash[
  # ]
)
# Modules
box::use(
  app/view/layout/nav_model[
    CONDITIONS,
    EXTENTS,
    USES_FISHERIES_VALUATION,
    USES_RECREATION
  ],
  app/view/layout/dashboard_shell,
  app/view/layout/nav,
  app/view/controls/controls_conditions,
  app/view/controls/controls_extents,
  app/view/controls/controls_global,
  app/view/controls/controls_uses_fisheries_valuation,
  app/view/controls/controls_uses_recreation,
  app/logic/routing_spec
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

    ########################
    # State
    ########################

    # Parent-owned navigation state
    state <- shiny::reactiveValues(
      nav_scope = EXTENTS
    )

    ########################
    # Navigation in sidebar
    ########################
    
    # Sidebar selection (reactive emitted by nav module)
    selected_scope <- nav$server("nav")

    shiny::observeEvent(selected_scope(), {
      shiny::req(selected_scope())
      message("selected_scope() = ", selected_scope())
      state$nav_scope <- selected_scope()
    })
    
    ########################
    # Body
    ########################

    output$body <- shiny::renderUI({
      ns <- session$ns

      # pages <- stats::setNames(
      #   list(
      #     extents_page$ui(ns("extents_page")),
      #     conditions_page$ui(ns("conditions_page")),
      #     fisheries_valuation_page$ui(ns("fisheries_page")),
      #     recreation_page$ui(ns("recreation_page"))
      #   ),
      #   c(EXTENTS, CONDITIONS, USES_FISHERIES_VALUATION, USES_RECREATION)
      # )

      pages <- routing_spec$page_modules_by_scope()
      page <- pages[[state$nav_scope]]

      if (is.null(page)) {
        shiny::div("Unknown scope: ", state$nav_scope)
      } else {
        page$ui(ns(paste0("page_", state$nav_scope)))
      }
    })

    ########################
    # Controls
    ########################

    output$controlbar <- shiny::renderUI({
      ns <- session$ns

      scope_controls <- routing_spec$control_modules_by_scope()

      scope_module <- scope_controls[[state$nav_scope]]

      scope_ui <- if (is.null(scope_module)) {
        shiny::div("No controls for scope: ", state$nav_scope)
      } else {
        scope_module$ui(ns(paste0("controls_", state$nav_scope)))
      }

      shiny::tagList(
        controls_global$ui(ns("controls_global")),
        scope_ui
      )
    })

  })
}
