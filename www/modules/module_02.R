print("Loading module_02...")

module_02 <- 
    tabPanel(
        title = "Birth Size",
        titlePanel("Birth Size Calculator"),
        
        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                strong("Gestational Age"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "ga_weeks",
                            label = "Weeks",
                            min = 22,
                            max = 41,
                            value = 22,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "ga_days",
                            label = "Days",
                            min = 0,
                            max = 6,
                            value = 0
                        ),
                    ),
                ),
                selectInput(
                    inputId = "sex_and_parity",
                    label = "Sex and Parity",
                    choices = list(
                        `Male and Nulliparous` = "weight_male_nulliparous",
                        `Male and Parous` = "weight_male_parous",
                        `Female and Nulliparous` = "weight_female_nulliparous",
                        `Female and Parous` = "weight_female_parous"
                    ),
                    selected = "weight_male_nulliparous",
                ),
                hr(),
                numericInput(
                    inputId = "weight",
                    label = "Weight (g)",
                    min = 1,
                    max = 10000,
                    value = 0,
                ),
                numericInput(
                    inputId = "height",
                    label = "Height (cm)",
                    min = 1,
                    max = 100,
                    value = 0
                ),
                numericInput(
                    inputId = "head",
                    label = "Head (cm)",
                    min = 1,
                    max = 100,
                    value = 0
                ),
                # hr(),
                # numericInput(
                #     inputId = "digits",
                #     label = "Digits",
                #     min = 1,
                #     max = 3,
                #     value = 1
                # ),
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                fluidPage(
                    tabsetPanel(
                        tabPanel(
                            title = "Summary",
                            h3("Summary"),
                            htmlOutput("evaluation_text"),
                            hr(),
                            h4("Reference values"), 
                            tableOutput("reference_table")
                        ),
                        tabPanel(
                            title = "Reference",
                            h3("Reference"),
                            includeMarkdown("www/text/reference_02.md"),
                        )
                    )
                )
            )
        )
    )