# Module Index

This document catalogs all modules in the application, their purposes, and their relationships.

## Quick Reference

| Module | Layer | Status | Has Server |
|--------|-------|--------|------------|
| `main` | orchestration | ✅ implemented | ✅ |
| `dashboard_shell` | view/layout | ✅ implemented | ❌ |
| `nav` | view/layout | ✅ implemented | ✅ |
| `nav_model` | view/layout | ✅ implemented | — (data only) |
| `routing_spec` | logic | ✅ implemented | — (pure functions) |
| `extents_page` | view/accounts | 🔲 scaffold | ❌ |
| `conditions_page` | view/accounts | 🔲 scaffold | ❌ |
| `fisheries_valuation_page` | view/accounts | 🔲 scaffold | ❌ |
| `recreation_page` | view/accounts | 🔲 scaffold | ❌ |
| `controls_global` | view/controls | 🔲 scaffold | ❌ |
| `controls_extents` | view/controls | 🔲 scaffold | ❌ |
| `controls_conditions` | view/controls | 🔲 scaffold | ❌ |
| `controls_uses_fisheries_valuation` | view/controls | 🔲 scaffold | ❌ |
| `controls_uses_recreation` | view/controls | 🔲 scaffold | ❌ |

**Legend:** ✅ implemented | 🔲 scaffold | ❌ none | — not applicable

---

## Orchestration

### `app/main.R`

**Purpose:** App entrypoint and wiring diagram. Owns all reactive state and routes UI based on navigation scope.

**Exports:**
- `ui(id)` — Root UI function
- `server(id)` — Root server function

**State Owned:**
- `state$nav_scope` — Current navigation scope key

**Dependencies:**
- `dashboard_shell` — Layout structure
- `nav` — Sidebar navigation
- `controls_global` — Global filter controls
- `routing_spec` — Page and control module mappings

**Consumers:** Called by `app/app.R` (Rhino entrypoint)

---

## Layout Modules

### `app/view/layout/dashboard_shell.R`

**Purpose:** Defines the bs4Dash page structure with slots for sidebar, body, and controlbar. Pure layout, no logic.

**Exports:**
- `ui(id, sidebar, body, controlbar)` — Dashboard page with injected slot content

**Dependencies:**
- `bs4Dash` — Dashboard UI components

**Consumers:** `main.R`

---

### `app/view/layout/nav.R`

**Purpose:** Sidebar navigation UI and server. Emits the selected scope key to parent.

**Exports:**
- `ui(id)` — Sidebar menu with navigation items
- `server(id)` — Returns reactive with selected scope key

**Dependencies:**
- `nav_model` — Scope key constants
- `bs4Dash` — Sidebar menu components

**Consumers:** `main.R`

---

### `app/view/layout/nav_model.R`

**Purpose:** Single source of truth for navigation scope keys and labels. Data-only module.

**Exports:**
- `EXTENTS` — Scope key constant
- `CONDITIONS` — Scope key constant
- `USES_FISHERIES_VALUATION` — Scope key constant
- `USES_RECREATION` — Scope key constant
- `SCOPES` — Vector of all scope keys
- `SCOPE_LABELS` — Named vector mapping keys to display labels

**Dependencies:** None

**Consumers:** `nav.R`, `main.R`, `routing_spec.R`, tests

---

## Logic Modules

### `app/logic/routing_spec.R`

**Purpose:** Centralizes page and control module mappings for testability. Pure functions with no Shiny dependencies.

**Exports:**
- `page_modules_by_scope()` — Returns named list mapping scope keys to page modules
- `control_modules_by_scope()` — Returns named list mapping scope keys to control modules

**Dependencies:**
- `nav_model` — Scope key constants
- All page modules
- All control modules (except `controls_global`)

**Consumers:** `main.R`, tests

---

### `app/logic/data_registry.R` *(planned)*

**Purpose:** Canonical registry of dataset keys, metadata, and references.

---

### `app/logic/data_sources.R` *(planned)*

**Purpose:** Source definitions (file paths, URLs, services) for each dataset.

---

## Page Modules

Page modules render the main body content for each account type. All follow the same pattern.

### `app/view/accounts/extents/extents_page.R`

**Purpose:** Page-level UI for the Extents account. Will compose map, plots, and table components.

**Exports:**
- `ui(id)` — Page UI (currently placeholder)

**Status:** Scaffold only

**Planned Components:**
- `extents_map.R` — Leaflet map
- `extents_plots.R` — Summary visualizations
- `extents_table.R` — Data table

---

### `app/view/accounts/conditions/conditions_page.R`

**Purpose:** Page-level UI for the Conditions account.

**Exports:**
- `ui(id)` — Page UI (currently placeholder)

**Status:** Scaffold only

**Planned Components:**
- `conditions_map.R`
- `conditions_plots.R`
- `conditions_table.R`

---

### `app/view/accounts/uses/fisheries_valuation/fisheries_valuation_page.R`

**Purpose:** Page-level UI for the Fisheries Valuation account under Uses.

**Exports:**
- `ui(id)` — Page UI (currently placeholder)

**Status:** Scaffold only

**Planned Components:**
- `fisheries_valuation_map.R`
- `fisheries_valuation_plots.R`
- `fisheries_valuation_table.R`

---

### `app/view/accounts/uses/recreation/recreation_page.R`

**Purpose:** Page-level UI for the Recreation account under Uses.

**Exports:**
- `ui(id)` — Page UI (currently placeholder)

**Status:** Scaffold only

**Planned Components:**
- `recreation_map.R`
- `recreation_plots.R`
- `recreation_table.R`

---

## Control Modules

Control modules render filter inputs in the controlbar. Global controls appear for all scopes; scope-specific controls appear only for their respective pages.

### `app/view/controls/controls_global.R`

**Purpose:** Shared filters that apply across all dashboard sections (geography, time range).

**Exports:**
- `ui(id)` — Global filter UI (currently placeholder)

**Status:** Scaffold only

**Planned Inputs:**
- Island selector
- Moku selector
- Year range slider

**Consumers:** `main.R` (rendered for all scopes)

---

### `app/view/controls/controls_extents.R`

**Purpose:** Extents-specific filter controls.

**Exports:**
- `ui(id)` — Filter UI (currently placeholder)

**Status:** Scaffold only

**Planned Inputs:**
- Ecosystem type selector
- Domain toggle (terrestrial/marine)

---

### `app/view/controls/controls_conditions.R`

**Purpose:** Conditions-specific filter controls.

**Exports:**
- `ui(id)` — Filter UI (currently placeholder)

**Status:** Scaffold only

**Planned Inputs:**
- Condition indicator selector
- ECT group filter (Abiotic/Biotic/Landscape)

---

### `app/view/controls/controls_uses_fisheries_valuation.R`

**Purpose:** Fisheries Valuation-specific filter controls.

**Exports:**
- `ui(id)` — Filter UI (currently placeholder)

**Status:** Scaffold only

**Planned Inputs:**
- Sector toggle (commercial/non-commercial)
- Species group selector
- Value type (physical/monetary)

---

### `app/view/controls/controls_uses_recreation.R`

**Purpose:** Recreation-specific filter controls.

**Exports:**
- `ui(id)` — Filter UI (currently placeholder)

**Status:** Scaffold only

**Planned Inputs:**
- Site type selector
- Amenity filter
- Climate scenario selector

---

## Preprocessing Modules *(planned)*

Located in `app/logic/preprocess/`. Transform raw data to analysis-ready format.

| Module | Input | Output |
|--------|-------|--------|
| `extents_prep.R` | Raw extent rasters/vectors | Harmonized extent layers |
| `conditions_prep.R` | Raw condition indicators | Standardized condition dataset |
| `fisheries_valuation_prep.R` | HDAR landings, valuations | Joined fisheries dataset |
| `recreation_prep.R` | Site data, demand inputs | Recreation demand model inputs |

---

## Spatial Modules *(planned)*

Located in `app/logic/spatial/`. Geospatial utilities.

| Module | Purpose |
|--------|---------|
| `projections.R` | CRS definitions, transformation helpers |
| `geoprocessing.R` | Buffer, intersection, aggregation functions |

---

## Summary Modules *(planned)*

Located in `app/logic/summaries/`. Generate app-ready aggregations.

| Module | Output |
|--------|--------|
| `extents_summaries.R` | Area by ecosystem type, island, year |
| `conditions_summaries.R` | Indicator statistics by Moku |
| `fisheries_valuation_summaries.R` | Catch and value by area, species |
| `recreation_summaries.R` | Site-level metrics, accessibility scores |

---

## Validation Modules *(planned)*

Located in `app/logic/validation/`. Data quality checks.

| Module | Checks |
|--------|--------|
| `extents_validation.R` | Schema, CRS, coverage completeness |
| `conditions_validation.R` | Value ranges, missing data, temporal coverage |
| `fisheries_valuation_validation.R` | Join integrity, value bounds |
| `recreation_validation.R` | Site completeness, model input validity |

---

## Test Modules

### `tests/testthat/test-main.R`

**Coverage:**
- Nav model labels cover all scopes
- Routing spec returns valid modules for each scope

### `tests/testthat/test-routing.R`

**Coverage:**
- Routing spec covers all navigation scopes
- Page and control module lists are complete

---

## Module Dependency Graph

```
main.R
├── dashboard_shell
├── nav ─────────────────► nav_model
├── controls_global
└── routing_spec ────────► nav_model
    ├── extents_page
    ├── conditions_page
    ├── fisheries_valuation_page
    ├── recreation_page
    ├── controls_extents
    ├── controls_conditions
    ├── controls_uses_fisheries_valuation
    └── controls_uses_recreation
```

---

## Adding a New Module

### New Page Module

1. Create file: `app/view/accounts/<scope>/<scope>_page.R`
2. Follow header template (Purpose, Rules, Status)
3. Export `ui(id)` function
4. Register in `routing_spec.R`
5. Add to `app/view/__init__.R`

### New Control Module

1. Create file: `app/view/controls/controls_<scope>.R`
2. Follow header template
3. Export `ui(id)` function
4. Register in `routing_spec.R`
5. Add to `app/view/__init__.R`

### New Logic Module

1. Create file in appropriate `app/logic/` subdirectory
2. Follow header template
3. Export pure functions (no Shiny dependencies)
4. Add to `app/logic/__init__.R`

See `documentation/templates/` for starter files.