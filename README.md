# Hawaiʻi Coastal Ecosystem Accounting Dashboard

An interactive platform for exploring natural capital accounts across the Main Hawaiian Islands, integrating 30+ terrestrial and marine datasets to visualize ecosystem extents, conditions, and service flows.

**[Live Demo](https://olesonlab-mhi-coastal-ecosystem-accounting-dashboard.share.connect.posit.cloud)** · **[Documentation](documentation/)** · **[Oleson Lab](https://www.olesonlab.org/)**

---

## What This Does

| Account | Description |
|---------|-------------|
| **Extents** | Spatial coverage of 16 ecosystem types (land cover, benthic habitats) |
| **Conditions** | 30+ health indicators across terrestrial and marine ecosystems |
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
│  • Heavy geospatial processing                               │
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
├── documentation/    # Architecture, data sources, glossary
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
| Framework | Rhino + bs4Dash |
| Pipeline | targets |
| Dependencies | renv |
| Testing | testthat, Cypress |
| Deployment | Posit Connect |

## Documentation

| Document | Description |
|----------|-------------|
| [ARCHITECTURE](documentation/ARCHITECTURE.md) | System design and data flow |
| [DATA_SOURCES](documentation/DATA_SOURCES.md) | Dataset specifications |
| [MODULE_INDEX](documentation/MODULE_INDEX.md) | Module reference |
| [GLOSSARY](documentation/GLOSSARY.md) | Domain and technical terms |

## License

[MIT](LICENSE)

## Acknowledgments

Developed at [Oleson Lab](https://www.olesonlab.org/), Department of Natural Resources and Environmental Management, University of Hawaiʻi at Mānoa.