# app/view/accounts/conditions/conditions_page.R

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
    h2("Conditions"),
    p("Placeholder page: app/view/accounts/conditions/conditions_page.R")
  )

}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }