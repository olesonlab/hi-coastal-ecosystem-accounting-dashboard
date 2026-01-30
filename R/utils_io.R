# Shared I/O Utilities
# Read, write, and export helpers used across all data domains

# -----------------------------------------------------------------------------
# Read Helpers
# -----------------------------------------------------------------------------

#' Read and clean shapefile
#' @param path Path to shapefile
#' @return sf object with cleaned column names
read_sf_clean <- function(path) {

  stopifnot(fs::file_exists(path))
 
  sf::st_read(path, quiet = TRUE) |>
    janitor::clean_names()
}

#' Read CSV with clean names
#' @param path Path to CSV file
#' @return Tibble with cleaned column names
read_csv_clean <- function(path) {
  stopifnot(fs::file_exists(path))
  
  readr::read_csv(path, show_col_types = FALSE, name_repair = "minimal") |>
    janitor::clean_names()
}

# -----------------------------------------------------------------------------
# Export Helpers
# -----------------------------------------------------------------------------

#' Export sf object to GeoPackage
#' @param sf_obj sf object to export
#' @param path Output path for .gpkg file
#' @param layer_name Optional layer name (defaults to filename without extension
#' @return Path to exported file (for targets file tracking)
export_gpkg <- function(sf_obj, path, layer_name = NULL) {
  # Ensure output directory exists
 
  fs::dir_create(fs::path_dir(path), recurse = TRUE)
  
  # Default layer name from filename
 
  if (is.null(layer_name)) {
    layer_name <- fs::path_ext_remove(fs::path_file(path))
  }
  
  sf::st_write(
    sf_obj,
    path,
    layer = layer_name,
    delete_dsn = TRUE,
    quiet = TRUE
  )
  
  path
}

#' Export tibble/data.frame to CSV
#' @param df Data frame to export
#' @param path Output path for .csv file
#' @return Path to exported file (for targets file tracking)
export_csv <- function(df, path) {
  fs::dir_create(fs::path_dir(path), recurse = TRUE)
  readr::write_csv(df, path)
  path
}

#' Export sf object to CSV (drops geometry)
#' @param sf_obj sf object to export
#' @param path Output path for .csv file
#' @return Path to exported file (for targets file tracking)
export_sf_as_csv <- function(sf_obj, path) {
  fs::dir_create(fs::path_dir(path), recurse = TRUE)
  
 
  sf_obj |>
    sf::st_drop_geometry() |>
    readr::write_csv(path)
  
  path
}