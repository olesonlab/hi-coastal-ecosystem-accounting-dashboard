# _targets.R
# ------------------------------------------------------------------------------
# CEA Dashboard Pipeline Setup
# ------------------------------------------------------------------------------

library(targets)
library(here)
library(readr)
library(glue)
library(purrr)
library(tibble)

tar_option_set(
  packages = c("tibble", "here", "readr", "glue", "purrr"),
  format = "qs"
)

# ------------------------------------------------------------------------------
# Environment-based configuration (from .Renviron)
# ------------------------------------------------------------------------------

# Pull values from .Renviron or fall back to defaults
user_name <- Sys.getenv("USER_NAME", Sys.info()[["user"]])
metadata_dir <- Sys.getenv("CEA_DASHBOARD_METADATA_DIR", here::here("data/_metadata"))

# Derived paths
log_path <- file.path(metadata_dir, "folder_structure_log.csv")
meta_path <- file.path(metadata_dir, "project_provenance.csv")

# ------------------------------------------------------------------------------
# Load project functions
# ------------------------------------------------------------------------------

tar_source()

# ------------------------------------------------------------------------------
# Targets pipeline
# ------------------------------------------------------------------------------

list(
  # 1️⃣ Create folders (always check)
  tar_target(
    initialize_structure,
    initialize_project_structure(user_name = user_name),
    cue = tar_cue(mode = "always")
  ),

  # 2️⃣ Write log files to metadata folder
  tar_target(
    export_folder_log,
    {
      # Write logs
      readr::write_csv(initialize_structure$folders, log_path)
      readr::write_csv(initialize_structure$metadata, meta_path)
      
      # Explicitly return the files
      output_files <- c(log_path, meta_path)
      return(output_files)
    },
    format = "file"
  ),

  # 3️⃣ Write README templates
  tar_target(
    create_readmes,
    write_folder_readmes(user_name = user_name),
    cue = tar_cue(mode = "always")
  )
)
