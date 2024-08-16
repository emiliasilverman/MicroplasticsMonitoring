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
}
