# app/view/controls/controls_extents.R

# Purpose
# - Defines the scope-specific controlbar UI for the "Extents" section.
# - Provides Realm and Ecosystem Type filters, plus the Apply Filters button.

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
ui <- function(id, realm_choices = NULL, ecosystem_type_choices = NULL) {
  ns <- NS(id)

  tagList(
    h4("Extents Filters"),
    p("Placeholder: filters coming soon.")
  )
}

#' @export
server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    # Return empty list for now
    list(
      realm = shiny::reactive(NULL),
      ecosystem_type = shiny::reactive(NULL),
      apply = shiny::reactive(NULL)
    )
  })
}
