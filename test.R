library(shiny)
library(shinydashboard)
library(DT)

ui <- dashboardPage(
  dark = TRUE,
  title = "Microplastics Monitoring App",
  header = dashboardHeader(title = "Microplastics Monitoring App"),
  sidebar = dashboardSidebar(
    skin = "dark",
    sidebarMenu(
      id = "sidebarmenu",
      menuItem("Monitoring Plan Generator", tabName = "monitoring", icon = icon("pen-to-square")),
      menuItem("Particles Characterized", tabName = "characterization", icon = icon("chart-simple")),
      menuItem("About", tabName = "about", icon = icon("question"))
    )
  ),
  footer = dashboardFooter(
    # Replace with actual footer content if needed
    textOutput("footerText")
  ),
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "monitoring",
              fluidRow(
                column(12,
                       HTML("<br><br><center><h1>Monitoring Plan Generator</h1></center><br>"),
                       HTML("<h5>Input site information and study goals to obtain a riverine microplastics monitoring plan.</h5>")
                )
              ),
              fluidRow(
                column(2, 
                       numericInput('size_min', "Particle Size Minimum (microns)", 1, min = 1) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = "Select the minimum particle length to be analyzed in this study."
                         ),
                       br(), 
                       numericInput('size_max', "Particle Size Maximum (microns)", 5000, min = 1) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = "Select the maximum particle length to be analyzed in this study."
                         ),
                       br(),
                       selectInput('depth', "Depth Integration", choices = c("", "Discrete Depth", "Integrated")) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = "Select if you will sample at discrete depth(s), or if sampling will be integrated across the water column."
                         ),
                       br(),
                       "Location In Water Column",
                       checkboxGroupInput('location', 
                                          "",
                                          choices = c("Surface", "Midwater", "Bottom")) %>%
                         popover(title = "",
                                 content = "Choose the location(s) in the water column to be studied.",
                                 placement = "right")
                ),
                column(10,
                       box(title = HTML("Monitoring Plan"), 
                           maximizable = TRUE,
                           width = NULL,
                           downloadButton("downloadData", "Download Full Dataset"),
                           fluidRow(
                             div(style = "overflow-x: scroll",
                                 DT::dataTableOutput("table1")
                             )
                           )
                       )
                )
              )
      ),
      tabItem(tabName = "characterization",
              fluidRow(
                column(12,
                       HTML("<br><br><center><h1>Particles Characterized</h1></center><br>"),
                       HTML("<h5>View and analyze the particles characterized in the study.</h5>")
                )
              ),
              fluidRow(
                column(2,
                       "Location In Water Column",
                       checkboxGroupInput('location_char', 
                                          "",
                                          choices = c("Surface", "Midwater", "Bottom")) %>%
                         popover(title = "Selection Help",
                                 content = "Choose the location(s) in the water column to be analyzed.",
                                 placement = "right")
                )
              )
      ),
      tabItem(tabName = "about",
              fluidRow(
                column(12,
                       HTML("<br><br><center><h1>About</h1></center><br>"),
                       HTML("<h5>Learn more about this application and the team behind it.</h5>")
                )
              )
      )
    ) # Close tabItems
  ) # Close dashboardBody
) # Close dashboardPage

