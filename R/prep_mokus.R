# Moku Layer Preprocessing
# Processing functions for moku (traditional Hawaiian land divisions) geometries
# The moku layer serves as the unit of analysis for all dashboard scopes

# -----------------------------------------------------------------------------
# Name Lookup Table
# -----------------------------------------------------------------------------

#' Build lookup table of standardized and display names from marine moku data
#' 
#' Creates a crosswalk between raw moku identifiers (name2) and both
#' standardized names (for joining) and ʻōlelo Hawaiʻi display names.
#' 
#' @param mokus_marine_raw Raw marine moku sf object (has moku_olelo field)
#' @return Tibble with name2, moku_olelo, moku, island_olelo, island columns
build_moku_names_lut <- function(mokus_marine_raw) {
  mokus_marine_raw |>
    janitor::clean_names() |>
    dplyr::select(name2, moku_olelo) |>
    dplyr::filter(!is.na(name2)) |>
    dplyr::mutate(
      moku_olelo = dplyr::na_if(stringr::str_squish(moku_olelo), "")
    ) |>
    tidyr::separate(
      col = moku_olelo,
      into = c("island_olelo", "moku_olelo"),
      sep = " ",
      extra = "merge",
      fill = "right",
      remove = FALSE
    ) |>
    dplyr::mutate(
      # Manual fixes for mokus missing ʻōlelo names in source data
      moku_olelo = dplyr::case_when(
        name2 == "MANA" ~ "Mana",
        name2 == "KAUPO" ~ "Kaupō",
        name2 == "KAHIKINUI" ~ "Kahikinui",
        TRUE ~ moku_olelo
      ),
      island_olelo = dplyr::case_when(
        name2 == "MANA" ~ "Kaua'i",
        name2 %in% c("KAUPO", "KAHIKINUI") ~ "Maui",
        TRUE ~ island_olelo
      ),
      moku = standardize_name(moku_olelo),
      island = standardize_name(island_olelo)
    ) |>
    dplyr::distinct(name2, .keep_all = TRUE) |>
    sf::st_drop_geometry()
}

# -----------------------------------------------------------------------------
# Geometry Processing
# -----------------------------------------------------------------------------

#' Attach standardized names to moku sf object
#' @param mokus_sf Moku sf object with name2 column
#' @param names_lut Lookup table from build_moku_names_lut()
#' @param realm Character: "Marine" or "Terrestrial"
#' @return sf object with standardized name columns
attach_moku_names <- function(mokus_sf, names_lut, realm) {
  mokus_sf |>
    janitor::clean_names() |>
    dplyr::mutate(realm = realm) |>
    dplyr::left_join(names_lut, by = "name2") |>
    dplyr::select(
      realm,
      name2,
      moku_olelo,
      moku,
      island_olelo,
      island,
      geometry
    )
}

#' Clean and transform moku shapefile
#' 
#' Full processing pipeline for raw moku shapefiles: selects columns,
#' filters invalid records, fixes geometries, attaches names, transforms CRS.
#' 
#' @param mokus_raw Raw moku sf object
#' @param names_lut Lookup table from build_moku_names_lut()
#' @param realm Character: "Marine" or "Terrestrial"
#' @param target_crs Target CRS (sf crs object or EPSG code)
#' @return Cleaned, transformed sf object
clean_mokus <- function(mokus_raw, names_lut, realm, target_crs) {
  keep_cols <- c("name2", "geometry")
  
  mokus_raw |>
    dplyr::select(dplyr::any_of(keep_cols)) |>
    dplyr::filter(!is.na(name2)) |>
    fix_geom() |>
    attach_moku_names(names_lut, realm = realm) |>
    sf::st_transform(target_crs)
}

#' Combine marine and terrestrial moku geometries
#' @param mokus_marine Cleaned marine moku sf
#' @param mokus_terrestrial Cleaned terrestrial moku sf
#' @return Combined sf object
combine_mokus <- function(mokus_marine, mokus_terrestrial) {
  dplyr::bind_rows(mokus_marine, mokus_terrestrial)
}