# server <- function(input, output) {
#
#   # choose columns to display
#   wine1 = wine[sample(nrow(wine), 1000), ]
#   output$mytable1 <- DT::renderDataTable({
#     DT::datatable(wine1[, input$show_vars, drop = FALSE])
#   })





  # # sorted columns are colored now because CSS are attached to them
  # output$mytable2 <- DT::renderDataTable({
  #   DT::datatable(mtcars, options = list(orderClasses = TRUE))
  # })

  # # customize the length drop-down menu; display 5 rows per page by default
  # output$mytable3 <- DT::renderDataTable({
  #   DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  # })

#}


# server <- function(input, output) {
#
#   # choose columns to display
#   wine1 = wine[sample(nrow(wine), 1000), ]
#   output$mytable1 <- DT::renderDataTable({
#     DT::datatable(wine1[, input$show_vars, drop = FALSE])
#   })
#
#   # # sorted columns are colored now because CSS are attached to them
#   # output$mytable2 <- DT::renderDataTable({
#   #   DT::datatable(mtcars, options = list(orderClasses = TRUE))
#   # })
#
#   # # customize the length drop-down menu; display 5 rows per page by default
#   # output$mytable3 <- DT::renderDataTable({
#   #   DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
#   # })
#
# }


server <- function(input, output) {


  Wine <- reactive({
    wine %>%
      filter(variety %in% input$wineVariety)%>%
      head(input$rows)%>%
      select(
        ~description
      )
  })

  output$wine_table <- DT::renderDataTable({
    DT::datatable(Wine())

  })

  output$plot <- renderPlot({
    ggplot(Wine(), aes(x = points, y = price)) +
      geom_point(color = "navy blue") +
      geom_smooth(method = "lm", se = FALSE, color = 'light grey') +
      them_bw()
  })


}




