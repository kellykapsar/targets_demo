# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("tidyverse", "zoo") # packages that your targets need to run
)

# Run the R scripts in the R/ folder with your custom functions:
scripts <- list.files("R/", full.names = TRUE)
sapply(scripts, source)

# Replace the target list below with your own:
list(
  tar_target(
    name = data,
    command =read_csv(url("https://raw.githubusercontent.com/planetsig/ufo-reports/master/csv-data/ufo-scrubbed-geocoded-time-standardized.csv"), 
                      col_names = c("datetime", 
                                    "city", 
                                    "state", 
                                    "country", 
                                    "shape", 
                                    "duration_seconds", 
                                    "duration_hrs", 
                                    "description", 
                                    "date", 
                                    "lat", 
                                    "lon"))),
  
  tar_target(name = cleanData, 
             command = clean_data(data)),  
  
  tar_target(name = plot1, 
               command = plot_data(cleanData))
)
