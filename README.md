# Hawaiʻi Coastal Ecosystem Accounting Dashboard

An interactive platform for exploring natural capital accounts across the Main Hawaiian Islands, integrating terrestrial and marine datasets to visualize ecosystem extents, conditions, and service flows.

**[Live Demo]([https://olesonlab-mhi-coastal-ecosystem-accounting-dashboard.share.connect.posit.cloud](https://olesonlab-hi-coastal-ecosystem-accounting-dashboard.share.connect.posit.cloud))** · **[Documentation](documentation/)** · **[Oleson Lab](https://www.olesonlab.org/)**

---

## What This Does

| Account | Description |
|---------|-------------|
| **Extents** | Spatial coverage of ecosystem types (terrestrial, marine) |
| **Conditions** | Health indicators across terrestrial and marine ecosystems |
| **Uses** | Ecosystem service valuations for fisheries and coastal recreation |

## Architecture

```
┌──────────────────────────────────────────────────────────────┐
│  Shiny App (Rhino)                                           │
│  • Loads pre-processed artifacts                             │
│  • Applies filters, renders maps/plots/tables                │
└──────────────────────────────────────────────────────────────┘
                              ▲
                              │ reads from
┌──────────────────────────────────────────────────────────────┐
│  ETL Pipeline ({targets})                                    │
│  • Produces cached, reproducible artifacts                   │
└──────────────────────────────────────────────────────────────┘
```

See [ARCHITECTURE.md](documentation/ARCHITECTURE.md) for system design details.

## Project Structure

```
├── app/
│   ├── logic/        # Data processing, validation, routing
│   └── view/         # UI modules (pages, controls, layout)
├── data/             # 01_raw → 02_interim → 03_processed
├── documentation/    # Architecture, data sources/inventory
├── tests/            # testthat (unit), Cypress (e2e)
└── _targets.R        # ETL pipeline definition
```

## Quick Start

```bash
git clone https://github.com/olesonlab/hi-coastal-ecosystem-accounting-dashboard.git
cd hi-coastal-ecosystem-accounting-dashboard

# Restore dependencies
Rscript -e "renv::restore()"

# Run ETL pipeline
Rscript -e "targets::tar_make()"

# Launch app
Rscript -e "rhino::app()"
```

## Tech Stack

| Component | Tool |
|-----------|------|
| Framework | [Rhino](https://appsilon.github.io/rhino/) + [Shiny for R](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/) |
| UI | [bs4Dash](https://bs4dash.rinterface.com/) |
| Pipeline | [targets](https://books.ropensci.org/targets/) |
| Dependencies | [renv](https://rstudio.github.io/renv/) |
| Testing | [testthat](https://testthat.r-lib.org/index.html), [Cypress](https://www.cypress.io/#create) |
| Deployment | [Posit Connect](https://connect.posit.cloud/) |

## Documentation

| Document | Description |
|----------|-------------|
| [ARCHITECTURE](documentation/ARCHITECTURE.md) | System design and data flow |
| [DATA_SOURCES](documentation/DATA_SOURCES.md) | Dataset specifications |

## License

[MIT](LICENSE)

## Acknowledgments

Developed at [Oleson Lab](https://www.olesonlab.org/), Department of Natural Resources and Environmental Management, University of Hawaiʻi at Mānoa.
