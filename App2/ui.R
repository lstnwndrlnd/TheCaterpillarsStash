# ui <- fluidPage(
#   title = "Examples of DataTables",
#   sidebarLayout(
#     sidebarPanel(
#       conditionalPanel(
#         'input.dataset === "wine"',
#         checkboxGroupInput("show_vars", "Columns in wine to show:",
#                            names(wine), selected = names(wine))
#       )



    #   , conditionalPanel(
    #     'input.dataset === "mtcars"',
    #     helpText("Click the column header to sort a column.")
    #   )
    #   , conditionalPanel(
    #     'input.dataset === "iris"',
    #     helpText("Display 5 records by default.")
    #   )
#     )
#     , mainPanel(
#       tabsetPanel(
#         id = 'dataset',
#         tabPanel("wine", DT::dataTableOutput("mytable1"))
#         # , tabPanel("mtcars", DT::dataTableOutput("mytable2"))
#         # , tabPanel("iris", DT::dataTableOutput("mytable3"))
#       )
#     )
#   )
# )


# ui <- fluidPage(
#   title = "Examples of DataTables",
#   sidebarLayout(
#     sidebarPanel(
#       conditionalPanel(
#         'input.dataset === "wine"',
#         checkboxGroupInput("show_vars", "Columns in wine to show:",
#                            names(wine), selected = names(wine))
#       )
#       #   , conditionalPanel(
#       #     'input.dataset === "mtcars"',
#       #     helpText("Click the column header to sort a column.")
#       #   )
#       #   , conditionalPanel(
#       #     'input.dataset === "iris"',
#       #     helpText("Display 5 records by default.")
#       #   )
#     )
#     , mainPanel(
#       tabsetPanel(
#         id = 'dataset',
#         tabPanel("wine", DT::dataTableOutput("mytable1"))
#         # , tabPanel("mtcars", DT::dataTableOutput("mytable2"))
#         # , tabPanel("iris", DT::dataTableOutput("mytable3"))
#       )
#     )
#   )
# )



# Define server logic required to draw a histogram
    ui <- fluidPage(

      # Application title
      titlePanel("Old Faithful Geyser Data"),

      # Sidebar with a slider input for number of bins
      sidebarLayout(
        sidebarPanel(
          numericInput("rows",
                       "number of rows:",
                       min = 10,
                       max = 250,
                       value = 25
          )
          ,selectizeInput("wineVariety", "select the variety:"
                          , c('Pinot Noir', 'Chardonnay', 'Cabernet',
                              'Red     Blend', 'Riesling')
                          , selected = 'Chardonnay'
                         )
      )
    ),

        # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("Plot", plotOutput("plot")),
        tabPanel("Table", DT::dataTableOutput("wine_table"))
      #   DT::dataTableOutput("wine_table")
     )
    )
)
