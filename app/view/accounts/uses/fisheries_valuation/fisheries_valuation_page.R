# app/view/accounts/uses/fisheries_valuation/fisheries_valuation_page.R

# Purpose

# Rules

# Current Status

# Imports
box::use(
  shiny[NS, h2, p, tagList]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    h2("Uses > Fisheries Valuation"),
    p("Placeholder page: app/view/accounts/uses/fisheries_valuation/fisheries_valuation_page.R")
  )

}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }