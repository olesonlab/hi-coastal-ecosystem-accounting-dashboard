# app/view/layout/nav.R

# Purpose
# - Defines the sidebar navigation UI for the dashboard.
# - Maps user navigation clicks to canonical scope keys (via tabName).

# Rules
# - Do not store state here.
# - server() may emit selection, but must not store or mutate global state.
# - tabName values must come from nav_model scope keys.
# - Use box::use() for imports; no library().

# Current status (scaffolding)
# - UI defines the sidebar menu structure.
# - server() emits the currently selected scope key (reactive).
# - main.R owns navigation state and uses this module output to update parent state.

# Imports
box::use(
  shiny[NS, moduleServer],
  bs4Dash[
    sidebarMenu,
    menuItem,
    menuSubItem
  ]
)
# Modules
box::use(
  app/view/layout/nav_model[
    CONDITIONS,
    EXTENTS,
    USES_FISHERIES_VALUATION,
    USES_RECREATION
  ]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  # https://bs4dash.rinterface.com/reference/dashboardsidebar
  sidebarMenu(
    id = ns("sidebar"),
    menuItem(
      "Extents",
      tabName = EXTENTS
    ),
    menuItem(
      "Conditions",
      tabName = CONDITIONS
    ),
    menuItem(
      "Uses",
      menuSubItem("Fisheries Valuation", tabName = USES_FISHERIES_VALUATION),
      menuSubItem("Recreation", tabName = USES_RECREATION)
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    shiny::reactive({
      shiny::req(input$sidebar)
      input$sidebar
    })
  })
}