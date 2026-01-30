# Extents Data Preprocessing
# Processing functions for ecosystem type extent/area data

# -----------------------------------------------------------------------------
# Load & Clean
# -----------------------------------------------------------------------------

#' Load and clean marine ecosystem type areas
#' 
#' Marine data is static across years in source, so we cross with analysis years.
#' 
#' @param path Path to CSV file
#' @param years Vector of years to cross with data
#' @return Tibble with name2, ecosystem_type, area_km2, year, realm
load_et_areas_marine <- function(path, years) {
  read_csv_clean(path) |>
    # Drop any unnamed index columns (e.g., ...1 from row numbers)
    dplyr::select(-dplyr::starts_with("...")) |>
    dplyr::select(
      name2 = moku,
      ecosystem_type = value,
      area_km2 = area_km_2
    ) |>
    tidyr::crossing(year = years) |>
    dplyr::mutate(
      realm = "Marine",
      year = as.integer(year)
    )
}

#' Load and clean terrestrial ecosystem type areas
#' 
#' Terrestrial data is in wide format with year column, requires pivoting.
#' Ecosystem type names need standardization.
#' 
#' @param path Path to CSV file
#' @return Tibble with name2, ecosystem_type, area_km2, year, realm
load_et_areas_terrestrial <- function(path) {
  read_csv_clean(path) |>
    tidyr::pivot_longer(
      cols = -c(name2, year),
      names_to = "ecosystem_type",
      values_to = "area_km2"
    ) |>
    dplyr::mutate(
      # Standardize ecosystem type names
      ecosystem_type = stringr::str_to_title(gsub("_", " ", ecosystem_type)),
      ecosystem_type = dplyr::case_when(
        ecosystem_type == "Grass Shrub" ~ "Grass/Shrub",
        ecosystem_type == "Beaches Dunes" ~ "Beaches/Dunes",
        TRUE ~ ecosystem_type
      ),
      realm = "Terrestrial"
    ) |>
    # Aggregate any duplicates (shouldn't exist, but defensive)
    dplyr::group_by(name2, year, ecosystem_type, realm) |>
    dplyr::summarise(
      area_km2 = mean(area_km2, na.rm = TRUE),
      .groups = "drop"
    )
}

# -----------------------------------------------------------------------------
# Combine & Join
# -----------------------------------------------------------------------------

#' Combine marine and terrestrial extent areas
#' @param et_marine Marine extent areas tibble
#' @param et_terrestrial Terrestrial extent areas tibble
#' @return Combined tibble
combine_et_areas <- function(et_marine, et_terrestrial) {
  dplyr::bind_rows(et_marine, et_terrestrial)
}

#' Join moku geometries with extent area data
#' 
#' Creates the final spatial dataset for the Extents scope.
#' 
#' @param mokus_sf Combined moku sf object
#' @param et_areas Combined extent areas tibble
#' @return sf object with extent areas attached
join_mokus_extents <- function(mokus_sf, et_areas) {
  dplyr::left_join(
    mokus_sf,
    et_areas,
    by = c("name2", "realm")
  )
}