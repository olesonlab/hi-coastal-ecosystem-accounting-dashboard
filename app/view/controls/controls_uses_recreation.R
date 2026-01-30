# app/view/controls/controls_uses_recreation.R

# Purpose
# - Defines the scope-specific controlbar UI for the "Uses > Recreation" section.
# - Provides filter/input controls that affect what the Uses > Recreation page renders.

# Rules
# - UI-only module: define inputs and layout only.
# - Do not load data, run preprocessing, or perform spatial operations here.
# - Do not store state here; parent state is owned by main.R.
# - Input IDs must be namespaced via NS(id).
# - Any reactive behavior belongs in main.R (or in dedicated logic modules), not in this file.

# Current status
# - Placeholder controls scaffold only.

# Imports
box::use(
  shiny[NS, tagList, h4, p]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    h4("Recreation Filters"),
    p("Placeholder: filters coming soon.")
  )
}

#' @export
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    # Return empty list for now
    list()
  })
}
