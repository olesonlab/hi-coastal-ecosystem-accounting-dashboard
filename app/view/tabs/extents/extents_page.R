# app/view/tabs/extents/extents_page.R

# Purpose
# - Page-level UI for the "Extents" account in the dashboard.
# - Composes Extents view components (map/plots/table) for the active filters.
# - Filters: Ecosystem Type, Year (in controlbar)
# - Visualizations: Choropleth map, bar graph of areas, extent accounting table

# Rules
# - UI only in this file (no data loading, no preprocessing, no spatial ops).
# - Do not create or store global state here.
# - Consume processed / summarized outputs from app/logic/* via server wiring in main.R.
# - IDs must be namespaced via NS(id); do not hardcode global IDs.

# Current status
# - Full page with description, placeholder boxes for map, bar graph, and extent table.
# - User selects Ecosystem Type and Year via controlbar filters.
# - Future work: date range selection, change over time visualizations.

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
    # Extents Description Section
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("layer-group"),
            strong("Ecosystem Extent Overview")
          ),
          status = "olive",
          solidHeader = FALSE,
          width = 12,
          collapsible = TRUE,
          maximizable = TRUE,

          tagList(
            p(
              "The ecosystem extent accounts for Hawai\u02bbi are modeled closely after the System
              of Environmental Economic Accounting - Ecosystem Accounts (SEEA EA) framework. The extent
              accounts show geographical boundaries and areas of pre-defined ecosystem types (marine and
              terrestrial) aggregated by moku. See ",
              tags$a(
                href = "https://seea.un.org",
                target = "_blank",
                "https://seea.un.org"
              ),
              " for more information."
            ),
            p(
              strong("How to use: "),
              "Select an Ecosystem Type and Year from the filter panel on the right. The map shows
              extent area (km\u00b2) by moku as a choropleth, colored relative to all of Hawai\u02bbi.
              The bar graph displays extent areas across all mokus, and the table provides detailed
              accounting data."
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
                    title = "The Moku system (districts) is a biocultural resource management system based on Hawaiian
                    social-ecological regions and communities. Their boundaries are used as Ecosystem Accounting Areas
                    (EAA), accounting units for the SEEA EA framework."
                  ),
                  div(class = "metric-value", "43"),
                  div(class = "metric-label", "Mokus Analyzed")
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
                    title = "An ecosystem type is a distinct ecosystem functional group with its unique combination of abiotic
                    and biotic components and interactions. Marine types include coral, seagrass, and open ocean.
                    Terrestrial types include forest, shrubland, and developed areas."
                  ),
                  div(class = "metric-value", "14"),
                  div(class = "metric-label", "Ecosystem Types")
                )
              )
            ),

            p(
              class = "about-our-project-notes",
              tagList(
                icon("info-circle", class = "about-our-project-notes-icon"),
                " Note: Marine ecosystem extents are vectorised from rasters for visualization purposes
                and may contain minor spatial errors. Zoom in/out on the map to explore different regions."
              )
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Extents Choropleth Map
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("globe-americas"),
            strong("Ecosystem Extent Map (by Moku)")
          ),
          status = "olive",
          solidHeader = FALSE,
          width = 12,
          height = "600px",
          maximizable = TRUE,
          footer = "Choropleth map showing extent area (km\u00b2) by moku, colored relative to all Hawai\u02bbi.",
          div(
            class = "placeholder-content",
            icon(
              "map-marked-alt",
              class = "placeholder-content-icon"
            ),
            h4("Ecosystem Extent Map"),
            p(
              "Choropleth map will display when data integration is complete.
              Select Ecosystem Type and Year from the filter panel."
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Bar Graph and Table Row
    #-------------------------------------------------
    fluidRow(
      # Extent Bar Graph (areas across all mokus)
      column(
        width = 6,
        box(
          title = tagList(
            icon("chart-bar"),
            strong("Extent Areas by Moku")
          ),
          status = "info",
          solidHeader = FALSE,
          width = 12,
          height = "500px",
          maximizable = TRUE,
          footer = "Bar graph showing ecosystem extent areas (km\u00b2) across all mokus in Hawai\u02bbi.",
          div(
            class = "placeholder-content",
            icon(
              "chart-bar",
              class = "placeholder-content-icon"
            ),
            h4("Extent Areas Bar Graph"),
            p(
              "Bar graph will display when data integration is complete.
              Shows extent areas for each moku."
            )
          )
        )
      ),

      # Extent Accounting Table
      column(
        width = 6,
        box(
          title = tagList(
            icon("table"),
            strong("Ecosystem Extent Account")
          ),
          status = "success",
          solidHeader = FALSE,
          width = 12,
          height = "500px",
          maximizable = TRUE,
          footer = "Extent values (km\u00b2) overall and by moku for the selected year.",
          div(
            class = "placeholder-content",
            icon(
              "table",
              class = "placeholder-content-icon"
            ),
            h4("Extent Accounting Table"),
            p(
              "Table will display when data integration is complete.
              Shows extent values by island, moku, and year."
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
            strong("Change Over Time (Coming Soon)")
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
              "Future work: Select a date range to view extent changes over time.
              Visualizations will include change maps, trend graphs, and summary tables
              showing extent gains and losses by moku."
            )
          )
        )
      )
    )
  )
}

#' @export
server <- function(id, filtered_sf = NULL, filtered_df = NULL, selected_year = NULL, selected_island = NULL) {
  moduleServer(id, function(input, output, session) {
    # Server logic will be added when data integration is implemented
  })
}
