FilePurposeapp/logic/data_sources.RLoads data from targets, provides helpers for filter choicesapp/view/controls/controls_global.RIsland → Moku (cascading) → Year filtersapp/view/controls/controls_extents.REcosystem type picker + "Apply Filters" buttonapp/main.RWires state, loads data once, routes filtered data to pageapp/view/accounts/extents/extents_page.RLayout: map (row 1), table + chart (row 2)app/view/accounts/extents/extents_map.RLeaflet map with moku polygons, click returns moku nameapp/view/accounts/extents/extents_table.RDT accounting table with change calculationsapp/view/accounts/extents/extents_plots.Recharts4r stacked bar chart by year

```r
rhino::pkg_install(c("leaflet", "DT", "echarts4r", "shinyWidgets", "htmltools"))
```

## Data Flow
```text
targets::tar_read(mokus_extents)
        │
        ▼
    main.R loads once
        │
        ├─► controls_global (populates Island/Moku/Year dropdowns)
        ├─► controls_extents (populates Ecosystem Type picker)
        │
        │   [User clicks "Apply Filters"]
        │
        ▼
    state$applied_filters updated
        │
        ▼
    filtered_extents_sf/df reactives
        │
        ├─► extents_map (renders polygons)
        ├─► extents_table (renders accounting table)
        └─► extents_plots (renders bar chart)
```