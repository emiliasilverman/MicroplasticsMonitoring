server = function(input, output) {
  
  
  monitoring_plan <- reactive({
    data <- tibble(
      Sampling_Device = character()  
    )
    if(input$size_min <= 249){
    data <- data %>% add_row(Sampling_Device = "Isokinetic Bulk Water Sampler")
    }
    if(input$size_max >= 250){
      data <- data %>% add_row(Sampling_Device = "BL-84 Net Sampler")
    }
    return(data)
  })
  
  output$table1 <- DT:: renderDataTable(datatable(
    monitoring_plan(), 
    selection = 'none',
    rownames = F,
  options = list(
    paging = FALSE,
    fixedColumns = TRUE,
    autoWidth = TRUE,
    ordering = TRUE,
    server = F, 
    dom = 'Bfrtip',
    searching = F
  ),
  class = "display",
  style="bootstrap"))
  
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("monitoring-plan-", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(monitoring_plan(), file, row.names = FALSE)
    }
  )
  
  water_location <- reactive({
    # Check if any location has been selected
    if (is.null(input$location) || length(input$location) == 0) {
      return(tibble(Water_Level = "No location selected"))
    }
    
    # Create a table with the selected water levels
    data <- tibble(
      Water_Level = input$location
    )
    
    return(data)
  })
  
  water_location <- reactive({
    data <- tibble(
      Water_Level = character()  
    )
    if(input$location == 'surface'){
      data <- data %>% add_row(Water_Level = "surface")
    }
    else if(input$location == 'midwater'){
      data <- data %>% add_row(Water_Level = "midwater")
    }
    else
      data <- data %>% add_row(Water_Level = 'bottom')
    return(data)
  })
  
  output$table2 <- DT:: renderDataTable(datatable(
    water_location(),
    selection = 'none',
    rownames = F,
    options = list(
      paging = FALSE,
      fixedColumns = TRUE,
      autoWidth = TRUE,
      ordering = TRUE,
      server = F, 
      dom = 'Bfrtip',
      searching = F
    ),
    class = "display",
    style="bootstrap"))
}
