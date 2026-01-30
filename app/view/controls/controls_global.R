# app/view/controls/controls_global.R

# Purpose
# - Defines the global controlbar UI that applies across all dashboard sections (scopes).
# - Provides shared filters: Island, Moku (cascading), and Year.

# Rules
# - UI-only module: define inputs and layout only.
# - Do not load data, run preprocessing, or perform spatial operations here.
# - Do not store state here; parent state is owned by main.R.
# - Input IDs must be namespaced via NS(id).
# - Scope-specific controls belong in app/view/controls/controls_<scope>.R.

# Current status
# - Placeholder controls scaffold only.

# Imports
box::use(
  shiny[NS, tagList, h4, p]
)

#' @export
ui <- function(id, island_choices = NULL, moku_choices = NULL, year_choices = NULL) {
  ns <- NS(id)

  tagList(
    h4("Global Filters"),
    p("Placeholder: filters coming soon.")
  )
}

#' @export
server <- function(id, extents_df = NULL) {
  shiny::moduleServer(id, function(input, output, session) {
    # Return empty list for now
    list(
      island = shiny::reactive(NULL),
      moku = shiny::reactive(NULL),
      year = shiny::reactive(NULL)
    )
  })
}
