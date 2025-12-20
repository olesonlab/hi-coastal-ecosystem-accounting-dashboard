# app/view/accounts/uses/recreation/recreation_page.R

# Purpose
# - Page-level UI for the "Uses > Recreation" account in the dashboard.
# - Composes Uses > Recreation view components (map/plots/table) for the active filters.

# Rules
# - UI only in this file (no data loading, no preprocessing, no spatial ops).
# - Do not create or store global state here.
# - Consume processed / summarized outputs from app/logic/* via server wiring in main.R.
# - IDs must be namespaced via NS(id); do not hardcode global IDs.

# Current status
# - Placeholder page scaffold only.
# - Routing from main.R is implemented; controls panel is routed separately.
# - Uses > Recreation components (map/plots/table) will be added in subsequent iterations.


# Imports
box::use(
  shiny[NS, h2, p, tagList]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    h2("Uses > Recreation"),
    p("Placeholder page: app/view/accounts/uses/recreation/recreation_page.R")
  )

}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }