print("Loading module_01_03...")

module_01_03 <- 
    tabPanel(
        title = "Double",
        
        br(),
        
        wellPanel(
            
            fluidRow(
                
                column(
                    width = 1,
                    h4("Case 1"),
                    numericInput(
                        "weight_double_1", label = "Weight (g)",
                        min = 1, value = 0, max = 100000
                    )
                ),
                
                column(
                    width = 3,
                    strong("Enteral Feeding:"),
                    wellPanel(
                        
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "dose_double_1",
                                    label = "mL/DOSE",
                                    min = 0,
                                    max = 200,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "times_double_1",
                                    label = "DOSE/day",
                                    min = 0,
                                    max = 20,
                                    value = 8
                                ),
                            ),
                        ),
                    ),
                ),
                
                column(
                    width = 3,
                    strong("Parenteral Feeding 1:"),
                    wellPanel(
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "rate1_double_1",
                                    label = "mL/h",
                                    min = 0,
                                    max = 50,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "glu1_double_1",
                                    label = "Glu (%)",
                                    min = 0,
                                    max = 50,
                                    value = 0
                                ),
                            ),
                        ),
                    )       
                ),
                
                column(
                    width = 3,
                    strong("Parenteral Feeding 2:"),
                    wellPanel(
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "rate2_double_1",
                                    label = "mL/h",
                                    min = 0,
                                    max = 50,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "glu2_double_1",
                                    label = "Glu (%)",
                                    min = 0,
                                    max = 50,
                                    value = 0
                                ),
                            ),
                        ),
                    )       
                ),
                
                column(
                    width = 2,
                    strong("Result"),
                    wellPanel(
                        htmlOutput("result_double_1"),
                    )       
                ),
            ),
        ),
        wellPanel(
            
            fluidRow(
                
                column(
                    width = 1,
                    h4("Case 2"),
                    numericInput(
                        "weight_double_2", label = "Weight (g)",
                        min = 1, value = 0, max = 100000
                    )
                ),
                
                column(
                    width = 3,
                    strong("Enteral Feeding:"),
                    wellPanel(
                        
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "dose_double_2",
                                    label = "mL/DOSE",
                                    min = 0,
                                    max = 200,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "times_double_2",
                                    label = "DOSE/day",
                                    min = 0,
                                    max = 20,
                                    value = 8
                                ),
                            ),
                        ),
                    ),
                ),
                
                column(
                    width = 3,
                    strong("Parenteral Feeding 1:"),
                    wellPanel(
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "rate1_double_2",
                                    label = "mL/h",
                                    min = 0,
                                    max = 50,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "glu1_double_2",
                                    label = "Glu (%)",
                                    min = 0,
                                    max = 50,
                                    value = 0
                                ),
                            ),
                        ),
                    )       
                ),
                
                column(
                    width = 3,
                    strong("Parenteral Feeding 2:"),
                    wellPanel(
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "rate2_double_2",
                                    label = "mL/h",
                                    min = 0,
                                    max = 50,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "glu2_double_2",
                                    label = "Glu (%)",
                                    min = 0,
                                    max = 50,
                                    value = 0
                                ),
                            ),
                        ),
                    )       
                ),
                
                column(
                    width = 2,
                    strong("Result"),
                    wellPanel(
                        htmlOutput("result_double_2"),
                    )       
                ),
            )
        ),
        wellPanel(
            
            fluidRow(
                
                column(
                    width = 1,
                    h4("Case 3"),
                    numericInput(
                        "weight_double_3", label = "Weight (g)",
                        min = 1, value = 0, max = 100000
                    )
                ),
                
                column(
                    width = 3,
                    strong("Enteral Feeding:"),
                    wellPanel(
                        
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "dose_double_3",
                                    label = "mL/DOSE",
                                    min = 0,
                                    max = 200,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "times_double_3",
                                    label = "DOSE/day",
                                    min = 0,
                                    max = 20,
                                    value = 8
                                ),
                            ),
                        ),
                    ),
                ),
                
                column(
                    width = 3,
                    strong("Parenteral Feeding 1:"),
                    wellPanel(
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "rate1_double_3",
                                    label = "mL/h",
                                    min = 0,
                                    max = 50,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "glu1_double_3",
                                    label = "Glu (%)",
                                    min = 0,
                                    max = 50,
                                    value = 0
                                ),
                            ),
                        ),
                    )       
                ),
                
                column(
                    width = 3,
                    strong("Parenteral Feeding 2:"),
                    wellPanel(
                        fluidRow(
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "rate2_double_3",
                                    label = "mL/h",
                                    min = 0,
                                    max = 50,
                                    value = 0,
                                ),
                            ),
                            column(
                                width = 6,
                                numericInput(
                                    inputId = "glu2_double_3",
                                    label = "Glu (%)",
                                    min = 0,
                                    max = 50,
                                    value = 0
                                ),
                            ),
                        ),
                    )       
                ),
                
                column(
                    width = 2,
                    strong("Result"),
                    wellPanel(
                        htmlOutput("result_double_3"),
                    )       
                ),
            )
        )
    )