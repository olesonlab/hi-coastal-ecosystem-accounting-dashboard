# app/view/tabs/extents/extents_map.R

# Purpose
# - Leaflet map component for the Extents page.
# - Displays moku polygons colored by ecosystem extent area.

# Rules
# - Receives filtered sf data from parent (extents_page).
# - No data loading or filtering here; that happens in main.R.
# - IDs must be namespaced via NS(id).

# Imports
box::use(
  shiny[
    NS,
    moduleServer,
    reactive,
    req
  ],
  leaflet[
    leaflet,
    leafletOutput,
    renderLeaflet,
    addProviderTiles,
    providers,
    addPolygons,
    addLegend,
    colorBin,
    highlightOptions,
    setView
  ],
  htmltools[HTML],
  scales[comma]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  leafletOutput(ns("map"), height = "100%")
}

#' @export
server <- function(id, filtered_sf) {
  moduleServer(id, function(input, output, session) {

    output$map <- renderLeaflet({
      req(filtered_sf())

      dat <- filtered_sf()

      # Handle empty data
      if (nrow(dat) == 0) {
        return(
          leaflet() |>
            addProviderTiles(providers$CartoDB.Positron) |>
            setView(lng = -157.5, lat = 20.5, zoom = 7)
        )
      }

      # Create color palette
      pal <- colorBin(
        palette = "YlGnBu",
        domain = dat$area_km2,
        bins = 7,
        na.color = "transparent"
      )

      # Build map
      leaflet(dat) |>
        addProviderTiles(providers$CartoDB.Positron) |>
        addPolygons(
          weight = 1,
          opacity = 1,
          color = "#FFFFFF",
          fillOpacity = 0.7,
          fillColor = ~pal(area_km2),
          highlightOptions = highlightOptions(
            weight = 2,
            color = "#000000",
            fillOpacity = 0.85,
            bringToFront = TRUE
          ),
          label = ~sprintf(
            "<strong>Moku:</strong> %s, %s<br/><strong>Ecosystem type:</strong> %s<br/><strong>Area:</strong> %s km\u00b2",
            moku_olelo,
            island_olelo,
            ecosystem_type,
            comma(round(area_km2, 2))
          ) |>
            lapply(HTML)
        ) |>
        addLegend(
          pal = pal,
          values = ~area_km2,
          title = "Area (km\u00b2)",
          opacity = 0.7,
          position = "bottomright"
        )
    })
  })
}
