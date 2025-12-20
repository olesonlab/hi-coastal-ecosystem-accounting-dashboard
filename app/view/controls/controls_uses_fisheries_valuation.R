# app/view/controls/controls_uses_fisheries_valuation.R

# Purpose
# - Defines the scope-specific controlbar UI for the "Users > Fisheries Valuation" section.
# - Provides filter/input controls that affect what the Users > Fisheries Valuation page renders.

# Rules
# - UI-only module: define inputs and layout only.
# - Do not load data, run preprocessing, or perform spatial operations here.
# - Do not store state here; parent state is owned by main.R.
# - Input IDs must be namespaced via NS(id).
# - Any reactive behavior belongs in main.R (or in dedicated logic modules), not in this file.

# Current status
# - Placeholder controls scaffold only.
# - Routed by nav scope in main.R; global controls render separately.

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
    h4("Uses > Fisheries Valuation filters"),
    p("Placeholder: controls_uses_fisheries_valuation.R")
  )
}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }