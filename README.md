# RShinyproject
The app gets data from a EUROSTAT database (data downloaded from https://ec.europa.eu/eurostat/databrowser/view/hlth_hlye/default/table?lang=en and stored in the .csv file). 
The data collected is on the distribution of healty life years across the EU (timespan: 2010-2019).
By selecting the country (or countries) of interest (using the drop-down menu) and the time-range of interest (using the slider), the user filters out data and can check for time-trends in healthy life years and/or visualize HLY's differences between units (countries of interest).
An interactive plot depicts the Healthy Life Years (along the years) for the user-selected EU countries of interest.

NOTE:  default options are none for country and 2010-2019 for time-range.

NOTE: To run the app please see the testing directory. The tester could either:
OPTION 1 - run the following commands:
library(shiny)
shiny::runGitHub("RShinyproject","zulai98")

or
OPTION 2 -download the project, unzip it, move it to the Downloads directory and run the following commands: 
library(shiny)
setwd("C:/Users/Admin/Downloads")
runApp("RShinyproject")