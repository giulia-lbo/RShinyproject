#### Libraries
library(ggplot2)
library(shiny)
library(dplyr)  
library(rcartocolor)
library(readr)
library(plotly)

setwd("~/RShinyProject")

nb.cols <- 28
safe_pal<- colorRampPalette(carto_pal(12, "Safe"))(nb.cols)
# Dataset
data = readr::read_csv("data.csv")
#Renaming columns
data<- data %>% 
  rename(
    country = 1,
    healthy_years = 2, 
    year= 3
  )
### Begin ui -------------------------------------------------------------------

ui<-fluidPage(
  
  #introduction text
  fluidRow(
    column(12,
           titlePanel('Living longer: the golden dream?'),
           p('We know people are living longer...
                     However, do we live longer and better or do we gain only years of life in bad health?'),
           p('By measuring the number of remaining years that a person is expected to live without any severe to moderate "health problems", HLY combines mortality data with health status data.
    In this study, health problems are measured wrt the extent of the debilitating long-term limitations (for at least six months) on usual day-to-day activities.
      The indicator may also be called disability-free life expectancy (DFLE).'),
    )),
  br(),
  ### Sidebar panel ----------------------------------------------------------
  sidebarLayout(
    sidebarPanel(
      ### Conditional Panels ----------------------------------------------------------
      helpText("1. Choose one (or more) countries"),
      selectInput(
        inputId = 'countries',
        label = 'Select',
        choices = data$country,
        multiple= TRUE),
    ),# END sideBarPanel
    
    mainPanel(
      column(12,
             p('The graph below depicts average number of healthy years for individuals in all EU member states.
              Select a country or a number of countries from the dropdown menu to the left.'),
             plotlyOutput("linegraph1"))
      
      
    ) # END mainPanel
  ) #END sidebarLayout
) # END fluid page

# Define server logic
server <- (function(input, output) {
  
  output$linegraph1<- renderPlotly({
    
    data1<-data %>%
      filter(country %in% input$countries)
    
    liv_healthy_years<- 
      ggplot(data1, aes(x=year, y= healthy_years)) +
      geom_path(aes(group=country, 
                    color=country,
                    ids=country),
                size= 0.75)+
      geom_text(data = data1 %>% filter(year == last(year)),
                aes(label = country, 
                    x = year + 0.5, 
                    y = healthy_years, 
                    color = country),
                size=3,
                fontface = "bold") +
      scale_x_continuous(breaks = seq(2010, 2019, by = 1))+
      labs(title = "Average Healthy Life Years across Europe",
           x= "Year",
           y= "Healthy Life Years (HLY)")+
      theme(plot.title = element_text(face="bold"),
            axis.text.x = element_text(size=10.5, angle=45,  hjust = 1),
            axis.title.x = element_text(face="bold"),
            axis.title.y = element_text(face="bold"),
            axis.text.y = element_text(size=10.5),
            legend.position = "none")+
      scale_color_manual(values=safe_pal)
    liv_healthy_years <- ggplotly(liv_healthy_years)%>% 
      animation_opts(
        frame = 150, 
        transition = 0, 
        redraw = FALSE
      )
    liv_healthy_years
    
    
  })
  
  
})

# Run the application 
shinyApp(ui = ui, server = server)
