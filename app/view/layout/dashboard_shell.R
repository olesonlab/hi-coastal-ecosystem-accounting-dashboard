# app/view/layout/dashboard_shell.R

# Purpose
# - Defines the top-level bs4Dash layout (header, sidebar, body, controlbar, footer).
# - Exposes layout "slots" so main.R can inject routed UI for the active scope.

# Rules
# - UI-only module: do not add a server() here.
# - Keep this file focused on layout structure; avoid feature-specific UI.
# - Do not store state here. Parent state lives in main.R.
# - Use box::use() for imports; do not use library().

# Current status (scaffolding)
# - Layout is in use by main.R as the app shell.
# - Accepts injected UI for sidebar/body/controlbar; does not decide what those contain.
# - Theming is not centralized yet (will be handled separately).

# Imports
box::use(
  shiny[
    NS,
    icon,
    div,
    img,
    p,
    br,
    tags,
    a,
    tagList
  ],
  bs4Dash[
    dashboardPage,
    dashboardHeader,
    dashboardBrand,
    dashboardSidebar,
    dashboardBody,
    dashboardControlbar,
    dashboardFooter
  ],
  htmltools[
    HTML,
    strong
  ]
)

#' @export
ui <- function(id, sidebar, body, controlbar) {
  ns <- NS(id)

  tagList(
    # load Rhino-compiled CSS
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "static/css/app.min.css"
      )
    ),

    # https://bs4dash.rinterface.com/reference/dashboardpage
    dashboardPage(
      # https://bs4dash.rinterface.com/reference/dashboardheader
      header = dashboardHeader(
        title = dashboardBrand(
          title = HTML("<br>"),
          image = "static/logos/cea-logo.png"
        ),
        leftUi = NULL,
        rightUi = NULL,
        border = TRUE,
        compact = FALSE,
        sidebarIcon = shiny::icon("bars"),
        controlbarIcon = shiny::icon("sliders"),
        fixed = TRUE
      ),
      # Use injected sidebar from nav module
      sidebar = dashboardSidebar(
        width = NULL,
        status = "olive",
        elevation = 4,
        collapsed = FALSE,
        minified = TRUE,
        expandOnHover = TRUE,
        fixed = TRUE,
        id = NULL,
        customArea = NULL,
        sidebar
      ),
      body = dashboardBody(body),
      controlbar = dashboardControlbar(controlbar),
    footer = dashboardFooter(
      left = div(
        class = "footer",

        # Partner & Funder Logos
        div(
          class = "footer-logos",
          img(
            src = "static/logos/uhm-logo.png",
            alt = "UHM logo",
            class = "footer-single-logo"
          )
          # Add other logos here
        ),

        # Project Title & Grant
        div(
          class = "footer-text",
          p(
            strong("[Project Title]"),
            br(),
            "Funded by [Funder Name] (Grant [Grant Number])"
          ),
          p(HTML(
            "© 2025 University of Hawaiʻi at Mānoa. All rights reserved."
          )),
          p(HTML(
            'Developed by <a href="https://www.olesonlab.org/" target="_blank" title="Oleson Lab Website">Oleson Lab Team</a>'
          ))
        ),

        # Quick Links
        div(
          class = "footer-quick-links",
          a(
            href = "https://github.com/olesonlab/coastal_ecosystem_accounting",
            target = "_blank",
            icon("github", class = "fa-2x"),
            title = "GitHub Repository"
          )
        )
      ),
      right = NULL,
      fixed = FALSE
    ),
      fullscreen = TRUE,
      help = TRUE,
      dark = NULL,
      scrollToTop = TRUE
    )
  )
}

# Reference template (commented out)
# # https://bs4dash.rinterface.com/reference/dashboardpage
  # dashboardPage(
  #   # https://bs4dash.rinterface.com/reference/dashboardheader
  #   header = dashboardHeader(
  #     ...,
  #     title = dashboardBrand(
  #       title = "My dashboard",
  #       color = "primary",
  #       href = "https://adminlte.io/themes/v3",
  #       image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png"
  #     ),
  #     titleWidth = NULL,
  #     disable = FALSE,
  #     .list = NULL,
  #     leftUi = NULL,
  #     rightUi = NULL,
  #     skin = "light",
  #     status = "white",
  #     border = TRUE,
  #     compact = FALSE,
  #     sidebarIcon = shiny::icon("bars"),
  #     controlbarIcon = shiny::icon("table-cells"),
  #     fixed = FALSE
  #   ),
  #   # https://bs4dash.rinterface.com/reference/dashboardsidebar
  #   sidebar = dashboardSidebar(
  #     ...,
  #     disable = FALSE,
  #     width = NULL,
  #     skin = NULL,
  #     status = "primary",
  #     elevation = 4,
  #     collapsed = FALSE,
  #     minified = TRUE,
  #     expandOnHover = TRUE,
  #     fixed = TRUE,
  #     id = NULL,
  #     customArea = NULL
  #   ),
  #   # https://bs4dash.rinterface.com/reference/dashboardbody
  #   body = dashboardBody(),
  #   # https://bs4dash.rinterface.com/reference/dashboardcontrolbar
  #   controlbar = controlbarMenu(
  #     ...,
  #     id = NULL,
  #     selected = NULL,
  #     type = c("tabs", "pills", "hidden"),
  #     vertical = FALSE,
  #     side = "left",
  #     .list = NULL
  #   ),
  #   # https://bs4dash.rinterface.com/reference/dashboardfooter
  #   footer = dashboardFooter(
  #     left = NULL,
  #     right = NULL,
  #     fixed = FALSE
  #   ),
  #   title = "Dashboard Page",
  #   skin = NULL,
  #   # https://dreamrs.github.io/fresh/articles/vars-shinydashboard.html
  #   # https://github.com/dreamRs/fresh
  #   # https://dreamrs.github.io/fresh/articles/vars-shinydashboard.html
  #   freshTheme = create_theme(
  #     bs4dash_vars(
  #       navbar_light_color = "#bec5cb",
  #       navbar_light_active_color = "#FFF",
  #       navbar_light_hover_color = "#FFF"
  #     ),
  #     bs4dash_yiq(
  #       contrasted_threshold = 10,
  #       text_dark = "#FFF",
  #       text_light = "#272c30"
  #     ),
  #     bs4dash_layout(
  #       main_bg = "#353c42"
  #     ),
  #     bs4dash_sidebar_light(
  #       bg = "#272c30",
  #       color = "#bec5cb",
  #       hover_color = "#FFF",
  #       submenu_bg = "#272c30",
  #       submenu_color = "#FFF",
  #       submenu_hover_color = "#FFF"
  #     ),
  #     bs4dash_status(
  #       primary = "#5E81AC",
  #       danger = "#BF616A",
  #       light = "#272c30"
  #     ),
  #     bs4dash_color(
  #       gray_900 = "#FFF",
  #       white = "#272c30"
  #     )
  #   ),
  #   # https://waiter.john-coene.com/#/
  #   # https://rdrr.io/cran/waiter/man/waiter.html
  #   preloader = NULL,
  #   fullscreen = TRUE,
  #   help = TRUE,
  #   dark = TRUE,
  #   scrollToTop = TRUE
  # )
