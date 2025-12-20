# Glossary

This glossary defines domain-specific and technical terms used throughout the Hawaiʻi Coastal Ecosystem Accounting Dashboard project.

---

## Ecosystem Accounting Terms

### Account
A structured record of stocks (assets) or flows (changes/transactions) for a specific aspect of ecosystems. This dashboard implements three account types: extent, condition, and ecosystem services (uses).

### CEA (Coastal Ecosystem Accounting)
The application of ecosystem accounting methods to coastal and marine environments. Tracks the extent, condition, and services provided by coastal ecosystems over time.

### Ecosystem Condition
The quality or health of an ecosystem, measured through biotic, abiotic, and landscape-level indicators. Condition accounts track how ecosystem health changes over time.

### Ecosystem Extent
The spatial area covered by an ecosystem type. Extent accounts track changes in ecosystem coverage (e.g., coral reef area, wetland hectares) over time.

### Ecosystem Services
The benefits that ecosystems provide to people. This dashboard tracks two service categories: fisheries (provisioning service) and recreation (cultural service).

### ECT (Ecosystem Condition Typology)
A hierarchical classification framework for organizing ecosystem condition indicators, defined by the UN SEEA. Groups include:
- **Group A: Abiotic** — Physical and chemical characteristics (soil, water quality, climate)
- **Group B: Biotic** — Species composition, structure, and function
- **Group C: Landscape** — Spatial patterns and connectivity

### Natural Capital
The stock of natural resources (ecosystems, species, water, minerals) that provide benefits to people. Ecosystem accounting quantifies natural capital in physical and monetary terms.

### SEEA (System of Environmental-Economic Accounting)
A UN statistical framework for integrating environmental and economic data. SEEA-EA (Ecosystem Accounting) provides standards for measuring ecosystem extent, condition, and services.

---

## Hawaiian Geographic Terms

### Ahupuaʻa
Traditional Hawaiian land division extending from mountain (mauka) to sea (makai), typically following watershed boundaries. Historically managed as integrated social-ecological units.

### Makai
Hawaiian directional term meaning "toward the sea."

### Mauka
Hawaiian directional term meaning "toward the mountain."

### MHI (Main Hawaiian Islands)
The eight largest islands in the Hawaiian archipelago: Hawaiʻi, Maui, Kahoʻolawe, Lānaʻi, Molokaʻi, Oʻahu, Kauaʻi, and Niʻihau. The geographic scope of this dashboard.

### Moku
Traditional Hawaiian district, larger than ahupuaʻa. Each island is divided into moku, which serve as the primary spatial unit for aggregating marine ecosystem data in this dashboard.

---

## Data Source Terms

### C-CAP (Coastal Change Analysis Program)
NOAA program providing nationally standardized land cover and change data for coastal regions.

### HDAR (Hawaiʻi Division of Aquatic Resources)
State agency managing Hawaiʻi's aquatic resources. Source of commercial marine landings data.

### HIMARC (Hawaiʻi Monitoring and Reporting Collaborative)
Collaborative effort providing benthic habitat maps for Hawaiian waters.

### LCMAP (Land Change Monitoring, Assessment, and Projection)
USGS program providing annual land cover and change data for the United States.

### NCRMP (National Coral Reef Monitoring Program)
NOAA program conducting standardized coral reef monitoring across U.S. jurisdictions.

### NWI (National Wetland Inventory)
U.S. Fish and Wildlife Service program mapping wetland extent and type.

### OSDS (On-site Sewage Disposal Systems)
Cesspools and septic systems. Nutrient flux from OSDS is a key indicator of anthropogenic stress on nearshore marine ecosystems.

### OTP (Ocean Tipping Points)
Research project providing modeled oceanographic and anthropogenic stress data for Hawaiian waters.

---

## Technical Terms (Application)

### box::use()
R package import system used by Rhino. Requires explicit imports (e.g., `shiny[NS, tagList]`) rather than loading entire packages with `library()`.

### bs4Dash
R package providing Bootstrap 4 dashboard components for Shiny, including sidebar navigation, controlbar, and card layouts.

### Controlbar
Right-side panel in bs4Dash containing filter controls. This dashboard renders global controls (shared across all pages) plus scope-specific controls.

### Module (Shiny)
A reusable, namespaced component consisting of a UI function and optional server function. Modules encapsulate UI and logic for testing and reuse.

### Namespace / NS
Shiny mechanism for isolating input/output IDs within modules. Prevents ID collisions when the same module is used multiple times.

### Reactive
A Shiny programming concept where values automatically update when their dependencies change. Reactives form a dependency graph that Shiny uses to determine what to re-execute.

### reactiveValues
A Shiny construct for storing mutable reactive state. This dashboard uses `reactiveValues` in `main.R` to hold navigation and filter state.

### Rhino
An R package providing an opinionated framework for building production-grade Shiny applications. Enforces modular structure with `logic/` and `view/` separation.

### Scope
In this dashboard, a scope identifies a navigation destination and determines which page and controls are rendered. Defined in `nav_model.R`.

### targets
An R package for pipeline orchestration. Defines a DAG (directed acyclic graph) of computational steps, caches results, and only re-runs steps when inputs change.

---

## Technical Terms (Geospatial)

### CRS (Coordinate Reference System)
A system for defining geographic locations. Different CRS use different projections, datums, and units. Data must be in a common CRS before spatial operations.

### Raster
A spatial data format representing the world as a grid of cells (pixels). Each cell stores a value (e.g., land cover class, temperature). Resolution refers to cell size.

### Vector
A spatial data format representing features as points, lines, or polygons with associated attributes. Examples: coastline (line), moku boundary (polygon), monitoring site (point).

### Resolution
For raster data, the size of each grid cell. This dashboard integrates data ranging from 2m (climate grids) to 500m (oceanographic models).

### Buffer
A zone of specified distance around a spatial feature. The recreation account uses 300m buffers around beach sites to calculate average coral cover and fish biomass.

### Geoprocessing
Spatial operations such as intersection, union, buffer, and aggregation. Heavy geoprocessing runs in the ETL pipeline; the app performs only lightweight operations.

---

## Technical Terms (Data Pipeline)

### DAG (Directed Acyclic Graph)
A graph structure where edges have direction and no cycles exist. The `{targets}` pipeline is a DAG where nodes are computational steps and edges are dependencies.

### ETL (Extract, Transform, Load)
A data pipeline pattern: extract data from sources, transform it (clean, join, aggregate), and load it into a destination. This dashboard's ETL runs via `{targets}`.

### Artifact
A file produced by the ETL pipeline and consumed by the application. Artifacts are stored in `data/03_processed/`.

### renv
An R package for dependency management. Creates a lockfile (`renv.lock`) recording exact package versions for reproducibility.

### Lockfile
A file (`renv.lock`) recording the exact versions of all R packages used in a project. Enables reproducible environments across machines.

---

## Abbreviations

| Abbreviation | Expansion |
|--------------|-----------|
| API | Application Programming Interface |
| CEA | Coastal Ecosystem Accounting |
| CML | Commercial Marine Landings |
| CRS | Coordinate Reference System |
| CSS | Cascading Style Sheets |
| DAG | Directed Acyclic Graph |
| E2E | End-to-End (testing) |
| ECT | Ecosystem Condition Typology |
| ETL | Extract, Transform, Load |
| JS | JavaScript |
| MHI | Main Hawaiian Islands |
| NDVI | Normalized Difference Vegetation Index |
| PAR | Photosynthetically Active Radiation |
| SCSS | Sassy CSS (CSS preprocessor) |
| SEEA | System of Environmental-Economic Accounting |
| SSP | Shared Socioeconomic Pathway |
| SST | Sea Surface Temperature |
| UI | User Interface |

---

## References

United Nations. (2021). *System of Environmental-Economic Accounting—Ecosystem Accounting (SEEA EA)*. United Nations. https://seea.un.org/ecosystem-accounting

Hawaiʻi Office of Planning. *Ahupuaʻa and Moku boundaries*. State of Hawaiʻi.

NOAA Coral Reef Conservation Program. *National Coral Reef Monitoring Program*. https://www.coris.noaa.gov/monitoring/