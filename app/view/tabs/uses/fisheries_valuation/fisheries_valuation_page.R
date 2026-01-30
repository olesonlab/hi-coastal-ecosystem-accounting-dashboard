# app/view/tabs/uses/fisheries_valuation/fisheries_valuation_page.R

# Purpose
# - Page-level UI for the "Fisheries Valuation" section in the dashboard.
# - Displays economic valuation of fisheries ecosystem services (commercial and non-commercial).

# Rules
# - UI only in this file (no data loading, no preprocessing, no spatial ops).
# - Do not create or store global state here.
# - Consume processed / summarized outputs from app/logic/* via server wiring in main.R.
# - IDs must be namespaced via NS(id); do not hardcode global IDs.

# Current status
# - Placeholder page with structure for future data integration.
# - Commercial and Non-Commercial sections with map, chart, and table placeholders.

# Imports
box::use(
  shiny[
    NS,
    moduleServer,
    fluidRow,
    column,
    div,
    p,
    strong,
    icon,
    tagList,
    span,
    tags,
    h4
  ],
  bs4Dash[
    box,
    accordion,
    accordionItem
  ]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    #-------------------------------------------------
    # Fisheries Description Section
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("fish"),
            strong("Fisheries Ecosystem Services Valuation")
          ),
          status = "olive",
          solidHeader = FALSE,
          collapsible = TRUE,
          width = 12,
          p(
            "Economic valuation of fisheries ecosystem services, separated by commercial and non-commercial
            (subsistence and recreational) activities. Values are calculated using exchange value methodologies
            and represent annual estimates."
          )
        )
      )
    ),

    #-------------------------------------------------
    # Annual Values Section
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("dollar-sign"),
            strong("Annual Exchange Values")
          ),
          status = "olive",
          solidHeader = FALSE,
          collapsible = TRUE,
          width = 12,
          fluidRow(
            column(
              width = 4,
              div(
                class = "fisheries-value-box",
                div(class = "fisheries-metric-value", "2021"),
                div(class = "fisheries-metric-label", "Year")
              )
            ),
            column(
              width = 4,
              div(
                class = "fisheries-value-box",
                div(class = "fisheries-metric-value", "$12.4M"),
                div(class = "fisheries-metric-label", "Commercial")
              )
            ),
            column(
              width = 4,
              div(
                class = "fisheries-value-box",
                div(class = "fisheries-metric-value", "$12.4M"),
                div(class = "fisheries-metric-label", "Non-Commercial")
              )
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Accordions Section
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        accordion(
          id = ns("fisheries_accordion"),
          width = 12,

          #-------------------------------------------------
          # Commercial Fisheries Section
          #-------------------------------------------------
          accordionItem(
            title = tagList(
              icon("store"),
              strong("Commercial Fisheries"),
              span(
                class = "float-right",
                tags$small("Market-Based Activities")
              )
            ),
            status = "info",
            collapsed = FALSE,
            fluidRow(
              column(
                width = 12,
                box(
                  title = tagList(
                    icon("map"),
                    "Spatial Distribution of Commercial Value"
                  ),
                  status = "info",
                  width = 12,
                  height = "400px",
                  maximizable = TRUE,
                  collapsible = TRUE,
                  div(
                    class = "placeholder-content",
                    icon(
                      "map-marked-alt",
                      class = "placeholder-content-icon"
                    ),
                    h4("Commercial Fisheries Value Map"),
                    p(
                      "Geographic distribution of commercial fishing values by moku"
                    )
                  )
                )
              ),
              column(
                width = 12,
                box(
                  title = tagList(
                    icon("chart-line"),
                    "Value Over Time"
                  ),
                  status = "info",
                  width = 12,
                  height = "400px",
                  maximizable = TRUE,
                  collapsible = TRUE,
                  div(
                    class = "placeholder-content",
                    icon(
                      "chart-area",
                      class = "placeholder-content-icon"
                    ),
                    h4("Commercial Values Plot"),
                    p(
                      "A visualization will appear here once data is available or the analysis is complete"
                    )
                  )
                )
              ),
              column(
                width = 12,
                box(
                  title = tagList(
                    icon("table"),
                    "Download Data"
                  ),
                  status = "info",
                  width = 12,
                  height = "400px",
                  maximizable = TRUE,
                  collapsible = TRUE,
                  div(
                    class = "placeholder-content",
                    icon(
                      "table",
                      class = "placeholder-content-icon"
                    ),
                    h4("Commercial Values Table"),
                    p("Detailed breakdown by island and moku")
                  )
                )
              )
            )
          ),

          #-------------------------------------------------
          # Non-Commercial Fisheries Section
          #-------------------------------------------------
          accordionItem(
            title = tagList(
              icon("users"),
              strong("Non-Commercial Fisheries"),
              span(
                class = "float-right",
                tags$small("Non-Market-Based Activities")
              )
            ),
            status = "success",
            collapsed = FALSE,
            fluidRow(
              column(
                width = 12,
                box(
                  title = tagList(
                    icon("map"),
                    "Spatial Distribution of Non-Commercial Value"
                  ),
                  status = "success",
                  width = 12,
                  height = "400px",
                  maximizable = TRUE,
                  collapsible = TRUE,
                  div(
                    class = "placeholder-content",
                    icon(
                      "map-marked-alt",
                      class = "placeholder-content-icon"
                    ),
                    h4("Non-Commercial Fisheries Value Map"),
                    p(
                      "Geographic distribution of non-commercial fishing values by moku"
                    )
                  )
                )
              ),
              column(
                width = 12,
                box(
                  title = tagList(
                    icon("chart-line"),
                    "Value Over Time"
                  ),
                  status = "success",
                  width = 12,
                  height = "400px",
                  maximizable = TRUE,
                  collapsible = TRUE,
                  div(
                    class = "placeholder-content",
                    icon(
                      "chart-area",
                      class = "placeholder-content-icon"
                    ),
                    h4("Non-Commercial Values Plot"),
                    p(
                      "A visualization will appear here once data is available or the analysis is complete"
                    )
                  )
                )
              ),
              column(
                width = 12,
                box(
                  title = tagList(
                    icon("table"),
                    "Download Data"
                  ),
                  status = "success",
                  width = 12,
                  height = "400px",
                  maximizable = TRUE,
                  collapsible = TRUE,
                  div(
                    class = "placeholder-content",
                    icon(
                      "table",
                      class = "placeholder-content-icon"
                    ),
                    h4("Non-Commercial Values Table"),
                    p("Detailed breakdown by island and moku")
                  )
                )
              )
            )
          )
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Server logic will be added when data integration is implemented
  })
}
