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
        
        module_01,
        module_02,
        module_03,
        
    )
)
