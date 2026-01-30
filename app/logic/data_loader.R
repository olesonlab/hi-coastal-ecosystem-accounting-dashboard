# app/logic/data_loader.R

# Purpose
# - Loads processed data from the targets pipeline for use in the Shiny app.
# - Provides functions to read spatial (sf) and tabular data.
# - Data is loaded once at app startup and cached in main.R reactiveValues.

# Rules
# - Read-only: do not modify data files.
# - No Shiny reactivity here; this is pure R functions.
# - Returns data frames/sf objects for main.R to store in state.

# Imports
box::use(
  sf[st_read],
  readr[read_csv],
  dplyr[filter, pull, distinct, arrange],
  here[here]
)

#' Load extents data as sf object (with geometry)
#' @return sf object with extents data
#' @export
load_extents_sf <- function() {
  st_read(
    "data/03_processed/extents/mokus_extents.gpkg",
    quiet = TRUE
  )
}

#' Load extents data as tibble (without geometry)
#' @return tibble with extents data
#' @export
load_extents_df <- function() {
  read_csv(
    "data/03_processed/extents/mokus_extents.csv",
    show_col_types = FALSE
  )
}

#' Get unique filter values from extents data
#' Returns named vectors where names are display text (olelo) and values are filter keys
#' @param extents_df Extents data frame
#' @return List of named vectors for each filter dimension
#' @export
get_filter_choices <- function(extents_df) {
  # Islands: value = island, display = island_olelo
  island_lookup <- extents_df |>
    distinct(island, island_olelo) |>
    arrange(island_olelo)
  islands <- stats::setNames(island_lookup$island, island_lookup$island_olelo)

  # Mokus: value = moku, display = moku_olelo
  moku_lookup <- extents_df |>
    distinct(moku, moku_olelo) |>
    arrange(moku_olelo)
  mokus <- stats::setNames(moku_lookup$moku, moku_lookup$moku_olelo)

  # Years (no display transformation needed)
  years <- sort(unique(extents_df$year))

  # Ecosystem types (no display transformation needed)
  ecosystem_types <- sort(unique(extents_df$ecosystem_type))

  # Realms (no display transformation needed)
  realms <- sort(unique(extents_df$realm))

  list(
    islands = islands,
    mokus = mokus,
    years = years,
    ecosystem_types = ecosystem_types,
    realms = realms
  )
}

#' Get mokus for a given island (returns named vector)
#' @param extents_df Extents data frame
#' @param island Selected island (island column value, not olelo)
#' @return Named vector: names = moku_olelo (display), values = moku (filter key)
#' @export
get_mokus_for_island <- function(extents_df, island) {
  if (is.null(island) || length(island) == 0 || island == "") {
    moku_lookup <- extents_df |>
      distinct(moku, moku_olelo) |>
      arrange(moku_olelo)
  } else {
    moku_lookup <- extents_df |>
      filter(island == !!island) |>
      distinct(moku, moku_olelo) |>
      arrange(moku_olelo)
  }

  stats::setNames(moku_lookup$moku, moku_lookup$moku_olelo)
}

#' Get ecosystem types for a given realm
#' @param extents_df Extents data frame
#' @param realm Selected realm ("Marine" or "Terrestrial")
#' @return Character vector of ecosystem types for the realm
#' @export
get_ecosystem_types_for_realm <- function(extents_df, realm) {
  if (is.null(realm) || length(realm) == 0 || realm == "") {
    return(sort(unique(extents_df$ecosystem_type)))
  }

  extents_df |>
    filter(realm == !!realm) |>
    pull(ecosystem_type) |>
    unique() |>
    sort()
}

########################
# Fisheries Data Loading
########################

#' Load commercial fisheries data
#' @return tibble with commercial fisheries data
#' @export
load_fisheries_commercial <- function() {
  read_csv(
    here("data", "03_processed", "fisheries", "20250619_tidied_comm_ev.csv"),
    show_col_types = FALSE
  )
}

#' Load non-commercial fisheries data
#' @return tibble with non-commercial fisheries data
#' @export
load_fisheries_noncommercial <- function() {
  read_csv(
    here("data", "03_processed", "fisheries", "20250619_tidied_noncomm_ev.csv"),
    show_col_types = FALSE
  )
}

#' Get unique filter values from fisheries data
#' Returns named vectors for filter dropdowns
#' @param comm_df Commercial fisheries data frame
#' @param noncomm_df Non-commercial fisheries data frame
#' @return List of vectors for each filter dimension
#' @export
get_fisheries_filter_choices <- function(comm_df, noncomm_df) {
  # Islands: combine county (comm) and island (noncomm)
  # Commercial uses "county", non-commercial uses "island" - both are Hawaii county names
  comm_islands <- unique(comm_df$county)
  noncomm_islands <- unique(noncomm_df$island)
  islands <- sort(unique(c(comm_islands, noncomm_islands)))

  # Ecosystem types from both datasets
  ecosystem_types <- sort(unique(c(
    unique(comm_df$ecosystem_type),
    unique(noncomm_df$ecosystem_type)
  )))

  # Species groups from both datasets
  species_groups <- sort(unique(c(
    unique(comm_df$species_group),
    unique(noncomm_df$species_group)
  )))

  # Years from both datasets
  years <- sort(unique(c(
    unique(comm_df$year),
    unique(noncomm_df$year)
  )))

  list(
    islands = islands,
    ecosystem_types = ecosystem_types,
    species_groups = species_groups,
    years = years
  )
}
