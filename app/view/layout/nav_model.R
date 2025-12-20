# app/view/layout/nav_model.R

# Purpose
# - Single source of truth for dashboard navigation "scope keys".
# - These keys drive routing in main.R (which page + which controlbar controls are shown).

# Rules
# - Keep this file data-only: constants/vectors only.
# - No Shiny code, no bs4Dash code, no reactivity, no data loading.
# - Update only when adding a new page
#   - If new page added, update SCOPES and SCOPE_LABELS together.

EXTENTS = "extents"
CONDITIONS = "conditions"
USES_FISHERIES_VALUATION = "uses_fisheries_valuation"
USES_RECREATION = "uses_recreation"

SCOPES = c(EXTENTS, CONDITIONS, USES_FISHERIES_VALUATION, USES_RECREATION)

SCOPE_LABELS = c(
  extents = "Extents",
  conditions = "Conditions",
  uses_fisheries_valuation = "Uses > Fisheries Valuation",
  uses_recreation = "Uses > Recreation"
)
