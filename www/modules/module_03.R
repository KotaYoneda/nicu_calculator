print("Loading module_03...")

module_03 <- 
    tabPanel(
        title = "Bone Length",
        titlePanel("Bone Length Calculator"),
        
        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                strong("Gestational Age"),
                numericInput(
                    inputId = "bone_length_ga",
                    label = "Weeks",
                    min = 22,
                    max = 41,
                    value = 22
                ),
                hr(),
                strong("Humerus"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "humerus_rt",
                            label = "Right (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "humerus_lt",
                            label = "Left (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                ),
                strong("Radius"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "radius_rt",
                            label = "Right (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "radius_lt",
                            label = "Left (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                ),
                strong("Ulna"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "ulna_rt",
                            label = "Right (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "ulna_lt",
                            label = "Left (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                ),
                strong("Femur"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "femur_rt",
                            label = "Right (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "femur_lt",
                            label = "Left (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                ),
                strong("Tibia"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "tibia_rt",
                            label = "Right (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "tibia_lt",
                            label = "Left (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                ),
                strong("Fibula"),
                fluidRow(
                    column(
                        width = 6,
                        numericInput(
                            inputId = "fibula_rt",
                            label = "Right (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                    column(
                        width = 6,
                        numericInput(
                            inputId = "fibula_lt",
                            label = "Left (cm)",
                            min = 1,
                            max = 100,
                            value = 0,
                        ),
                    ),
                ),
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                fluidPage(
                    tabsetPanel(
                        tabPanel(
                            title = "Summary",
                            h3("Summary"),
                            tableOutput("bone_length_table"),
                        ),
                        tabPanel(
                            title = "Reference",
                            h3("Reference"),
                            includeMarkdown("www/modules/reference_03.md"),
                        ),
                    )
                )
            )
        )
    )