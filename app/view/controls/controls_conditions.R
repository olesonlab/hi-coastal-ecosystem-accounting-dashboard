# app/view/controls/controls_conditions.R

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
    h4("Conditions filters"),
    p("Placeholder: controls_conditions.R")
  )
}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }