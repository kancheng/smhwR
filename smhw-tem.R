library("shiny")
library("DT")
library("quantmod")
ui = shinyUI(
	fluidPage(
		titlePanel(" Hello, World! - Stock Market"),
  
		sidebarLayout(
			sidebarPanel(
				h2( "Enter an abbreviation for name" ),
				helpText("The default is Dow Jones Industrial "),
				helpText("ex :  Dow Jones Industrial (^DJI), TSMC (2330.TW)."),
				textInput("canpabbnm", "", value = "^DJI" ),
				submitButton("Submit", icon("refresh"), width = "40%")
			),
			mainPanel(
				tabsetPanel(
					tabPanel("Plot",
						br(),
						plotOutput("smplot") 
					),
					tabPanel("Data",
						br(),
						DT::dataTableOutput("smtable")
					),
					tabPanel("summary",
						br(),
						verbatimTextOutput("smsumy")
					),
					tabPanel("Output",
						br(),
						downloadButton('smdlcsv', 'Download')
					)

				)
			)
		)
	)
)
server = function(input, output) {
	# tem
	tmsp = reactiveValues()
  	output$smplot = renderPlot({
		tmsp$temcanpabbnm = input$canpabbnm
		tmsp$temcanp = getSymbols( tmsp$temcanpabbnm, auto.assign=FALSE)
		chartSeries( tmsp$temcanp, theme = chartTheme("white"))

	})

	output$smtable = DT::renderDataTable({
		tmsp$temcanpabbnm = input$canpabbnm
		tmsp$temcanpdf = as.data.frame(getSymbols( tmsp$temcanpabbnm, auto.assign=FALSE))
		DT::datatable(tmsp$temcanpdf , options = list(pageLength = 25))
	})

	output$smsumy = renderPrint({
		tmsp$temcanpabbnm = input$canpabbnm
		tmsp$temcanpdf = as.data.frame(getSymbols( tmsp$temcanpabbnm, auto.assign=FALSE))
		summary(tmsp$temcanpdf)
	})
	output$smdlcsv = downloadHandler(
		filename = function() { 
			paste( "sm", '.csv', sep = '') 
			tmsp$sdc = as.character(Sys.time())
			tmsp$sdc1t = gsub( ":", " ", tmsp$sdc)
			tmsp$sdc2t = gsub( "-", " ", tmsp$sdc1t)
			tmsp$sdc3t = paste(strsplit( tmsp$sdc2t ,split = " ", fixed = T)[[1]],collapse="")
			paste( "sm_", tmsp$sdc3t, ".csv", sep = '') 

		},
		content = function(file) {
			tmsp$temcanpabbnm = input$canpabbnm
			tmsp$temcanpdf = as.data.frame(getSymbols( tmsp$temcanpabbnm, auto.assign=FALSE))
			write.csv( tmsp$temcanpdf, file = file, quote = FALSE, sep = ",", row.names = FALSE)
		}
	)
}
