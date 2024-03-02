###############################################################################
###############################################################################

library(tidyverse)
library(magrittr)

###############################################################################

print("Loading global.R...")

###############################################################################

body_size <- 
    "www/data/birth_size.csv" |> 
    readr::read_csv(
        col_types = cols(.default = col_character())
    ) |> 
    tidyr::pivot_longer(cols = -c(type, ga_weeks, ga_days))


###############################################################################

get_tables <- function(input, data) {
    
    ga_weeks_value = input$ga_weeks
    ga_days_value = input$ga_days
    sex_and_parity = input$sex_and_parity
    
    weight_table <- 
        data |> 
        dplyr::filter(
            type == sex_and_parity,
            ga_weeks == ga_weeks_value,
            ga_days == ga_days_value,
        )
    
    height_table <- 
        data |> 
        dplyr::filter(
            type == "height",
            ga_weeks == ga_weeks_value,
            ga_days == ga_days_value,
        )
    
    head_table <- 
        data |> 
        dplyr::filter(
            type == "head",
            ga_weeks == ga_weeks_value,
            ga_days == ga_days_value,
        )
    
    result = list(
        weight = weight_table,
        height = height_table,
        head = head_table
    )
    
    return(result)
}


###############################################################################

get_z_value <- function(measured_value, table, digits = 1) {
    
    L = table |> dplyr::filter(name == "L") |> dplyr::pull(value) |> as.numeric()
    M = table |> dplyr::filter(name == "M") |> dplyr::pull(value) |> as.numeric()
    S = table |> dplyr::filter(name == "S") |> dplyr::pull(value) |> as.numeric()
    
    z_value = ((measured_value / M)^L - 1) / (L * S)
    
    return(round(z_value, digits = digits))
    
}


###############################################################################

get_threshold <- function(table) {
    
    m2SD = table |> dplyr::filter(name == "-2SD") |> dplyr::pull(value) |> as.numeric()
    p10 = table |> dplyr::filter(name == "p10") |> dplyr::pull(value) |> as.numeric()
    p90 = table |> dplyr::filter(name == "p90") |> dplyr::pull(value) |> as.numeric()
    
    result = list(m2SD = m2SD, p10 = p10, p90 = p90)
    
    return(result)
    
}


###############################################################################

get_reference_table <- function(tables) {
    
    tables |> 
        dplyr::bind_rows() |> 
        dplyr::mutate(
            type = dplyr::if_else(
                stringr::str_starts(type, "weight"),
                "Weight (g)",
                type |> stringr::str_to_title() |> stringr::str_c(" (cm)")
            ),
        ) |>  
        tidyr::pivot_wider() |> 
        dplyr::select(Item = type, `-2SD`, p3, p10, p50, p90, p97, `+2SD`)
    
}


###############################################################################

get_evaluation_text <- function(input, tables) {
    
    weight_z = get_z_value(input$weight, tables$weight)
    height_z = get_z_value(input$height, tables$height)
    head_z = get_z_value(input$head, tables$head)
    
    weight_threshold = get_threshold(tables$weight)
    height_threshold = get_threshold(tables$height)
    gi_indication = (input$weight < weight_threshold$m2SD) | (input$height < height_threshold$m2SD) 
    
    evaluation = ""
    if(input$weight < weight_threshold$p10) {
        if(input$height < height_threshold$p10) {
            if(gi_indication) {
                evaluation = "Small-for-dates <br> Indication for Growth Hormone Therapy"
            } else {
                evaluation = "Small-for-dates <br> <strong>No</strong> Indication for Growth Hormone Therapy"
            }
            # evaluation = weight_threshold
        } else {
            evaluation = "Light-for-dates"
        }
    } else if(input$weight > weight_threshold$p90) {
        if(input$height > height_threshold$p90) {
            evaluation = "Large-for-dates"
        } else {
            evaluation = "Heavy-for-dates"
        }
    }
    
    weight_z_text <- 
        ifelse(
            weight_z < 0,
            as.character(weight_z),
            stringr::str_c("+", as.character(weight_z))
        )
    
    height_z_text <- 
        ifelse(
            height_z < 0,
            as.character(height_z),
            stringr::str_c("+", as.character(height_z))
        )
    
    head_z_text <- 
        ifelse(
            head_z < 0,
            as.character(head_z),
            stringr::str_c("+", as.character(head_z))
        )
    
    stringr::str_c(
        "<p><strong>",
        "Birth Weight: ", weight_z_text, "SD, ",
        "Height: ", height_z_text, "SD, ",
        "Head: ", head_z_text, "SD",
        "</strong></p>",
        "<p>", evaluation, "</p>"
    )
    
}


###############################################################################

measured_length <- 
    tibble::tibble(
        bone = c("Humerus", "Radius", "Ulna", "Femur", "Tibia", "Fibula"),
        measured_rt = c(1, 2, 3, 4, 5, 6),
        measured_lt = c(1, 2, 3, 4, 5, 6),
    )

create_bone_length_table <- function(input) {
    
    measured_length <- 
        tibble::tibble(
            bone = c("Humerus", "Radius", "Ulna", "Femur", "Tibia", "Fibula"),
            measured_rt = c(
                input$humerus_rt, input$radius_rt, input$ulna_rt,
                input$femur_rt, input$tibia_rt, input$fibula_rt
            ),
            measured_lt = c(
                input$humerus_lt, input$radius_lt, input$ulna_lt,
                input$femur_lt, input$tibia_lt, input$fibula_lt
            ),
        )
    
    bone_length <- 
        "www/data/bone_length.csv" |> 
        readr::read_csv(
            col_types = cols(.default = col_character())
        ) |> 
        janitor::clean_names() |> 
        dplyr::left_join(measured_length, by = "bone") |> 
        dplyr::mutate(
            measured_rt_z = (measured_rt - as.numeric(mean)) / as.numeric(sd),
            measured_lt_z = (measured_lt - as.numeric(mean)) / as.numeric(sd),
            across(
                ends_with("_z"), 
                \(x) formatC(x, format = "f", digits = 1)
            )
        )
    
    bone_length |> 
        dplyr::filter(ga == input$bone_length_ga) |> 
        dplyr::select(
            Bone = bone, Mean = mean, SD = sd,
            `Z-value (Right)` = measured_rt_z,
            `Z-value (Left)` = measured_lt_z,
        )
    
}

###############################################################################

calc_twi <- function(dose, times, rate, weight) {
    
    (dose * times + rate * 24) / weight * 1000

    }

calc_gir <- function(rate, glu, weight) {
    
    (rate * glu / weight) * 1000 / 6
    
}

write_result_single <- function(input, num) {
    
    data <- 
        list(
            weight = "weight",
            dose = "dose", 
            times = "times", 
            rate =  "rate", 
            glu = "glu"
        ) |> 
        purrr::map(stringr::str_c, "single", num, sep = "_") |> 
        purrr::map(~magrittr::extract2(input, .))
    
    twi = calc_twi(data$dose, data$times, data$rate, data$weight)
    twi_enteral = calc_twi(data$dose, data$times, 0, data$weight)
    gir = calc_gir(data$rate, data$glu, data$weight)
    stringr::str_c(
        "TWI: ", round(twi, 0), " mL/kg/day, <br>",
        " (Enteral: ", round(twi_enteral, 0), "), <br>",
        "GIR: ", round(gir, 1), " mg/kg/min"
    )
}

write_result_double <- function(input, num) {
    
    data <- 
        list(
            weight = "weight",
            dose = "dose", 
            times = "times", 
            rate1 =  "rate1", 
            glu1 = "glu1",
            rate2 =  "rate2", 
            glu2 = "glu2"
        ) |> 
        purrr::map(stringr::str_c, "double", num, sep = "_") |> 
        purrr::map(~magrittr::extract2(input, .))
    
    twi = calc_twi(data$dose, data$times, data$rate1 + data$rate2, data$weight)
    twi_enteral = calc_twi(data$dose, data$times, 0, data$weight)
    gir1 = calc_gir(data$rate1, data$glu1, data$weight)
    gir2 = calc_gir(data$rate2, data$glu2, data$weight)
    stringr::str_c(
        "TWI: ", round(twi, 0), " mL/kg/day, <br>",
        " (Enteral: ", round(twi_enteral, 0), "), <br>",
        "GIR: ", round(gir1 + gir2, 1), " mg/kg/min"
    )
}

write_result_1 <- function(input) {
    twi = calc_twi(input$dose_1, input$times_1, input$rate_1, input$weight_1)
    twi_enteral = calc_twi(input$dose_1, input$times_1, 0, input$weight_1)
    gir = calc_gir(input$rate_1, input$glu_1, input$weight_1)
    stringr::str_c(
        "TWI: ", round(twi, 0), " mL/kg/day, <br>",
        " (Enteral: ", round(twi_enteral, 0), "), <br>",
        "GIR: ", round(gir, 1), " mg/kg/min"
    )
    
}

write_result_2 <- function(input) {
    twi = calc_twi(input$dose_2, input$times_2, input$rate_2, input$weight_2)
    twi_enteral = calc_twi(input$dose_2, input$times_2, 0, input$weight_2)
    gir = calc_gir(input$rate_2, input$glu_2, input$weight_2)
    stringr::str_c(
        "TWI: ", round(twi, 0), " mL/kg/day, <br>",
        " (Enteral: ", round(twi_enteral, 0), "), <br>",
        "GIR: ", round(gir, 1), " mg/kg/min"
    )
    
}

write_result_3 <- function(input) {
    twi = calc_twi(input$dose_3, input$times_3, input$rate_3, input$weight_3)
    twi_enteral = calc_twi(input$dose_3, input$times_3, 0, input$weight_3)
    gir = calc_gir(input$rate_3, input$glu_3, input$weight_3)
    stringr::str_c(
        "TWI: ", round(twi, 0), " mL/kg/day, <br>",
        " (Enteral: ", round(twi_enteral, 0), "), <br>",
        "GIR: ", round(gir, 1), " mg/kg/min"
    )
    
}




###############################################################################
###############################################################################

drug_master <- 
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
    tidyr::pivot_longer(cols = -drug_name, names_to = "element_name")

unit_table <- 
    "www/data/unit_table.csv" |> 
    readr::read_csv(col_types = cols(.default = col_character())) |> 
    dplyr::mutate(across(c(digit1, digit2, coef), as.numeric))

drug_names_vec <- 
    drug_master |> 
    dplyr::distinct(drug_name) |> 
    dplyr::pull(drug_name)


drug_name_options = c("Select One:", drug_names_vec)


###############################################################################

calc_flow_tpnx <- function(input) {
    
    input$tpnx_flow_01 +
        input$tpnx_flow_02 +
        input$tpnx_flow_03 +
        input$tpnx_flow_04 +
        input$tpnx_flow_05
    
}

calc_flow_tpn1 <- function(input) {
    
    input$tpn1_volume_01 +
        input$tpn1_volume_02 +
        input$tpn1_volume_03 +
        input$tpn1_volume_04 +
        input$tpn1_volume_05 +
        input$tpn1_volume_06 +
        input$tpn1_volume_07 +
        input$tpn1_volume_08 +
        input$tpn1_volume_09 +
        input$tpn1_volume_10 +
        input$tpn1_volume_11 +
        input$tpn1_volume_12
    
}

calc_flow_tpn2 <- function(input) {
    
    input$tpn2_volume_01 +
        input$tpn2_volume_02 +
        input$tpn2_volume_03 +
        input$tpn2_volume_04 +
        input$tpn2_volume_05 +
        input$tpn2_volume_06 +
        input$tpn2_volume_07 +
        input$tpn2_volume_08 +
        input$tpn2_volume_09 +
        input$tpn2_volume_10 +
        input$tpn2_volume_11 +
        input$tpn2_volume_12
    
}

calc_twi_enteral <- function(input) {
    
    input$tpn_enteral_dose * input$tpn_enteral_times / input$weight_tpn * 1000
    
}

calc_twi_tpnx <- function(input) {
    
    calc_flow_tpnx(input) / input$weight_tpn * 24000
}

calc_twi_tpn1 <- function(input) {
    input$tpn1_flow * input$tpn1_hours / input$weight_tpn * 1000
}


calc_twi_tpn2 <- function(input) {
    input$tpn2_flow * input$tpn2_hours / input$weight_tpn * 1000
}


###############################################################################

create_tpnx_table <- function(input) {
    
    twi = calc_twi_tpn1(input)
    
    drug_names <- c(
        input$tpnx_name_01, input$tpnx_name_02, 
        input$tpnx_name_03, input$tpnx_name_04,
        input$tpnx_name_05
    )
    
    drug_flows <- c(
        input$tpnx_flow_01, input$tpnx_flow_02, 
        input$tpnx_flow_03, input$tpnx_flow_04,
        input$tpnx_flow_05
    )
    
    comp <-
        tibble::tibble(
            drug_name = drug_names,
            flow = drug_flows,
        ) |> 
        dplyr::left_join(drug_master, by = "drug_name") |> 
        dplyr::mutate(prod = flow * value) |> 
        dplyr::group_by(element_name) |> 
        dplyr::summarise(sum_prod = sum(prod))
    
    unit_table |> 
        dplyr::left_join(comp, by = "element_name") |> 
        dplyr::mutate(tot = coef * sum_prod / input$weight_tpn * 24000)
    
}


display_tpnx_table <- function(tpnx_table) {
    
    tpnx_table |> 
        dplyr::mutate(total = stringr::str_c(round(tot, digit2), " ", unit2)) |> 
        dplyr::select(
            Element = display_name, 
            Total = total,
        )
    
}

###############################################################################


calc_volume_tpn1 <- function(input) {
    
    total_volume = 0
    total_volume = total_volume + input$tpnx_flow_01
    total_volume = total_volume + input$tpnx_flow_02
    total_volume = total_volume + input$tpnx_flow_03
    total_volume = total_volume + input$tpnx_flow_04
    total_volume = total_volume + input$tpnx_flow_05
    
    total_volume
    
}


create_tpn_table <- function(drug_name, volume, twi) {
    
    input_data <-
        tibble::tibble(
            drug_name = drug_name,
            volume = volume,
        ) |> 
        na.omit() |> 
        dplyr::mutate(
            prop = volume / sum(volume)
        ) |> 
        dplyr::select(drug_name, prop)
    
    comp <- 
        input_data |> 
        dplyr::left_join(drug_master, by = "drug_name") |> 
        dplyr::mutate(prod = prop * value) |> 
        dplyr::group_by(element_name) |> 
        dplyr::summarise(conc = sum(prod))
    
    unit_table |> 
        dplyr::left_join(comp, by = "element_name") |> 
        dplyr::mutate(tot = coef * conc * twi)
    
}


create_tpn1_table <- function(input) {
    
    twi = calc_twi_tpn1(input)
    
    drug_names <- c(
        input$tpn1_name_01, input$tpn1_name_02, input$tpn1_name_03,
        input$tpn1_name_04, input$tpn1_name_05, input$tpn1_name_06,
        input$tpn1_name_07, input$tpn1_name_08, input$tpn1_name_09,
        input$tpn1_name_10, input$tpn1_name_11, input$tpn1_name_12
    )
    
    drug_volume <- c(
        input$tpn1_volume_01, input$tpn1_volume_02, input$tpn1_volume_03,
        input$tpn1_volume_04, input$tpn1_volume_05, input$tpn1_volume_06,
        input$tpn1_volume_07, input$tpn1_volume_08, input$tpn1_volume_09,
        input$tpn1_volume_10, input$tpn1_volume_11, input$tpn1_volume_12
    )
    
    create_tpn_table(drug_names, drug_volume, twi)
    
}

create_tpn2_table <- function(input) {
    
    twi = calc_twi_tpn2(input)
    
    drug_names <- c(
        input$tpn2_name_01, input$tpn2_name_02, input$tpn2_name_03,
        input$tpn2_name_04, input$tpn2_name_05, input$tpn2_name_06,
        input$tpn2_name_07, input$tpn2_name_08, input$tpn2_name_09,
        input$tpn2_name_10, input$tpn2_name_11, input$tpn2_name_12
    )
    
    drug_volume <- c(
        input$tpn2_volume_01, input$tpn2_volume_02, input$tpn2_volume_03,
        input$tpn2_volume_04, input$tpn2_volume_05, input$tpn2_volume_06,
        input$tpn2_volume_07, input$tpn2_volume_08, input$tpn2_volume_09,
        input$tpn2_volume_10, input$tpn2_volume_11, input$tpn2_volume_12
    )
    
    create_tpn_table(drug_names, drug_volume, twi)
    
}


###############################################################################

display_tpn_table <- function(table) {
    
    table |> 
        dplyr::mutate(
            concentration = stringr::str_c(round(conc, digit1), " ", unit1),
            total = stringr::str_c(round(tot, digit2), " ", unit2),
        ) |> 
        dplyr::select(
            Elem. = display_name, 
            Conc. = concentration,
            Total = total,
        )
    
}


###############################################################################

create_tpn_table_all <- function(tpnx_table, tpn1_table, tpn2_table) {
    
    comp <- 
        dplyr::bind_rows(
            tpnx_table |> dplyr::select(element_name, tot),
            tpn1_table |> dplyr::select(element_name, tot),
            tpn2_table |> dplyr::select(element_name, tot),
            .id = "table_number",
        ) |> 
        na.omit() |> 
        dplyr::group_by(element_name) |> 
        dplyr::summarise(tot = sum(tot))
        
    unit_table |> 
        dplyr::left_join(comp, by = "element_name") |> 
        dplyr::mutate(
            total = stringr::str_c(round(tot, digit2), " ", unit2),
        ) |> 
        dplyr::select(
            Element = display_name, 
            Total = total,
        )
    
}


###############################################################################
###############################################################################

source("www/modules/module_01_01.R")
source("www/modules/module_01_02.R")
source("www/modules/module_01_03.R")
source("www/modules/module_01.R")
source("www/modules/module_02.R")
source("www/modules/module_03.R")

###############################################################################
###############################################################################

