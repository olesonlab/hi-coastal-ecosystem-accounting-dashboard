# app/view/accounts/extents/extents_page.R

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
    h2("Extents"),
    p("Placeholder page: app/view/accounts/extents/extents_page.R")
  )

}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }