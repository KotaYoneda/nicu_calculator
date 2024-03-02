print("Loading module_01_02...")

module_01_02 <- tabPanel(
    title = "Single",
    
    br(),
    
    wellPanel(
        
        fluidRow(
            
            column(
                width = 3,
                h4("Case 1"),
                numericInput(
                    "weight_single_1", label = "Body Weight (g):",
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
                                inputId = "dose_single_1",
                                label = "mL/DOSE",
                                min = 0,
                                max = 200,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "times_single_1",
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
                strong("Parenteral Feeding:"),
                wellPanel(
                    fluidRow(
                        column(
                            width = 6,
                            numericInput(
                                inputId = "rate_single_1",
                                label = "mL/h",
                                min = 0,
                                max = 50,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "glu_single_1",
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
                strong("Result"),
                wellPanel(
                    htmlOutput("result_single_1"),
                    # textOutput("result_1"),
                )       
            ),
        ),
    ),
    wellPanel(
        
        fluidRow(
            
            column(
                width = 3,
                h4("Case 2"),
                numericInput(
                    "weight_single_2", label = "Body Weight (g):",
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
                                inputId = "dose_single_2",
                                label = "mL/DOSE",
                                min = 0,
                                max = 200,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "times_single_2",
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
                strong("Parenteral Feeding:"),
                wellPanel(
                    fluidRow(
                        column(
                            width = 6,
                            numericInput(
                                inputId = "rate_single_2",
                                label = "mL/h",
                                min = 0,
                                max = 50,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "glu_single_2",
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
                strong("Result"),
                wellPanel(
                    htmlOutput("result_single_2"),
                )       
            ),
        )
    ),
    wellPanel(
        
        fluidRow(
            
            column(
                width = 3,
                h4("Case 3"),
                numericInput(
                    "weight_single_3", label = "Body Weight (g):",
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
                                inputId = "dose_single_3",
                                label = "mL/DOSE",
                                min = 0,
                                max = 200,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "times_single_3",
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
                strong("Parenteral Feeding:"),
                wellPanel(
                    fluidRow(
                        column(
                            width = 6,
                            numericInput(
                                inputId = "rate_single_3",
                                label = "mL/h",
                                min = 0,
                                max = 50,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "glu_single_3",
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
                strong("Result"),
                wellPanel(
                    htmlOutput("result_single_3"),
                )       
            ),
        )
    )
)