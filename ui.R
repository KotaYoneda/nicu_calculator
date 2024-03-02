#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
# library(shinydashboard)
library(markdown)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(
    navbarPage(
    
        title = "NICU Calculator",
        selected = "Nutrition",
        theme = shinytheme("cerulean"),
        
        tabPanel(
            title = "Home",
            includeMarkdown("www/README.md")
        ),
        
        
        tabPanel(
            title = "Nutrition",
            titlePanel("Nutrition Calculator"),
            
            fluidPage(
                tabsetPanel(
                    
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
                    ),
                    tabPanel(
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
                    ),
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
                    ),
                ),
            ),
        ),
        
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
                            # tabPanel(
                            #     title = "Figure",
                            #     h3("Figure"),
                            # ),
                            tabPanel(
                                title = "Reference",
                                h3("Reference"),
                                includeMarkdown("www/birth_size/reference.md"),
                            )
                        )
                    )
                )
            )
        ),
        
        
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
                                tableOutput("bone_length_table"),
                            ),
                            tabPanel(
                                title = "Reference",
                                h3("Reference"),
                                includeMarkdown("www/bone_length/reference.md"),
                            ),
                        )
                    )
                )
            )
        )
    )
)
