print("Loading module_01...")

module_01 <- 
    tabPanel(
        title = "Nutrition",
        titlePanel("Nutrition Calculator"),
        
        fluidPage(
            tabsetPanel(
                module_01_01,
                module_01_02,
                module_01_03,
            ),
        ),
    )