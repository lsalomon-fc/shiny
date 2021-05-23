library(shiny)

shinyServer(function(input, output) {
    
    data(USArrests)
    data <- as.matrix(USArrests)
    normalized_func <- function(x){ (x-mean(x))/sd(x) }               
    normalized_data <- sapply(USArrests, "normalized_func")        
    rownames(normalized_data) <- rownames(data) 

    output$text <- renderText(input$clusters)
    output$text2 <- renderText(input$rb)
    
    output$dendogram <- renderPlot({
        
        variables_included <- c(input$Murder, input$Assault, input$UrbanPop, input$Rape)
        if (sum(variables_included)==0){ 
            output$error <- renderText({"Please select at least one variable on the left panel"})
        }else{
            output$error <- renderText(" ")
            if (input$rb=="raw"){ 
                distance_matrix <- dist(data[, variables_included], method = input$dist) 
            }else{
                distance_matrix <- dist(normalized_data[, variables_included], method = input$dist) 
            }
            fit <- hclust(distance_matrix, method=input$method_c)                            
            plot(fit,sub = NA, xlab = NA, ylab = NA)     
            rect.hclust(fit, k=input$clusters, border="red")               
        }
        
    })
    
})



