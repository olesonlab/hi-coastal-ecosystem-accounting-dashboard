# Data Sources

This document catalogs all datasets integrated into the Hawaiʻi Coastal Ecosystem Accounting Dashboard. Data are organized by account type following the UN System of Environmental-Economic Accounting (SEEA) framework.

## Overview

| Account | Datasets | Temporal Range | Spatial Coverage |
|---------|----------|----------------|------------------|
| Extents | 16 ecosystem types | 2000–2020 | Main Hawaiian Islands |
| Conditions (Terrestrial) | 15 indicators | 1990–present | Land areas |
| Conditions (Marine) | 18 indicators | 2000–2019 | Nearshore waters |
| Fisheries Valuation | Commercial + non-commercial | Varies | State waters |
| Recreation | 10+ input layers | 2017–2020 | Coastal sites |

---

## 1. Ecosystem Extent Accounts

Extent accounts track the spatial coverage of ecosystem types over time.

| Ecosystem Type | Date | Data Source | Format |
|----------------|------|-------------|--------|
| Developed | 2000–2020 | USGS Land Change Monitoring, Assessment, and Projection (LCMAP) | Raster (30m) |
| Grass/Shrub | 2000–2020 | USGS LCMAP | Raster (30m) |
| Tree Cover | 2000–2020 | USGS LCMAP | Raster (30m) |
| Estuarine Wetland | 2000–2020 | USGS LCMAP | Raster (30m) |
| Barren | 2000–2020 | USGS LCMAP | Raster (30m) |
| Cropland | 2015, 2020 | State of Hawaiʻi Agriculture Land Use Census | Vector |
| Pasture | 2015, 2020 | State of Hawaiʻi Agriculture Land Use Census | Vector |
| Freshwater Wetland | 2018 | National Wetland Inventory (NWI) | Vector |
| Beaches | 2010–2011 | NOAA Coastal Change Analysis Program (C-CAP) | Raster (3m) |
| Sand Dunes | 2010–2011 | NOAA C-CAP | Raster (3m) |
| Coral Dominated Hard Bottom | 2004–2014 | Hawaiʻi Monitoring and Reporting Collaborative (HIMARC) | Raster, modeled (100m) |
| Other Hard Bottom | 2004–2014 | HIMARC | Raster, modeled (100m) |
| Pavement | 2004–2014 | HIMARC | Raster, modeled (100m) |
| Soft Bottom | 2004–2014 | HIMARC | Raster, modeled (100m) |
| Rock/Boulder | 2004–2014 | HIMARC | Raster, modeled (100m) |
| Open Ocean | 2004–2014 | HIMARC | Raster, modeled (100m) |

---

## 2. Ecosystem Condition Accounts (Terrestrial)

Condition accounts assess ecosystem health using the SEEA Ecosystem Condition Typology (ECT) framework.

### Group A: Abiotic Ecosystem Characteristics

#### Class A1: Physical State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Dominant soil composition | 2010–2014 | Hawaiʻi Soil Atlas | Vector |
| Soil order | 2010–2014 | Hawaiʻi Soil Atlas | Vector |
| Area burnt | 1999–2022 | Hawaiʻi Wildfire Management Organization (HWMO) | Vector |

#### Class A2: Chemical State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Monthly mean peak rainfall | 1990–present | Hawaiʻi Climate Data Portal (HCDP) | Raster (2m, at best) |
| Monthly mean rainfall | 1990–present | HCDP | Raster (2m, at best) |
| Monthly mean peak temperature | 1990–present | HCDP | Raster (2m, at best) |
| Monthly mean temperature | 1990–present | HCDP | Raster (2m, at best) |
| Nutrient holding capacity | 2010–2014 | Hawaiʻi Soil Atlas | Vector |

### Group B: Biotic Ecosystem Characteristics

#### Class B1: Compositional State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Alien/alien mix species | 2014 | USGS Hawaiʻi Land Cover and Habitat Status | Raster (30m) |
| (Native) Coastal vegetation quality | 2013–2015 | USGS Hawaiian Islands Coastal Vegetation Survey | Vector |
| Dune environment | 2013–2015 | USGS Hawaiian Islands Coastal Vegetation Survey | Vector |
| Moisture zones (1–7) | 2012 | Price, J.P., Jacobi, J.D., 2012 | Vector |

#### Class B3: Functional State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Stream habitat condition score | 2015 | National Fish Habitat Partnership (NFHP) | Vector |

### Group C: Landscape-Level Characteristics

#### Class C1: Landscape Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Normalized Difference Vegetation Index (NDVI) | 2001–present | Hawaiʻi Climate Data Portal (HCDP) | Raster (240m) |

---

## 3. Ecosystem Condition Accounts (Marine)

Marine condition indicators are measured within Moku (traditional Hawaiian land divisions extending from mountain to sea).

### Group A: Abiotic Ecosystem Characteristics

#### Class A1: Physical State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Wave power (long-term mean) | 2000–2013 | Ocean Tipping Points (OTP) | Raster, modeled (500m) |
| Sea surface temperature (SST) | 2013, 2016, 2019 | NOAA National Coral Reef Monitoring Program, Coral Reef Watch | Vector |
| Photosynthetically active radiation (PAR) | 2013, 2016, 2019 | NOAA NCRMP, Coral Reef Watch | Vector |
| Degree heating weeks | 2013, 2016, 2019 | NOAA NCRMP, Coral Reef Watch | Vector |
| kd490 (diffuse attenuation) | 2013, 2016, 2019 | NOAA NCRMP, Coral Reef Watch | Vector |

#### Class A2: Chemical State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Nearshore sediment | 2000–2013 | Ocean Tipping Points (OTP) | Raster, modeled (500m) |
| Phosphorus flux from OSDS | 2000–2013 | Ocean Tipping Points (OTP) | Raster, modeled (500m) |
| Nitrogen flux from OSDS | 2000–2013 | Ocean Tipping Points (OTP) | Raster, modeled (500m) |
| Total effluent from OSDS | 2000–2013 | Ocean Tipping Points (OTP) | Raster, modeled (500m) |
| Chlorophyll-a | 2013, 2016, 2019 | NOAA National Coral Reef Monitoring Program | Vector |

### Group B: Biotic Ecosystem Characteristics

#### Class B1: Compositional State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Coral cover | 2013, 2016, 2019 | NOAA National Coral Reef Monitoring Program | Vector |
| Adult coral density | 2013, 2016, 2019 | NOAA NCRMP | Vector |
| Juvenile coral density | 2013, 2016, 2019 | NOAA NCRMP | Vector |
| Coral diversity | 2013, 2016, 2019 | NOAA NCRMP | Vector |

#### Class B2: Structural State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Primary consumers | 2013, 2016, 2019 | NOAA National Coral Reef Monitoring Program | Vector |
| Secondary consumers | 2013, 2016, 2019 | NOAA NCRMP | Vector |
| Planktivores | 2013, 2016, 2019 | NOAA NCRMP | Vector |
| Piscivores | 2013, 2016, 2019 | NOAA NCRMP | Vector |

#### Class B3: Functional State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Total disease prevalence | 2013, 2016, 2019 | NOAA National Coral Reef Monitoring Program | Vector |

### Group C: Landscape Ecosystem Characteristics

#### Class C1: Landscape/Seascape State Characteristics

| Indicator | Date | Data Source | Format |
|-----------|------|-------------|--------|
| Coastal habitat modification | 2000–2013 | Ocean Tipping Points (OTP) | Raster, modeled (500m) |

---

## 4. Ecosystem Service Accounts: Fisheries Valuation

Fisheries accounts quantify physical flows (catch) and monetary values (exchange values) for commercial and non-commercial sectors.

### Physical Flow Data

| Dataset | Sector | Data Source | Format |
|---------|--------|-------------|--------|
| Commercial Marine Landings (CML) | Commercial | Hawaiʻi Division of Aquatic Resources (HDAR) | Tabular |
| Fish catch area polygons | Commercial | HDAR | Vector |

### Spatial Reference Layers

| Layer | Data Source | Description |
|-------|-------------|-------------|
| Marine Managed Areas | DLNR Division of Aquatic Resources | Includes Community-Based Subsistence Fishing Areas, Public Fishing Areas, Marine Life Conservation Districts, Lay Net Fishing Prohibited Areas, Fisheries Management Areas |

### Valuation Components

| Component | Description |
|-----------|-------------|
| Commercial exchange values | Market prices for commercial landings |
| Non-commercial exchange values | Imputed values for subsistence and recreational catch |

---

## 5. Ecosystem Service Accounts: Recreation

Recreation accounts estimate coastal recreation value using a spatial demand model.

### Site Characterization

| Dataset | Date | Data Source | Description |
|---------|------|-------------|-------------|
| State Coastal Sites | Current | State of Hawaiʻi | Official beach and coastal access points |
| Google Places | Current | Google Places API | Amenity data merged with state sites |
| Site amenities | Derived | Manual incorporation | Restrooms, parking, showers, swimming, snorkeling, surfing |

### Demand-Side Inputs

| Dataset | Date | Data Source | Format |
|---------|------|-------------|--------|
| Population | 2020 | U.S. Census Bureau (Census Block) | Vector |
| Population density | 2020 | Derived (1km grid) | Raster (1km) |
| Income | 2020 | U.S. Census Bureau | Vector |
| EJ Screen Disadvantaged Communities | Current | EPA Environmental Justice Screening Tool | Vector |

### Accessibility

| Dataset | Date | Data Source | Description |
|---------|------|-------------|-------------|
| Distance to sites | Derived | OSRM (OpenStreetMaps) | Euclidean and network distance from each 1km grid cell to all beach sites |
| Travel time to sites | Derived | OSRM (OpenStreetMaps) | Drive time estimates (Fu et al. 2023) |

### Ecosystem Service Quality

| Dataset | Date | Data Source | Description |
|---------|------|-------------|-------------|
| Coral reef cover | 2019 | Asner et al. 2020 | Average within 300m buffer of recreation sites |
| Resource fish biomass | 2017 | NOAA | Average within 300m buffer of recreation sites |

### Climate Scenario Modeling

| Component | Data Source | Description |
|-----------|-------------|-------------|
| Atlantis Model polygons | Atlantis Ecosystem Model | Spatial units for climate-driven biomass projections |
| Climate scenarios | SSP1–SSP3 | Shared Socioeconomic Pathways |
| Climate forcings | Various | CO₂ emission pathways, ocean acidification, warming impacts |

---

## Source Abbreviations

| Abbreviation | Full Name |
|--------------|-----------|
| C-CAP | Coastal Change Analysis Program |
| HCDP | Hawaiʻi Climate Data Portal |
| HDAR | Hawaiʻi Division of Aquatic Resources |
| HIMARC | Hawaiʻi Monitoring and Reporting Collaborative |
| HWMO | Hawaiʻi Wildfire Management Organization |
| LCMAP | Land Change Monitoring, Assessment, and Projection |
| NCRMP | National Coral Reef Monitoring Program |
| NFHP | National Fish Habitat Partnership |
| NWI | National Wetland Inventory |
| OSDS | On-site Sewage Disposal Systems |
| OSRM | Open Source Routing Machine |
| OTP | Ocean Tipping Points |
| SEEA | System of Environmental-Economic Accounting |
| SSP | Shared Socioeconomic Pathway |
| SST | Sea Surface Temperature |

---

## References

Asner, G.P., et al. (2020). Large-scale mapping of live corals to guide reef conservation. *Proceedings of the National Academy of Sciences*.

Fu, X., et al. (2023). Comparing travel time estimates from Google Maps and OpenStreetMap-based routing services. *Transportation Research Record*.

Price, J.P., & Jacobi, J.D. (2012). Moisture zones of the Hawaiian Islands. *U.S. Geological Survey*.