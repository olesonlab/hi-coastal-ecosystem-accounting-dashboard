# app/view/tabs/conditions/conditions_page.R

# Purpose
# - Page-level UI for the "Ecosystem Conditions" section in the dashboard.
# - Composes Conditions view components (map/plots/table) for the active filters.
# - Filters: Ecosystem Type, Condition Indicator, Year (in controlbar)
# - Visualizations: Choropleth map, bar graph of condition values, condition accounting table

# Rules
# - UI only in this file (no data loading, no preprocessing, no spatial ops).
# - Do not create or store global state here.
# - Consume processed / summarized outputs from app/logic/* via server wiring in main.R.
# - IDs must be namespaced via NS(id); do not hardcode global IDs.

# Current status
# - Full page with description, choropleth map, bar graph, and condition table.
# - User selects Ecosystem Type, Condition Indicator, and Year via controlbar filters.
# - Future work: temporal trend analysis, multi-indicator comparisons.

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
    tags,
    h4
  ],
  bs4Dash[
    box
  ]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  tagList(
    #-------------------------------------------------
    # Conditions Description Section
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("heartbeat"),
            strong("Ecosystem Condition Overview")
          ),
          status = "olive",
          solidHeader = FALSE,
          width = 12,
          collapsible = TRUE,
          maximizable = TRUE,

          tagList(
            p(
              "The ecosystem condition accounts track the health and quality of ecosystem assets
              over time, modeled after the SEEA EA framework. Condition indicators measure
              biophysical characteristics such as vegetation health (NDVI), coral cover, water
              quality, and other environmental variables that reflect ecosystem integrity. See ",
              tags$a(
                href = "https://seea.un.org",
                target = "_blank",
                "https://seea.un.org"
              ),
              " for more information."
            ),
            p(
              strong("How to use: "),
              "Select an Ecosystem Type, Condition Indicator, and Year from the filter panel
              on the right. The map shows condition values by moku as a choropleth, colored
              relative to all of Hawai\u02bbi. The bar graph displays condition values across
              all mokus, and the table provides detailed accounting data."
            ),

            fluidRow(
              class = "metric-row",
              column(
                width = 4,
                div(
                  class = "metric-box moku-metric-box",
                  tags$span(
                    class = "info-icon",
                    icon("info-circle"),
                    `data-toggle` = "tooltip",
                    `data-placement` = "top",
                    title = "Condition indicators are measured across all moku districts to track
                    spatial patterns in ecosystem health over time."
                  ),
                  div(class = "metric-value", "43"),
                  div(class = "metric-label", "Mokus Monitored")
                )
              ),
              column(
                width = 4,
                div(
                  class = "metric-box et-metric-box",
                  tags$span(
                    class = "info-icon",
                    icon("info-circle"),
                    `data-toggle` = "tooltip",
                    `data-placement` = "top",
                    title = "Each ecosystem type has associated condition indicators that measure
                    specific aspects of ecosystem health (e.g., coral cover for reef ecosystems,
                    NDVI for terrestrial ecosystems)."
                  ),
                  div(class = "metric-value", "8"),
                  div(class = "metric-label", "Condition Indicators")
                )
              )
            ),

            p(
              class = "about-our-project-notes",
              tagList(
                icon("info-circle", class = "about-our-project-notes-icon"),
                " Note: Condition data is derived from remote sensing products and environmental
                monitoring stations. Values are aggregated to moku boundaries for consistency
                with extent accounts. Some indicators may have limited temporal coverage."
              )
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Conditions Choropleth Map
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("globe-americas"),
            strong("Ecosystem Condition Map (by Moku)")
          ),
          status = "olive",
          solidHeader = FALSE,
          width = 12,
          height = "600px",
          maximizable = TRUE,
          footer = "Choropleth map showing condition indicator values by moku, colored relative to all Hawai\u02bbi.",
          div(
            class = "placeholder-content",
            icon(
              "map-marked-alt",
              class = "placeholder-content-icon"
            ),
            h4("Condition Indicators Map"),
            p(
              "Choropleth map will display when data integration is complete.
              Select Ecosystem Type, Condition Indicator, and Year from the filter panel."
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Bar Graph and Table Row
    #-------------------------------------------------
    fluidRow(
      # Condition Bar Graph (values across all mokus)
      column(
        width = 6,
        box(
          title = tagList(
            icon("chart-bar"),
            strong("Condition Values by Moku")
          ),
          status = "info",
          solidHeader = FALSE,
          width = 12,
          height = "500px",
          maximizable = TRUE,
          footer = "Bar graph showing ecosystem condition values across all mokus in Hawai\u02bbi.",
          div(
            class = "placeholder-content",
            icon(
              "chart-bar",
              class = "placeholder-content-icon"
            ),
            h4("Condition Values Bar Graph"),
            p(
              "Bar graph will display when data integration is complete.
              Shows condition indicator values for each moku."
            )
          )
        )
      ),

      # Condition Accounting Table
      column(
        width = 6,
        box(
          title = tagList(
            icon("table"),
            strong("Ecosystem Condition Account")
          ),
          status = "success",
          solidHeader = FALSE,
          width = 12,
          height = "500px",
          maximizable = TRUE,
          footer = "Condition indicator values overall and by moku for the selected year.",
          div(
            class = "placeholder-content",
            icon(
              "table",
              class = "placeholder-content-icon"
            ),
            h4("Condition Accounting Table"),
            p(
              "Table will display when data integration is complete.
              Shows condition values by island, moku, and year."
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Future Work Section (placeholder)
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("clock"),
            strong("Condition Trends Over Time (Coming Soon)")
          ),
          status = "secondary",
          solidHeader = FALSE,
          width = 12,
          height = "300px",
          maximizable = FALSE,
          collapsible = TRUE,
          collapsed = TRUE,
          div(
            class = "placeholder-content",
            icon(
              "chart-line",
              class = "placeholder-content-icon"
            ),
            h4("Temporal Analysis"),
            p(
              "Future work: Select a date range to view condition changes over time.
              Visualizations will include trend graphs comparing condition indicators
              across years and showing improvement or degradation patterns by moku."
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
