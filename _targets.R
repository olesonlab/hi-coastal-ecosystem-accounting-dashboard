# Hawaiʻi Coastal Ecosystem Accounting — Data Preprocessing Pipeline
# 
# Run with: targets::tar_make()
# Visualize: targets::tar_visnetwork()
# 
# Pipeline structure:
#   1. Moku layer (shared unit of analysis)
#   2. Extents data → joins to mokus
#   3. Conditions data → joins to mokus (TODO)
#   4. Fisheries data → joins to mokus (TODO)
#   5. Recreation data → joins to mokus (TODO)

library(targets)
library(tarchetypes)

# Source all helper functions from R/
tar_source("R/")

# -----------------------------------------------------------------------------
# Target Options
# -----------------------------------------------------------------------------

tar_option_set(
  packages = c(
    "fs", "here", "dplyr", "tidyr", "readr",
    "janitor", "stringr", "stringi", "glue", "sf"
  ),
  format = "rds",
  error = "continue"
)

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

config <- list(
  crs_target = 2784L,
  crs_web = 4326L,
  years = c(2013L, 2016L, 2019L)
)

# Input paths
paths_in <- list(
  # Moku shapefiles
  mokus_marine = "data/01_raw/mokus/mokus_marine_hi_himarc/mokus_marine_hi_himarc.shp",
  mokus_terrestrial = "data/01_raw/mokus/mokus_terrestrial_hi_himarc/mokus_terrestrial_hi_himarc.shp",
  
  # Extents CSVs
  extents_marine = "data/01_raw/extents/et_areas_per_moku_marine_hi.csv",
  extents_terrestrial = "data/01_raw/extents/et_areas_per_moku_terrestrial_hi.csv"
)

# Output paths
paths_out <- list(
  # Interim outputs (shared resources)
  moku_names_csv = "data/02_interim/moku_names_lut.csv",
  mokus_gpkg = "data/02_interim/mokus_combined.gpkg",
  
  # Processed outputs (dashboard-ready, by scope)
  extents_gpkg = "data/03_processed/extents/mokus_extents.gpkg",
  extents_csv = "data/03_processed/extents/mokus_extents.csv"
  
  # TODO: Add conditions, fisheries, recreation output paths
)

# =============================================================================
# Pipeline Definition
# =============================================================================

list(
  # ---------------------------------------------------------------------------
  # MOKU LAYER (shared across all scopes)
  # ---------------------------------------------------------------------------
  
  # Load raw shapefiles
  tar_target(
    mokus_marine_raw,
    read_sf_clean(paths_in$mokus_marine)
  ),
  
  tar_target(
    mokus_terrestrial_raw,
    read_sf_clean(paths_in$mokus_terrestrial)
  ),
  
  # Build name lookup table (from marine data which has ʻōlelo names)
  tar_target(
    moku_names_lut,
    build_moku_names_lut(mokus_marine_raw)
  ),
  
  # Export name lookup for reference
  tar_target(
    export_moku_names,
    export_csv(moku_names_lut, paths_out$moku_names_csv),
    format = "file"
  ),
  
  # Clean and transform mokus
  tar_target(
    mokus_marine,
    clean_mokus(mokus_marine_raw, moku_names_lut, "Marine", config$crs_web)
  ),
  
  tar_target(
    mokus_terrestrial,
    clean_mokus(mokus_terrestrial_raw, moku_names_lut, "Terrestrial", config$crs_web)
  ),
  
  # Combine into single layer
  tar_target(
    mokus_combined,
    combine_mokus(mokus_marine, mokus_terrestrial)
  ),
  
  # Export combined moku layer
  tar_target(
    export_mokus,
    export_gpkg(mokus_combined, paths_out$mokus_gpkg),
    format = "file"
  ),
  
  # ---------------------------------------------------------------------------
  # EXTENTS SCOPE
  # ---------------------------------------------------------------------------
  
  # Load extent area data
  tar_target(
    et_areas_marine,
    load_et_areas_marine(paths_in$extents_marine, config$years)
  ),
  
  tar_target(
    et_areas_terrestrial,
    load_et_areas_terrestrial(paths_in$extents_terrestrial)
  ),
  
  # Combine marine and terrestrial
  tar_target(
    et_areas_combined,
    combine_et_areas(et_areas_marine, et_areas_terrestrial)
  ),
  
  # Join to moku geometries
  tar_target(
    mokus_extents,
    join_mokus_extents(mokus_combined, et_areas_combined)
  ),
  
  # Export extents (GeoPackage for spatial, CSV for tabular)
  tar_target(
    export_extents_gpkg,
    export_gpkg(mokus_extents, paths_out$extents_gpkg),
    format = "file"
  ),
  
  tar_target(
    export_extents_csv,
    export_sf_as_csv(mokus_extents, paths_out$extents_csv),
    format = "file"
  )
  
  # ---------------------------------------------------------------------------
  # CONDITIONS SCOPE (TODO)
  # ---------------------------------------------------------------------------
  # tar_target(conditions_raw, ...),
  # tar_target(mokus_conditions, join_mokus_conditions(mokus_combined, ...)),
  # tar_target(export_conditions, export_gpkg(...)),
  
  # ---------------------------------------------------------------------------
  # FISHERIES SCOPE (TODO)
  # ---------------------------------------------------------------------------
  # tar_target(fisheries_raw, ...),
  # tar_target(mokus_fisheries, join_mokus_fisheries(mokus_combined, ...)),
  # tar_target(export_fisheries, export_gpkg(...)),
  
  # ---------------------------------------------------------------------------
  # RECREATION SCOPE (TODO)
  # ---------------------------------------------------------------------------
  # tar_target(recreation_raw, ...),
  # tar_target(mokus_recreation, join_mokus_recreation(mokus_combined, ...)),
  # tar_target(export_recreation, export_gpkg(...))
)