# app/view/controls/controls_uses_recreation.R

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
    h4("Uses > Recreation filters"),
    p("Placeholder: controls_uses_recreation.R")
  )
}

# #' @export
# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#   })
# }