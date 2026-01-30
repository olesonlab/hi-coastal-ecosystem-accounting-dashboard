# app/logic/routing_spec.R
#
# Purpose
# - Centralizes the page + control mappings by scope for testability.
# - Keeps main.R focused on orchestration while letting testthat verify coverage.
#
# Rules
# - Data-only: return vectors/lists of module paths or identifiers.
# - No Shiny side effects, no data loading.

box::use(
  app/view/layout/nav_model[
    HOME,
    EXTENTS,
    CONDITIONS,
    USES_FISHERIES_VALUATION,
    USES_RECREATION
  ],
  app/view/tabs/home/home_page,
  app/view/tabs/extents/extents_page,
  app/view/tabs/conditions/conditions_page,
  app/view/tabs/uses/fisheries_valuation/fisheries_valuation_page,
  app/view/tabs/uses/recreation/recreation_page,
  app/view/controls/controls_extents,
  app/view/controls/controls_conditions,
  app/view/controls/controls_uses_fisheries_valuation,
  app/view/controls/controls_uses_recreation
)

#' @export
page_modules_by_scope <- function() {
  list(
    home = home_page,
    extents = extents_page,
    conditions = conditions_page,
    uses_fisheries_valuation = fisheries_valuation_page,
    uses_recreation = recreation_page
  )
}

#' @export
control_modules_by_scope <- function() {
  list(
    home = NULL,
    extents = controls_extents,
    conditions = controls_conditions,
    uses_fisheries_valuation = controls_uses_fisheries_valuation,
    uses_recreation = controls_uses_recreation
  )
}
