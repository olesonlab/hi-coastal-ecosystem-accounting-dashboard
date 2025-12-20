# app/view/accounts/extents/extents_page.R

# Purpose
# - Page-level UI for the "Extents" account in the dashboard.
# - Composes Extents view components (map/plots/table) for the active filters.

# Rules
# - UI only in this file (no data loading, no preprocessing, no spatial ops).
# - Do not create or store global state here.
# - Consume processed / summarized outputs from app/logic/* via server wiring in main.R.
# - IDs must be namespaced via NS(id); do not hardcode global IDs.

# Current status
# - Placeholder page scaffold only.
# - Routing from main.R is implemented; controls panel is routed separately.
# - Extents components (map/plots/table) will be added in subsequent iterations.

# Imports
box::use(
  shiny[NS, h2, p, tagList]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    h2("Extents"),
    p("Placeholder page: app/view/accounts/extents/extents_page.R")
  )

}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }