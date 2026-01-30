# app/view/tabs/extents/extents_plots.R

# Purpose
# - Plotly chart components for the Extents page.
# - Displays composition bar chart and percent change chart.

# Rules
# - Receives filtered data frame from parent (extents_page).
# - No data loading or filtering here; that happens in main.R.
# - IDs must be namespaced via NS(id).

# Imports
box::use(
  shiny[
    NS,
    moduleServer,
    req,
    tagList
  ],
  plotly[
    plot_ly,
    plotlyOutput,
    renderPlotly,
    layout,
    add_trace
  ],
  dplyr[
    filter,
    group_by,
    summarise,
    mutate,
    arrange,
    desc
  ],
  stats[reorder],
  tidyr[pivot_wider]
)

#' UI for composition bar chart
#' @export
ui_composition <- function(id) {
  ns <- NS(id)

  plotlyOutput(ns("composition_chart"), height = "100%")
}

#' UI for percent change chart
#' @export
ui_change <- function(id) {
  ns <- NS(id)

  plotlyOutput(ns("change_chart"), height = "100%")
}

#' @export
server <- function(id, filtered_df, selected_year, selected_island) {
  moduleServer(id, function(input, output, session) {

    # Composition bar chart (stacked by ecosystem type per moku)
    output$composition_chart <- renderPlotly({
      req(filtered_df())
      req(selected_year())

      dat <- filtered_df() |>
        filter(year == selected_year())

      if (nrow(dat) == 0) {
        return(
          plot_ly() |>
            layout(
              title = "No data available",
              xaxis = list(visible = FALSE),
              yaxis = list(visible = FALSE)
            )
        )
      }

      # Get subtitle text
      island_text <- if (is.null(selected_island()) || selected_island() == "") {
        "All Islands"
      } else {
        selected_island()
      }

      plot_ly(
        dat,
        x = ~moku_olelo,
        y = ~area_km2,
        color = ~ecosystem_type,
        type = "bar"
      ) |>
        layout(
          barmode = "stack",
          title = sprintf("Ecosystem Composition by Moku (%d) - %s", selected_year(), island_text),
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Area (km\u00b2)"),
          legend = list(orientation = "h", y = -0.3)
        )
    })

    # Percent change horizontal bar chart
    output$change_chart <- renderPlotly({
      req(filtered_df())

      dat <- filtered_df()

      if (nrow(dat) == 0) {
        return(
          plot_ly() |>
            layout(
              title = "No data available",
              xaxis = list(visible = FALSE),
              yaxis = list(visible = FALSE)
            )
        )
      }

      # Get years present
      years <- sort(unique(dat$year))

      if (length(years) < 2) {
        return(
          plot_ly() |>
            layout(
              title = "Need at least 2 years to compute change",
              xaxis = list(visible = FALSE),
              yaxis = list(visible = FALSE)
            )
        )
      }

      opening_year <- min(years)
      closing_year <- max(years)

      # Calculate change by ecosystem type
      dat_change <- dat |>
        group_by(ecosystem_type, year) |>
        summarise(area_km2 = sum(area_km2, na.rm = TRUE), .groups = "drop") |>
        pivot_wider(names_from = year, values_from = area_km2) |>
        mutate(
          net_change = .data[[as.character(closing_year)]] - .data[[as.character(opening_year)]],
          pct_change = (net_change / .data[[as.character(opening_year)]]) * 100
        ) |>
        arrange(pct_change)

      # Get subtitle text
      island_text <- if (is.null(selected_island()) || selected_island() == "") {
        "All Islands"
      } else {
        selected_island()
      }

      # Color based on positive/negative
      colors <- ifelse(dat_change$pct_change >= 0, "#238b45", "#d73027")

      plot_ly(
        dat_change,
        x = ~pct_change,
        y = ~reorder(ecosystem_type, pct_change),
        type = "bar",
        orientation = "h",
        marker = list(color = colors)
      ) |>
        layout(
          title = sprintf(
            "Percent Change in Ecosystem Extent (%d\u2013%d) - %s",
            opening_year, closing_year, island_text
          ),
          xaxis = list(title = "Change (%)"),
          yaxis = list(title = "")
        )
    })
  })
}
