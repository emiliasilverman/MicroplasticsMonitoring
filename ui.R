library()
ui = dashboardPage(
  dark = T,
  title = "Microplastics Monitoring App",
  header = dashboardHeader("Microplastics Monitoring App"),
  sidebar = dashboardSidebar(skin = "dark",
                             sidebarMenu(
                               id = "sidebarmenu",
                               menuItem("Monitoring Plan Generator", 
                                        tabName = "monitoring", 
                                        icon = icon("pen-to-square")),
                               menuItem("Particles Characterized", 
                                        tabName = "characterization", 
                                        icon = icon("chart-simple")),
                               menuItem("About", 
                                        tabName = "about", 
                                        icon = icon("question"))
                             )),
  footer = dashboardFooter(),
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "monitoring",
              fluidRow(
                column(12,
                       shiny::HTML("<br><br><center> <h1>Monitoring Plan Generator</h1> </center><br>"),
                       shiny::HTML("<h5>Input site information and study goals to obtain a riverine microplastics monitoring plan.</h5>")
                )
              ),
              
              fluidRow(
                column(2, 
                       numericInput('size_min', "Particle Size Minimum (microns)", 1, min = 1) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = c("Select the minimum particle length to be analyzed in this study.")
                                 
                         ),
                       br(), 
                       numericInput('size_max', "Particle Size Maximum (microns)", 5000, min = 1) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = c("Select the maximum particle length to be analyzed in this study.")
                                 
                         ),
                       br(),
                       selectInput('depth', "Depth Integration", c("", "Discrete Depth","Integrated")) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = c("Select if you will sample at discrete depth(s), or if sampling will be integrated accross the water column.")
                                 
                                 ),
                       br(),
                       "Location In Water Column",
                       checkboxGroupInput('location', 
                                          "",
                                          br(),
                                          choices = c("Surface","Midwater", "Bottom")) %>%
                         popover(title = "",
                                 content = "Choose the location(s) in the water column to be studied.",
                                 placement = "right")
                ),
                
                fluidRow(
                  box(title = HTML(paste0("Monitoring Plan")), 
                      maximizable = T,
                      width = 12,
                      downloadButton("downloadData", "Download Full Dataset"),
                      fluidRow(
                        div(style = "overflow-x: scroll",
                            DT::dataTableOutput("table1")
                        ))
                  ),
                  box(title = "Location in Water Column",
                      width = 12,
                      DT::dataTableOutput("table2")
                  )
                ),
      )
      ),
      tabItem(tabName = "characterization",
              fluidRow(
                column(12,
                       shiny::HTML("<br><br><center><h1>Particles Characterized</h1></center><br>"),
                       shiny::HTML("<h5>View and analyze the particles characterized in the study.</h5>")
                )
              ),
              fluidRow(
                column(2,
                       "Location In Water Column",
                       checkboxGroupInput('location', 
                                          "",
                                          choices = c("Surface","Midwater", "Bottom")) %>%
                         popover(title = "",
                                 content = "Choose the location(s) in the water column to be studied.",
                                 placement = "right")
                )
                ),
              fluidRow(
                column(2, 
                       numericInput('total_plastics_sample', "Total Microplastics Found in Samples",1) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = c("Select the total microplastics found in sample.")
                                 
                         ),
              )
              ),
              fluidRow(
                column(2, 
                       numericInput('total_plastics_blank', "Total Microplastics Found in Blanks",1) %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = c("Select the total microplastics found in blank.")
                                 
                         ),
                )
              ),
              fluidRow(
                column(2,
                       dateRangeInput('sampling_period', "Sampling Period", format = "mm/dd/yy", separator = " - ") %>%
                         popover(placement = "right",
                                 title = "Selection Help",
                                 content = c("Select date when sample was taken"))
                       ),
              )

      ),
      tabItem(tabName = "about",
              fluidRow(
                column(12,
                       shiny::HTML("<br><br><center><h1>About</h1></center><br>"),
                       shiny::HTML("<h5>Enter text</h5>")
                )
              ),
      )
    ) 
  ) 
)
