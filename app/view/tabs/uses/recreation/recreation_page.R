# app/view/tabs/uses/recreation/recreation_page.R

# Purpose
# - Page-level UI for the "Recreation Services" section in the dashboard.
# - Displays coral reef recreation welfare valuation by moku.
# - Based on Random Utility Model (RUM) estimating annual welfare from coral cover.

# Rules
# - UI only in this file (no data loading, no preprocessing, no spatial ops).
# - Do not create or store global state here.
# - Consume processed / summarized outputs from app/logic/* via server wiring in main.R.
# - IDs must be namespaced via NS(id); do not hardcode global IDs.

# Current status
# - Placeholder page with map and table for coral reef welfare valuation.
# - Visualizations: Choropleth map of welfare by moku, welfare values table.

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
    # Recreation Description Section
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("umbrella-beach"),
            strong("Coral Reef Recreation Welfare Valuation")
          ),
          status = "olive",
          solidHeader = FALSE,
          width = 12,
          collapsible = TRUE,
          maximizable = TRUE,
          tagList(
            p(
              "This section presents the estimated annual welfare value associated with coral reef
              ecosystems across Hawai\u02bbi's moku districts. Values are derived from a Random Utility
              Model (RUM) based on the Fezzi, Ford, and Oleson economic framework, which analyzes
              recreational site preferences and travel cost data."
            ),
            p(
              "The welfare estimates represent the annual economic loss (compensating variation) that
              would occur if coral cover in each moku were reduced to zero while all other site
              attributes remained constant. This approach quantifies the recreational value that
              coral reefs provide to residents and visitors."
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
                    title = "Welfare values are estimated for each moku district using site-level
                    coral cover data and recreational visitation patterns."
                  ),
                  div(class = "metric-value", "34"),
                  div(class = "metric-label", "Mokus Valued")
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
                    title = "Recreational sites included in the travel cost model analysis,
                    covering beaches, snorkeling spots, and other coastal recreation areas."
                  ),
                  div(class = "metric-value", "100+"),
                  div(class = "metric-label", "Recreation Sites")
                )
              )
            ),

            p(
              class = "about-our-project-notes",
              tagList(
                icon("info-circle", class = "about-our-project-notes-icon"),
                " Values are reported in 2024 dollars. The model incorporates travel costs, site
                amenities (parking, lifeguards, showers), coral cover, and fish biomass to estimate
                recreational welfare. Fish biomass valuations will also be incorporated in future updates."
              )
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Coral Reef Welfare Map
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("globe-americas"),
            strong("Annual Coral Reef Welfare by Moku")
          ),
          status = "olive",
          solidHeader = FALSE,
          width = 12,
          height = "600px",
          maximizable = TRUE,
          div(
            class = "placeholder-content",
            icon(
              "map-marked-alt",
              class = "placeholder-content-icon"
            ),
            h4("Coral Reef Welfare Map"),
            p(
              "Choropleth map showing estimated annual welfare value of coral reefs by moku.
              Values represent compensating variation (annual loss if coral were removed)."
            )
          )
        )
      )
    ),

    #-------------------------------------------------
    # Welfare Values Table
    #-------------------------------------------------
    fluidRow(
      column(
        width = 12,
        box(
          title = tagList(
            icon("table"),
            strong("Coral Reef Welfare Values by Moku")
          ),
          status = "success",
          solidHeader = FALSE,
          width = 12,
          height = "500px",
          maximizable = TRUE,
          div(
            class = "placeholder-content",
            icon(
              "table",
              class = "placeholder-content-icon"
            ),
            h4("Welfare Valuation Table"),
            p(
              "Annual welfare values (2024 $) by moku, showing the estimated economic contribution
              of coral reef ecosystems to recreational services. Includes island, moku name,
              number of sites, and estimated annual welfare."
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
