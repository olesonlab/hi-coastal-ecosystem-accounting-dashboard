# app/view/controls/controls_uses_fisheries_valuation.R

# Purpose
# - Defines the scope-specific controlbar UI for the "Uses > Fisheries Valuation" section.
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

#' @export
ui <- function(id, island_choices = NULL, ecosystem_choices = NULL, species_group_choices = NULL, year_choices = NULL) {
  ns <- NS(id)

  tagList(
    h4("Fisheries Valuation Filters"),
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
