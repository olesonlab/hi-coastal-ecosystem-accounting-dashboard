# app/view/controls/controls_global.R

# Purpose
# - Defines the global controlbar UI that applies across all dashboard sections (scopes).
# - Provides shared filters/inputs used by multiple pages (e.g., geography/time selectors).

# Rules
# - UI-only module: define inputs and layout only.
# - Do not load data, run preprocessing, or perform spatial operations here.
# - Do not store state here; parent state is owned by main.R.
# - Input IDs must be namespaced via NS(id).
# - Scope-specific controls belong in app/view/controls/controls_<scope>.R.

# Current status
# - Placeholder controls scaffold only.
# - Rendered in the controlbar for all scopes; scope-specific controls are rendered beneath it.

# Imports
box::use(
  shiny[NS, tagList, h4, p]
)
# Modules
# box::use(
  
# )

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    h4("Global filters"),
    p("Placeholder: controls_global.R")
  )
}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }