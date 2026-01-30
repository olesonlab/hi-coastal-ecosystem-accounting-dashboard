# Fisheries Valuation Data Preprocessing
# Processing functions for fisheries economic valuation data
# 
# TODO: Implement when fisheries data sources are defined
# 
# Expected functions:
# - load_fisheries_*()     : Load raw fisheries/catch data
# - clean_fisheries_*()    : Standardize species, units, values
# - join_mokus_fisheries() : Join to moku geometries

# -----------------------------------------------------------------------------
# Placeholder
# -----------------------------------------------------------------------------

#' Join moku geometries with fisheries valuation data
#' 
#' Creates the final spatial dataset for the Uses > Fisheries scope.
#' 
#' @param mokus_sf Combined moku sf object (marine realm only?)
#' @param fisheries Fisheries valuation tibble
#' @return sf object with fisheries data attached
join_mokus_fisheries <- function(mokus_sf, fisheries) {
  # TODO: Implement join logic
 
  # Note: May need to filter to marine realm only
  stop("join_mokus_fisheries() not yet implemented")
}