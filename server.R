#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    output$tpnx_table <- renderTable({
        
        input |> 
            create_tpnx_table() |> 
            display_tpnx_table()
        
    })
    
    
    output$tpn1_table <- renderTable({
        
        input |> 
            create_tpn1_table() |> 
            display_tpn_table()
        
    })
    
    
    output$tpn2_table <- renderTable({
        
        input |> 
            create_tpn2_table() |> 
            display_tpn_table()

    })
    
    output$tpn_table_all <- renderTable({
        
        tpnx_table <- input |> create_tpnx_table()
        tpn1_table <- input |> create_tpn1_table()
        tpn2_table <- input |> create_tpn2_table()
        
        create_tpn_table_all(tpnx_table, tpn1_table, tpn2_table)
        
    })
    
    output$total_text <- renderText({
        
        stringr::str_c(
            "Total: ",
            round(
                calc_twi_enteral(input) + 
                    calc_twi_tpnx(input) + 
                    calc_twi_tpn1(input) + 
                    calc_twi_tpn2(input),
                0
            ),
            " mL/kg/day"
        )
        
    })
    
    output$enteral_text <- renderText({
        
        stringr::str_c(
            "Enteral: ",
            round(
                calc_twi_enteral(input),
                0
            ),
            " mL/kg/day"
        )
        
    })
    
    output$tpnx_text <- renderText({
        
        stringr::str_c(
            "Extra (", calc_flow_tpnx(input), " mL/h): ",
            round(
                calc_twi_tpnx(input),
                0
            ),
            " mL/kg/day")
        
    })
    
    output$tpn1_text <- renderText({
        
        stringr::str_c(
            "TPN 1 (", calc_flow_tpn1(input), " mL): ",
            round(
                calc_twi_tpn1(input),
                0
            ),
            " mL/kg/day"
        )
        
    })
    
    output$tpn2_text <- renderText({
        
        stringr::str_c(
            "TPN 2 (", calc_flow_tpn2(input), " mL): ",
            round(
                calc_twi_tpn2(input),
                0
            ),
            " mL/kg/day"
        )
        
    })
    
    # Nutrition Single
    
    output$result_single_1 <- renderText({write_result_single(input, 1)})
    output$result_single_2 <- renderText({write_result_single(input, 2)})
    output$result_single_3 <- renderText({write_result_single(input, 3)})
    
    # Nutrition Double
    
    output$result_double_1 <- renderText({write_result_double(input, 1)})
    output$result_double_2 <- renderText({write_result_double(input, 2)})
    output$result_double_3 <- renderText({write_result_double(input, 3)})
    
    # output$result_1 <- renderText({
    # 
    #     write_result_1(input)
    # 
    # })
    # 
    # output$result_2 <- renderText({
    #     
    #     write_result_2(input)
    #     
    # })
    # 
    # output$result_3 <- renderText({
    #     
    #     write_result_3(input)
    #     
    # })
    
    # Birth Size
    
    output$evaluation_text = renderText({
        tables = get_tables(input, body_size)
        get_evaluation_text(input, tables)
    })
    
    output$reference_table <- renderTable({
        
        tables = get_tables(input, body_size)
        get_reference_table(tables) 
        
    },
    hover = TRUE,
    striped = TRUE,
    )
    
    # Bone Length
    
    output$bone_length_table = renderTable({
        
        create_bone_length_table(input)
        
    },
    hover = TRUE,
    striped = TRUE,
    )
    
})
