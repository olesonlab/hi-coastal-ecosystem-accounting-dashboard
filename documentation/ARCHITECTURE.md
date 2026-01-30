# Architecture

This document describes the system design of the Hawaiʻi Coastal Ecosystem Accounting Dashboard, including the separation of concerns, state management patterns, and routing architecture.

## Design Principles

1. **ETL/App Separation** — Heavy data processing runs outside the interactive app via a `{targets}` pipeline. The Shiny app loads pre-processed artifacts and applies lightweight filters.

2. **Parent-Owned State** — All reactive state lives in `main.R`. Child modules are stateless UI factories that receive data and emit events.

3. **Testable Routing** — Navigation logic is centralized in `routing_spec.R` as pure functions, enabling unit tests without spinning up Shiny.

4. **UI/Logic Separation** — The `view/` directory contains UI modules only. Business logic, data transformations, and validation live in `logic/`.

---

## System Layers

```
┌─────────────────────────────────────────────────────────────────┐
│                        User Interface                           │
│  ┌──────────┐  ┌──────────────────────┐  ┌──────────────────┐  │
│  │ Sidebar  │  │        Body          │  │    Controlbar    │  │
│  │  (nav)   │  │   (routed pages)     │  │ (global + scope) │  │
│  └──────────┘  └──────────────────────┘  └──────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Orchestration (main.R)                     │
│  • Owns reactive state (nav_scope, filters)                     │
│  • Wires layout slots                                           │
│  • Routes body/controlbar based on nav_scope                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Routing (routing_spec.R)                    │
│  • Maps scope keys → page modules                               │
│  • Maps scope keys → control modules                            │
│  • Pure functions, no Shiny dependencies                        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        Logic Layer                              │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌───────────┐ │
│  │ preprocess │  │  spatial   │  │ summaries  │  │validation │ │
│  └────────────┘  └────────────┘  └────────────┘  └───────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      ETL Pipeline ({targets})                   │
│  • Runs outside the app                                         │
│  • Produces artifacts in data/03_processed/                     │
│  • DAG-based, cached, reproducible                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Data Storage                            │
│  data/01_raw/  →  data/02_interim/  →  data/03_processed/       │
└─────────────────────────────────────────────────────────────────┘
```

---

## State Management

### Philosophy

Shiny applications can become difficult to debug when state is scattered across modules. This dashboard follows a **centralized state** pattern where `main.R` owns all reactive state.

### Current State Structure

```r
state <- shiny::reactiveValues(
  # Navigation
  nav_scope = HOME,

  # Applied filter values (updated on "Apply Filters" click)
  # These use the filter key columns (island, moku), not the display columns (olelo)
  applied_island = filter_choices$islands[1],
  applied_moku = filter_choices$mokus[1],
  applied_year = max(filter_choices$years),
  applied_realm = filter_choices$realms[1],
  applied_ecosystem_type = filter_choices$ecosystem_types[1]
)
```

### State Flow

```
User clicks sidebar
        │
        ▼
nav$server() emits selected scope
        │
        ▼
main.R observeEvent updates state$nav_scope
        │
        ▼
output$body re-renders with new page module
output$controlbar re-renders with new controls
```

---

## Routing Architecture

### Why Centralized Routing?

Decoupling navigation logic from UI code provides:

1. **Testability** — `routing_spec.R` can be unit tested without Shiny
2. **Single source of truth** — Adding a page means updating one file
3. **Explicit dependencies** — All page/control modules are imported in one place

### Navigation Model

`nav_model.R` defines the canonical scope keys:

```r
SCOPES = c("extents", "conditions", "uses_fisheries_valuation", "uses_recreation")
```

These keys are used throughout the app to identify which page and controls to render.

### Routing Spec

`routing_spec.R` maps scope keys to modules:

```r
page_modules_by_scope <- function() {
  stats::setNames(
    list(extents_page, conditions_page, fisheries_valuation_page, recreation_page),
    SCOPES
  )
}

control_modules_by_scope <- function() {
  stats::setNames(
    list(controls_extents, controls_conditions, controls_uses_fisheries_valuation, controls_uses_recreation),
    SCOPES
  )
}
```

### Adding a New Page

1. Add scope key to `nav_model.R`
2. Create page module in `view/accounts/`
3. Create controls module in `view/controls/`
4. Register both in `routing_spec.R`
5. Add menu item in `nav.R`
6. Tests automatically verify coverage

---

## Module Conventions

### File Header Standard

Every module includes a standardized header:

```r
# Purpose
# - [What this module does]

# Rules
# - [Constraints and boundaries]

# Current status
# - [What's implemented vs. planned]
```

### UI Module Pattern

```r
box::use(
  shiny[NS, tagList, ...]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(...)
}
```

### Server Module Pattern (when needed)

```r
#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # Return reactive if emitting values
    shiny::reactive({ ... })
  })
}
```

---

## Directory Structure Rationale

### `app/logic/` — Shiny-Independent Code

Contains pure R functions with no UI or reactivity:

| Subdirectory | Purpose |
|--------------|---------|
| `preprocess/` | Transform raw data to analysis-ready format |
| `spatial/` | CRS transformations, geoprocessing utilities |
| `summaries/` | Aggregations consumed by the app |
| `validation/` | Schema checks, range validation, row counts |

### `app/view/` — UI Modules Only

Contains Shiny UI code organized by function:

| Subdirectory | Purpose |
|--------------|---------|
| `layout/` | Dashboard shell, navigation, scope definitions |
| `tabs/` | Page modules for each account type |
| `controls/` | Controlbar modules (global + scope-specific); currently placeholders |

### `data/` — Staged Data Artifacts

| Subdirectory | Contents |
|--------------|----------|
| `01_raw/` | Original data as received (read-only) |
| `02_interim/` | ETL working files (intermediate outputs) |
| `03_processed/` | App-ready artifacts (summaries, simplified geometries) |

---

## ETL Pipeline

### Design Goals

1. **Reproducibility** — Any team member can regenerate outputs from raw data
2. **Caching** — Only re-run steps when inputs change
3. **Dependency tracking** — DAG ensures correct execution order

### Pipeline Structure (Planned)

Example of helper functions in `R/`:

```r
# R/utils_io.R
#' Read and clean shapefile
#' @param path Path to shapefile
#' @return sf object with cleaned column names
read_sf_clean <- function(path) {

  stopifnot(fs::file_exists(path))
 
  sf::st_read(path, quiet = TRUE) |>
    janitor::clean_names()
}
```

Targets pipeline:

```r
# _targets.R
list(
  tar_target()
)
```

### App Integration

The Shiny app loads only from `data/03_processed/`:

```r
# In app startup or logic modules
```

---

## Testing Strategy

### Unit Tests (`tests/testthat/`)

| Test File | Coverage |
|-----------|----------|
| `test-main.R` | Nav model completeness, routing spec validity |
| `test-routing.R` | All scopes have page and control modules |

### End-to-End Tests (`tests/cypress/`)

Planned browser tests for:
- Navigation between all pages
- Filter interactions
- Map/plot rendering

### Running Tests

```bash
# Unit tests
Rscript -e "testthat::test_dir('tests/testthat')"

# E2E tests (app must be running)
cd tests/cypress && npx cypress open
```

---

| Component    | Choice              | Rationale                                                                                                                                                                                    |
| ------------ | ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Framework    | Rhino + Shiny for R | **Shiny** provides the reactive web application runtime and server model; **Rhino** sits on top to enforce modular structure, application conventions, and explicit imports via `box::use()` |
| UI Library   | bs4Dash             | Bootstrap 4–based dashboard components with layout primitives and controlbar support, integrated into Shiny UI                                                                               |
| Pipeline     | targets             | DAG-based pipeline with caching and tight integration into the R ecosystem for reproducible data workflows                                                                                   |
| Dependencies | renv                | Lockfile-based dependency management to ensure reproducible local and deployed environments                                                                                                  |
| Deployment   | Posit Connect       | Managed hosting for Shiny applications with manifest-based builds and CI-friendly deployment                                                                                                 |

---

## Future Considerations