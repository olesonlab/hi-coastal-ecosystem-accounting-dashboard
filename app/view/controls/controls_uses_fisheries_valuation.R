# app/view/controls/controls_uses_fisheries_valuation.R

# Purpose

# Rules

# Current Status

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