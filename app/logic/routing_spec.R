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
  app/view/layout/nav_model[SCOPES],
  app/view/accounts/extents/extents_page,
  app/view/accounts/conditions/conditions_page,
  app/view/accounts/uses/fisheries_valuation/fisheries_valuation_page,
  app/view/accounts/uses/recreation/recreation_page,
  app/view/controls/controls_extents,
  app/view/controls/controls_conditions,
  app/view/controls/controls_uses_fisheries_valuation,
  app/view/controls/controls_uses_recreation
)

#' @export
page_modules_by_scope <- function() {
  stats::setNames(
    list(
      extents_page,
      conditions_page,
      fisheries_valuation_page,
      recreation_page
    ),
    SCOPES
  )
}

#' @export
control_modules_by_scope <- function() {
  stats::setNames(
    list(
      controls_extents,
      controls_conditions,
      controls_uses_fisheries_valuation,
      controls_uses_recreation
    ),
    SCOPES
  )
}
