print("Loading module_01_01...")

drug_name_options <- 
    "www/data/drug_master.csv" |> 
    readr::read_csv(
        col_types = cols(
            `製剤名` = col_character(),
            .default = col_number()
        )
    ) |> 
    dplyr::rename(
        drug_name = "製剤名", glu = "Glu (%)",
        na = "Na (mEq/mL)", k = "K (mEq/mL)",
        ca = "Ca (mg/mL)", p = "P (mg/mL)",
        aa = "AA (g/mL)", lipid = "Lipid (%)",
    ) |>
    tidyr::pivot_longer(cols = -drug_name, names_to = "element_name") |> 
    dplyr::distinct(drug_name) |> 
    dplyr::pull(drug_name) |> 
    {\(x) c("Select One:", x)}()

module_01_01 <- 
    tabPanel(
        title = "TPN",
        
        br(),
        
        
        fluidRow(
            column(
                width = 4,
                
                h4(textOutput("total_text")),
                wellPanel(
                    numericInput(
                        "weight_tpn", label = "Body Weight (g):",
                        min = 1, value = 0, max = 100000
                    ),
                    tableOutput("tpn_table_all")
                ),
                
                h4(textOutput("enteral_text")),
                wellPanel(
                    selectInput(
                        inputId = "tp_enteral_type",
                        label = "Milk/Formula",
                        choices = c("母乳", "はぐくみ"),
                    ),
                    fluidRow(
                        column(
                            width = 6,
                            numericInput(
                                inputId = "tpn_enteral_dose",
                                label = "mL/DOSE",
                                min = 0,
                                max = 200,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "tpn_enteral_times",
                                label = "DOSE/day",
                                min = 0,
                                max = 20,
                                value = 8
                            ),
                        ),
                    ),
                    
                ),
                
                
                
                h4(textOutput("tpnx_text")),
                wellPanel(
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpnx_name_01",
                                label = "Product 1",
                                choices = drug_name_options,
                                selected = "１０％グルコース",
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpnx_flow_01",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpnx_name_02",
                                label = "Product 2",
                                choices = drug_name_options,
                                selected = "５％グルコース",
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpnx_flow_02",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpnx_name_03",
                                label = "Product 3",
                                choices = drug_name_options,
                                selected = "生理食塩液",
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpnx_flow_03",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpnx_name_04",
                                label = "Product 4",
                                choices = drug_name_options,
                                selected = "注射用水",         
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpnx_flow_04",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpnx_name_05",
                                label = "Product 5",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpnx_flow_05",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                ),
                wellPanel(
                    tableOutput("tpnx_table")
                ),
            ),
            
            column(
                width = 4,
                h4(textOutput("tpn1_text")),
                wellPanel(
                    fluidRow(
                        column(
                            width = 6,
                            numericInput(
                                inputId = "tpn1_flow",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "tpn1_hours",
                                label = "hours/day",
                                min = 0,
                                max = 24,
                                value = 24,
                            ),
                        ),
                    ),
                ),
                wellPanel(
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_01",
                                label = "Product 1",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_01",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_02",
                                label = "Product 2",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_02",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_03",
                                label = "Product 3",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_03",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_04",
                                label = "Product 4",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_04",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_05",
                                label = "Product 5",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_05",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_06",
                                label = "Product 6",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_06",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_07",
                                label = "Product 7",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_07",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_08",
                                label = "Product 8",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_08",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_09",
                                label = "Product 9",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_09",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_10",
                                label = "Product 10",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_10",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_11",
                                label = "Product 11",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_11",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn1_name_12",
                                label = "Product 12",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn1_volume_12",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                ),
                
                wellPanel(
                    tableOutput("tpn1_table")
                )
            ),
            
            
            column(
                width = 4,
                h4(textOutput("tpn2_text")),
                wellPanel(
                    fluidRow(
                        column(
                            width = 6,
                            numericInput(
                                inputId = "tpn2_flow",
                                label = "mL/h",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                        column(
                            width = 6,
                            numericInput(
                                inputId = "tpn2_hours",
                                label = "hours/day",
                                min = 0,
                                max = 24,
                                value = 24,
                            ),
                        ),
                    ),
                ),
                wellPanel(
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_01",
                                label = "Product 1",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_01",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_02",
                                label = "Product 2",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_02",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_03",
                                label = "Product 3",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_03",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_04",
                                label = "Product 4",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_04",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_05",
                                label = "Product 5",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_05",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_06",
                                label = "Product 6",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_06",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_07",
                                label = "Product 7",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_07",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_08",
                                label = "Product 8",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_08",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_09",
                                label = "Product 9",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_09",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_10",
                                label = "Product 10",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_10",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_11",
                                label = "Product 11",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_11",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                    fluidRow(
                        column(
                            width = 8,
                            selectInput(
                                inputId = "tpn2_name_12",
                                label = "Product 12",
                                choices = drug_name_options,
                            ),
                        ),
                        column(
                            width = 4,
                            numericInput(
                                inputId = "tpn2_volume_12",
                                label = "mL",
                                min = 0,
                                max = 20,
                                value = 0,
                            ),
                        ),
                    ),
                ),
                
                wellPanel(
                    tableOutput("tpn2_table")
                )
            ),
        ),
    )