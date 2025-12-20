# Hawaii Coastal Ecosystem Accounting Dashboard

A modular Rhino/Shiny dashboard for exploring Hawaiʻi Coastal Ecosystem Accounting (CEA) outputs across multiple sections:
- Extents
- Conditions
- Uses (Fisheries Valuation, Recreation)

This repository currently contains a **working application scaffold** (routing + controlbar), with data products and visualizations under active development.

## Status

Implemented:
- Rhino app shell (bs4Dash)
- Sidebar navigation + scope routing
- Body routing (page modules)
- Controlbar routing (global + scope-specific placeholders)
- Routing spec (`app/logic/routing_spec.R`)
- Unit tests (`tests/testthat/`)

In progress:
- ETL / geospatial preprocessing (planned via `{targets}`)
- Data loading + summaries + real maps/plots/tables per section

## Architecture

This project is split into two layers:

### 1. ETL / preprocessing (pipeline)
Heavy data processing and geospatial operations are intended to run **outside** the interactive app (planned via `{targets}` in `_targets.R`) to produce stable, processed artifacts.

### 2. Application (Rhino/Shiny)
The Rhino app (in `app/`) focuses on:
- Loading processed outputs
- Applying fast filters
- Rendering interactive pages (maps/plots/tables)

Routing is scope-driven and centralized in `app/logic/routing_spec.R`.

## Project Structure (High level)

```text
. 📂 hi-coastal-ecosystem-accounting-dashboard
├── 📄 README.md                         # Repo overview, quickstart, reproducibility notes
├── 📄 LICENSE                           # License for reuse/distribution
├── 📄 _targets.R                        # {targets} pipeline entrypoint (ETL / preprocessing; runs outside the app)
├── 📄 config.yml                        # Project-level configuration (paths, options, etc.)
├── 📄 dependencies.R                    # Dependency helpers / documentation (project-specific)
├── 📄 manifest.json                     # Posit Connect Cloud deployment manifest (runtime + files)
├── 📄 rhino.yml                         # Rhino configuration
├── 📄 hi-coastal-ecosystem-accounting-dashboard.Rproj  # RStudio project file

├── 📂 app/                              # Rhino app source (UI + app-side logic)
│  ├── 📄 app.R                          # App entrypoint (calls rhino::app() / app launcher)
│  ├── 📄 main.R                         # Wiring diagram: state ownership + routing for body/controlbar by scope
│  ├── 📂 js/                            # Front-end JS (if needed)
│  │  └── 📄 index.js                    # JS entry (Rhino front-end hook)
│  ├── 📂 logic/                         # Shiny-independent logic (no UI)
│  │  ├── 📄 __init__.R                  # logic module exports / imports
│  │  ├── 📄 data_registry.R             # Canonical dataset registry (keys, metadata, references)
│  │  ├── 📄 data_sources.R              # Source definitions (files/URLs/services) for datasets
│  │  ├── 📄 routing_spec.R              # Central mapping of nav scopes -> page/control modules (testable)
│  │  ├── 📂 preprocess/                 # Preprocessing steps (transform raw/interim -> analysis-ready tables/layers)
│  │  │  ├── 📄 extents_prep.R
│  │  │  ├── 📄 conditions_prep.R
│  │  │  ├── 📄 fisheries_valuation_prep.R
│  │  │  └── 📄 recreation_prep.R
│  │  ├── 📂 spatial/                    # Spatial utilities (CRS, geoprocessing helpers)
│  │  │  ├── 📄 geoprocessing.R
│  │  │  └── 📄 projections.R
│  │  ├── 📂 summaries/                  # Aggregations/summaries used by the app (fast-to-load artifacts)
│  │  │  ├── 📄 extents_summaries.R
│  │  │  ├── 📄 conditions_summaries.R
│  │  │  ├── 📄 fisheries_valuation_summaries.R
│  │  │  └── 📄 recreation_summaries.R
│  │  └── 📂 validation/                 # Validation checks for each domain (row counts, schema, ranges, etc.)
│  │     ├── 📄 extents_validation.R
│  │     ├── 📄 conditions_validation.R
│  │     ├── 📄 fisheries_valuation_validation.R
│  │     └── 📄 recreation_validation.R
│  ├── 📂 static/                        # Static assets served by the app
│  │  └── 📄 favicon.ico
│  ├── 📂 styles/                        # App styling
│  │  └── 📄 main.scss
│  └── 📂 view/                          # UI modules (layout + pages + controlbar components)
│     ├── 📄 __init__.R                  # view module exports / imports
│     ├── 📂 layout/                     # Layout shell + navigation
│     │  ├── 📄 dashboard_shell.R        # bs4Dash page shell (slots for sidebar/body/controlbar)
│     │  ├── 📄 nav.R                    # Sidebar UI; emits selected scope key
│     │  └── 📄 nav_model.R              # Single source of truth: scope keys + labels (data-only)
│     ├── 📂 controls/                   # Controlbar UI modules (global + per-scope)
│     │  ├── 📄 controls_global.R        # Filters shared across all scopes
│     │  ├── 📄 controls_extents.R       # Extents-specific controls
│     │  ├── 📄 controls_conditions.R    # Conditions-specific controls
│     │  ├── 📄 controls_uses_fisheries_valuation.R
│     │  └── 📄 controls_uses_recreation.R
│     └── 📂 accounts/                   # Page modules by dashboard section (each section can have map/plots/table)
│        ├── 📂 extents/
│        │  ├── 📄 extents_page.R
│        │  ├── 📄 extents_map.R
│        │  ├── 📄 extents_plots.R
│        │  └── 📄 extents_table.R
│        ├── 📂 conditions/
│        │  ├── 📄 conditions_page.R
│        │  ├── 📄 conditions_map.R
│        │  ├── 📄 conditions_plots.R
│        │  └── 📄 conditions_table.R
│        └── 📂 uses/
│           ├── 📂 fisheries_valuation/
│           │  ├── 📄 fisheries_valuation_page.R
│           │  ├── 📄 fisheries_valuation_map.R
│           │  ├── 📄 fisheries_valuation_plots.R
│           │  └── 📄 fisheries_valuation_table.R
│           └── 📂 recreation/
│              ├── 📄 recreation_page.R
│              ├── 📄 recreation_map.R
│              ├── 📄 recreation_plots.R
│              └── 📄 recreation_table.R

├── 📂 data/                             # Data staging (typically gitignored except small demo artifacts)
│  ├── 📂 01_raw/                        # Raw inputs (as received)
│  ├── 📂 02_interim/                    # Intermediate outputs (ETL working files)
│  └── 📂 03_processed/                  # App-ready artifacts (summaries, simplified geometries, etc.)

├── 📂 documentation/                    # Project docs (architecture, onboarding, style guide)
│  ├── 📄 README.md
│  ├── 📄 ARCHITECTURE.md
│  ├── 📄 DATA_SOURCES.md
│  ├── 📄 FILTERS.md
│  ├── 📄 GETTING_STARTED.md
│  ├── 📄 GLOSSARY.md
│  ├── 📄 HOW_TO_EXTEND.md
│  ├── 📄 MODULE_INDEX.md
│  ├── 📄 STYLE_GUIDE.md
│  ├── 📄 TROUBLESHOOTING.md
│  ├── 📄 reproducibility_infrastructure.qmd
│  └── 📂 templates/                     # Copy/paste scaffolds for adding new modules consistently
│     ├── 📄 controls_template.R
│     ├── 📄 logic_template.R
│     └── 📄 page_template.R

├── 📂 renv/                             # Local dev environment management (not used by Connect Cloud runtime)
│  ├── 📄 activate.R
│  ├── 📄 renv.lock
│  └── 📂 library/
│     └── 📂 staging/

└── 📂 tests/                            # Automated testing
   ├── 📂 cypress/                        # End-to-end test scaffolding (browser tests)
   │  ├── 📄 cypress.config.js
   │  └── 📂 e2e/
   │     └── 📄 app.cy.js
   └── 📂 testthat/                       # Unit tests (R)
      ├── 📄 test-main.R
      └── 📄 test-routing.R
```

## Reproducibility and Dependencies

### Local development (`{renv}`)

This repo uses `renv` for local reproducibility.

```r
install.packages("renv")
renv::restore()
```

### Deployment (Posit Connect Cloud)

This app is deployed via Posit Connect Cloud. Connect Cloud uses the committed `manifest.json` to build the runtime environment.

If dependencies change, regenerate the manifest and commit it:

```r
install.packages("rsconnect")
rsconnect::writeManifest()
```

### Run Locally (`{rhino}`)

From the repository root:

```r
install.packages("rhino")
rhino::app()
```

### ETL Pipeline (`{targets}`)

The ETL pipeline will be executed via {targets} and will output processed artifacts consumed by the app.

```r
install.packages("targets")
targets::tar_make()
# Visualize pipeline 
targets::tar_visnetwork()
```

## Tests

Run unit tests:

```r
install.packages("testthat")
testthat::test_dir("tests/testthat")
```