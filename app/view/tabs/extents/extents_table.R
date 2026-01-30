# app/view/tabs/extents/extents_table.R

# Purpose
# - GT table component for the Extents page.
# - Displays ecosystem extent accounting table with opening/closing values and change.

# Rules
# - Receives filtered data frame from parent (extents_page).
# - No data loading or filtering here; that happens in main.R.
# - IDs must be namespaced via NS(id).

# Imports
box::use(
  shiny[
    NS,
    moduleServer,
    req
  ],
  gt[
    gt,
    gt_output,
    render_gt,
    tab_header,
    tab_spanner,
    fmt_number,
    data_color,
    grand_summary_rows,
    cols_label
  ],
  scales[col_numeric],
  dplyr[
    filter,
    group_by,
    summarise,
    mutate,
    arrange,
    desc,
    select
  ],
  tidyr[pivot_wider]
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  gt_output(ns("table"))
}

#' @export
server <- function(id, filtered_df, selected_island) {
  moduleServer(id, function(input, output, session) {

    output$table <- render_gt({
      req(filtered_df())

      dat <- filtered_df()

      # Handle empty data
      if (nrow(dat) == 0) {
        return(
          data.frame(Message = "No data available for selected filters") |>
            gt()
        )
      }

      # Get years present in data
      years <- sort(unique(dat$year))

      if (length(years) < 2) {
        return(
          data.frame(Message = "Need at least 2 years to compute change") |>
            gt()
        )
      }

      opening_year <- min(years)
      closing_year <- max(years)

      # Build accounting table
      dat_account <- dat |>
        group_by(ecosystem_type, year) |>
        summarise(area_km2 = sum(area_km2, na.rm = TRUE), .groups = "drop") |>
        pivot_wider(names_from = year, values_from = area_km2)

      # Calculate net change and percent change
      dat_account <- dat_account |>
        mutate(
          net_change = .data[[as.character(closing_year)]] - .data[[as.character(opening_year)]],
          pct_change = (net_change / .data[[as.character(opening_year)]]) * 100
        ) |>
        arrange(desc(.data[[as.character(closing_year)]]))

      # Get subtitle text
      island_text <- if (is.null(selected_island()) || selected_island() == "") {
        "All Islands"
      } else {
        selected_island()
      }

      # Build GT table
      tbl <- dat_account |>
        gt() |>
        tab_header(
          title = "Ecosystem Extent Account",
          subtitle = sprintf("%s, %d\u2013%d", island_text, opening_year, closing_year)
        ) |>
        cols_label(
          ecosystem_type = "Ecosystem Type",
          net_change = "Net Change",
          pct_change = "Change (%)"
        )

      # Add year column labels dynamically
      year_cols <- as.character(years)
      if (length(year_cols) >= 1) {
        tbl <- tbl |>
          tab_spanner(
            label = "Extent (km\u00b2)",
            columns = year_cols
          )
      }

      tbl <- tbl |>
        tab_spanner(
          label = "Change",
          columns = c("net_change", "pct_change")
        ) |>
        fmt_number(
          columns = c(year_cols, "net_change"),
          decimals = 1
        ) |>
        fmt_number(
          columns = "pct_change",
          decimals = 2,
          force_sign = TRUE
        )

      # Add color coding for change columns
      if (any(!is.na(dat_account$net_change))) {
        net_range <- range(dat_account$net_change, na.rm = TRUE)
        pct_range <- range(dat_account$pct_change, na.rm = TRUE)

        tbl <- tbl |>
          data_color(
            columns = "net_change",
            fn = col_numeric(
              palette = c("#d73027", "#ffffbf", "#238b45"),
              domain = c(net_range[1], 0, net_range[2])
            )
          ) |>
          data_color(
            columns = "pct_change",
            fn = col_numeric(
              palette = c("#d73027", "#ffffbf", "#238b45"),
              domain = c(pct_range[1], 0, pct_range[2])
            )
          )
      }

      # Add summary row
      tbl <- tbl |>
        grand_summary_rows(
          columns = c(year_cols, "net_change"),
          fns = list(Total = ~ sum(., na.rm = TRUE)),
          fmt = ~ fmt_number(., decimals = 1)
        )

      tbl
    })
  })
}
