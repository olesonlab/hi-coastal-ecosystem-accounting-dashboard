# Shared Spatial Utilities
# Common spatial operations used across data domains

# -----------------------------------------------------------------------------
# Geometry Validation & Repair
# -----------------------------------------------------------------------------

#' Fix invalid geometries and extract polygons
#' @param x sf object
#' @return sf object with valid polygon geometries
fix_geom <- function(x) {
  x |>
    sf::st_make_valid() |>
    sf::st_collection_extract("POLYGON", warn = FALSE)
}

#' Validate CRS matches expected
#' @param sf_obj sf object to check
#' @param expected_crs Expected CRS (EPSG code or crs object
#' @param name Name for error messages
#' @return TRUE if valid, stops with error if not
validate_crs <- function(sf_obj, expected_crs, name = "object") {
  actual_crs <- sf::st_crs(sf_obj)
  expected <- sf::st_crs(expected_crs)
  
  if (actual_crs != expected) {
    stop(
      sprintf(
        "%s has CRS %s, expected %s",
        name,
        actual_crs$epsg %||% "unknown",
        expected$epsg %||% "unknown"
      )
    )
  }
  
  TRUE
}

# -----------------------------------------------------------------------------
# Name Standardization (Hawaiian place names)
# -----------------------------------------------------------------------------

#' Standardize Hawaiian place names for matching
#' Removes kahakō (macrons) and ʻokina, converts to lowercase
#' @param x Character vector of names
#' @return Standardized character vector
standardize_name <- function(x) {
  x |>
    stringi::stri_trans_general("Latin-ASCII") |>
    stringr::str_replace_all("[ʻ''']", "") |>
    stringr::str_trim() |>
    stringr::str_squish() |>
    stringr::str_to_lower()
}