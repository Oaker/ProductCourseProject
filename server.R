library(shiny)

e <- globalenv()

experiment<-function(lambda,n,len,distr) {
  
  if (distr=="Exponential") {
  matrixExp<-matrix(rexp(n*len,lambda),n,len)
  means<-apply(matrixExp,1,mean)
  
  }
  else{ 
    matrixExp<-matrix(rpois(n*len,lambda),n,len)
    means<-apply(matrixExp,1,mean)
    
  }
  means
}

lambda<-0.2
n<-1000
len<-10


means<-experiment(lambda,n,len,"Exponential")

e$tmean<-round(1/lambda,2)
e$tvar<-round(1/(lambda^2*len),2)
e$smean<-round(mean(means),2)
e$svar<-round(var(means),2)



shinyServer(
  function(input, output) {
    
    e$distr <- reactive({
      input$distrib
    })
    
  
    output$pl <- renderPlot({  
      
      lambda<-input$lambda
      n<-input$n
      len<-input$len
      
      means<-experiment(lambda,n,len,distr())
      
      
      
      e$smean<-round(mean(means),5)
      e$svar<-0
      e$svar<-round(var(means),5)
      
      
      d<-distr()
      if(distr()=="Exponential") {
        e$tvar<-round(1/(lambda^2*len),5)
        e$tmean<-round(1/lambda,5)
      }
       else
       {
         e$tvar<-lambda
         e$tmean<-lambda
         e$svar<-e$svar*len
       }
    
      
    
      hist(means,col="gray",labels=TRUE,probability=T, main="Distribution plot",freq=F)
      lines(density(means))
      #curve(dnorm(x,mean=tmean,sd=sqrt(tvar)), col="red", add=T)
 
      output$tmean <- renderPrint({e$tmean})
      output$smean <- renderPrint({e$smean})
      output$tvar <- renderPrint({e$tvar})
      output$svar <- renderPrint({e$svar})
       
    })
    
  }
)