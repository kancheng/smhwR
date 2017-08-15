library("shiny")
library("DT")
library("quantmod")
ui = shinyUI(
	fluidPage(
		titlePanel(" Hello, World! - Stock Market"),
  
		sidebarLayout(
			sidebarPanel(
				h2( "Enter an abbreviation for name" ),
				helpText("The default is Dow Jones Industrial"),
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