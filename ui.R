library(shiny)

# Define UI
ui <- shinyUI( fluidPage(
    # Title
    titlePanel("A simple cluster analysis"),
    sidebarLayout(
        #  
        sidebarPanel(
            h3("Clustering options"),
            helpText("Note: Play with all options. Enjoy!!!") ,
            sliderInput("clusters", "Number of clusters:", 2, 12, 5),
            radioButtons("rb", "Variable transformation",
                         c("Raw variables" = "raw",
                           "Standardized variables" = "sd")),
            br(),
            strong("Variables selection"),
            checkboxInput("Murder",  "Murder arrests (per 100 000)",   TRUE) ,  
            checkboxInput("Assault", "	Assault arrests (per 100 000)",      TRUE) ,
            checkboxInput("UrbanPop",   "Percent urban population",  FALSE) ,
            checkboxInput("Rape", "Rape arrests (per 100 000)",   FALSE)  ,
            
            radioButtons("method_c", "Clustering method",
                         c("Ward" = "ward.D",
                           "Complete Linkage" = "complete",
                           "Centroid" = "centroid")),
            radioButtons("dist", "Distance",
                         c("Euclidean" = "euclidean",
                           "Maximum" = "maximum"))
        ),
        mainPanel(
            h3("Dendogram"),
            plotOutput("dendogram"),
            span(textOutput("error"), style="color:red")
        )
    )
))
