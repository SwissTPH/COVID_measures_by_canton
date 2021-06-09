###################################################################
# R script to update the cantonal and federal NPI
###################################################################
# Author: Robert P. Duenner
# Date: 2021-06-08
###################################################################

# Welcome to the all-purpose Swiss cantonal NPI updating script
# This script can to anything from simply expanding the date to 
# the current date, over taking manually updated values from the
# .ods and porting them to other formats, to directly update 
# measures from within here. 

# Note: If you update manually in the .ods, automatic calculation
# of the oxford variables from certain swiss variables is not 
# available


# Set location of directory which contains the updated files from github and this script
directory_location <- ""

# Set file path. Can point to the .csv (faster) or to the .ods (needed for manual updating)
# IMPORTANT: If you have updated any values in the .ods manually and want to keep them, this
# needs to point to the .ods.
file_path <- paste(directory_location, "COVID_measures_CH.ods", sep = "")

# Do you want to just expand the measures to the current date or 
# also update some measures? Date expansion is done either way.
update_measures <- TRUE

# If you have set TRUE and want to update variables, please follow
# the instructions below. Otherwise you are done and can simply 
# source the script.

####################################################################
# The following variables can be set with three levels: 
# school_primary_secondary, school_highschool, school_university, 
# leisure, sport, shops, hairdressers, church, restaurants, clubs.
# Levels: open, open_with_measures, closed.


# The following variables can be set with two levels: 
# home_office_recommended, facial_coverings_shops, 
# facial_coverings_public_buildings, facial_coverings_schools
# Levels: yes, no.


# The following variables can be set numerically:
# restaurants_tablesize, clubs_npeople, public_events_npeople, 
# gatherings_npeople

# The following variables must be set according to the 
# Oxford governement response tracker codebook
# (The codebook is linked in the readme in this GIT.):
# C5_oxford_close_public_transport, C6_oxford_stay_at_home,
# C7_oxford_restriction_internal_movement, 
# C8_oxford_international_travel_control,
# H1_oxford_public_info_campaigns,
# H2_oxford_testing_policy,
# H3_oxford_contact_tracing

# The following variables can either be set according to the
# Oxford governement response tracker codebook,
# or they can automatically be translated from their 
# corresponding swiss coded variables. For legibility 
# they are grouped here:
# C1_oxford_school_closing, this variable corresponds to:
  # school_primary_secondary, school_highschool, school_university
# C2_oxford_workplace_closing, this variable corresponds to: 
  # leisure, sport, shops, restaurants
# C3_oxford_cancel_public_events, this variable corresponds to:
  # gatherings_npeople, public_events_npeople
# C4_oxford_restrictions_on_gatherings_2, this variable corresponds to:
  # gatherings_npeople
# H6_oxford_facial_coverings, this variable corresponds to:
  # facial_coverings_shops, facial_coverings_public_buildings

###############
# Update the values here that you want to be updated
# First set the variable names here as a list, taking the names as characters from above
change_measures_variables = list("public_events_npeople", "gatherings_npeople")

# Then set the variable values here, taking the coding detailed above or in the GitHub readme
# Pay attention that the values are in the same order as the variable names you set above,
# and that they match the variable type (numerical, character, etc.)
change_measures_values = list(100, 30)

# Add the date at which a change in measure takes place
change_measures_date <- "2021-05-31"

# Add the cantons for which the change in measures applies
# Set to "CH" if change applies to federal level and hence all cantons
change_measures_cantons <- "CH" 

# Set if you want the script to automatically translate
# the swiss coded variables to the oxford variables
# If this is set to TRUE, and above both the swiss coded
# and oxford coded variables are updated, then the 
# automatic translation will override the manual set
# values for the oxford coded variables
translate_swiss_coded_variables_to_oxford_variables <- TRUE

###################################################################
# That's it, you can source the script now, the rest is automatic.
# Downstream of here is the code that does the work for you.
# First it expands the dates, then it updates the variables,
# then it translates to oxford variables, recalculates the OCHI,
# loads weather and epidemiological data, and writes to disk
# in several file formats. 

# After this script has run though, you should update the GIT
# repository


####################################################################
####################################################################
####################################################################
# Downstream of here nothing needs to be set, its just how this 
# script works.
# load library
library(data.table)
library(readODS)
library(readxl)

# read from .ods or csv?
if(grep(".ods", file_path, fixed = TRUE) == 1){
  # Read in the .ods file
  current_measures_data_list <- list()
  for (i in 1:27){
    current_measures_data_list[[i]] <- data.table(read_ods(file_path, sheet = i))
  }
  
  # Join the sheets of the .ods
  current_measures_data <- rbindlist(current_measures_data_list)
} else {
  # Read in data
  current_measures_data <- fread(file_path)

}

# Set dates
current_measures_data[, date := as.Date(date)]

# Extract maximum date
max_date <- max(current_measures_data$date)

# Create if section to expand data if necessary

if (max_date < Sys.Date()){
  
  # Create vector of dates to expand
  expansion_dates <- seq.Date(max_date + 1, Sys.Date(), "day")
  
  # Create list to fill in with expanded data
  expansion_data <- list()
  
  # Fill list with copy of newest available data and at the same time update the dates
  for(i in  1:length(expansion_dates)){
    expansion_data[[i]] <- current_measures_data[, .SD[date == max(date)]][, date := rep(expansion_dates[i], 27)]
  }
  
  # Bind old data and new expanded data
  expanded_measures_data <- rbindlist(list(current_measures_data, rbindlist(expansion_data)))
} else {
  expanded_measures_data <- current_measures_data
}

# Sort data table by canton and date
setkey(expanded_measures_data, canton, date)

########################################
# Update the variables that are set above
if(update_measures){
  if (sum(is.na(c(change_measures_date, change_measures_cantons, change_measures_variables, change_measures_values))) > 0){
    print("One or more argument missing, updating not possible!")
    break()
  }
  if(length(change_measures_variables) != length(change_measures_values)){
    print("Not the same number of variable names and values provided, updating not possible!")
    break()
  }
  if(change_measures_cantons == "CH"){
    change_measures_cantons <- unique(expanded_measures_data$canton)
  }
  expanded_measures_data[date >= change_measures_date & canton %in% change_measures_cantons, unlist(change_measures_variables) := change_measures_values]
}

# Translate the swiss coded variables to the oxford government
# response tracker variables
# WARNING: Currently only updates values after the manual updating date
# WARNING: AS the swiss coded and the oxford government response tracker
# variables both are rather coarse, sometimes manual adjustement is necessary.

if (translate_swiss_coded_variables_to_oxford_variables){
  
  # Update C1_oxford_school_closing
  expanded_measures_data[date >= change_measures_date & canton %in% change_measures_cantons, C1_oxford_school_closing := 
                           if(sum(c(school_primary_secondary, school_highschool, school_university) == "open") == 3){0
                            } else if(sum(c(school_primary_secondary, school_highschool, school_university) == "closed") == 3){3
                            } else if(sum(c(school_primary_secondary, school_highschool, school_university) == "open_with_measures") == 3){1
                            } else {2}, by = c("date","canton")]
  
  # Update C2_oxford_workplace_closing
  expanded_measures_data[date >= change_measures_date & canton %in% change_measures_cantons, C2_oxford_workplace_closing := 
                           if(sum(c(leisure, sport, shops, restaurants) == "open") == 4){0
                            } else if(sum(c(leisure, sport, shops, restaurants) == "closed") == 4){3
                            } else if(sum(c(leisure, sport, shops, restaurants) == "open_with_measures") == 4){1
                            } else {2}, by = c("date","canton")]
  
  # Update C3_oxford_cancel_public_events
  expanded_measures_data[date >= change_measures_date & canton %in% change_measures_cantons, C3_oxford_cancel_public_events :=
                           if(gatherings_npeople < 10){2
                            } else if(public_events_npeople == 0){2
                            } else if(public_events_npeople <= 1000 & public_events_npeople != 0){1
                            } else {0}, by = c("date","canton")]
  
  # Update C4_oxford_restrictions_on_gatherings
  expanded_measures_data[date >= change_measures_date & canton %in% change_measures_cantons, C4_oxford_restrictions_on_gatherings :=
                           if(gatherings_npeople > 1000){1
                            } else if(gatherings_npeople > 100 & gatherings_npeople <= 1000){2
                            } else if(gatherings_npeople >= 10 & gatherings_npeople <= 100){3
                            } else if(gatherings_npeople < 10){4
                            } else {0}, by = c("date","canton")]
  
  # Update H6_oxford_facial_coverings
  expanded_measures_data[date >= change_measures_date & canton %in% change_measures_cantons, H6_oxford_facial_coverings :=
                           if(sum(c(facial_coverings_shops, facial_coverings_public_buildings) == "yes") == 2){3
                           } else if(sum(c(facial_coverings_shops, facial_coverings_public_buildings) == "yes") == 1){2
                           } else if(sum(c(facial_coverings_shops, facial_coverings_public_buildings) == "yes") == 0){0
                           }, by = c("date","canton")]

}

########################################
# Re-calculate OCHI
expanded_measures_data[, oxford_containment_health := (1 / 12) * ((100 * (C1_oxford_school_closing  / 3)) + (100 * (C2_oxford_workplace_closing  / 3)) + (100 * (C3_oxford_cancel_public_events / 2)) + (100 * (C4_oxford_restrictions_on_gatherings / 4)) + (100 * (C5_oxford_close_public_transport / 2)) + (100 * (C6_oxford_stay_at_home / 3)) + (100 * (C7_oxford_restriction_internal_movement / 2)) + (100 * (C8_oxford_international_travel_control / 4)) + (100 * (H1_oxford_public_info_campaigns / 2)) + (100 * (H2_oxford_testing_policy / 3)) + (100 * (H3_oxford_contact_tracing / 2)) + (100 * (H6_oxford_facial_coverings / 4)))]

#######################################
# write to different file formats

# Write .ods for all cantons and CH
for (i in unique(expanded_measures_data$canton)){
  write_ods(expanded_measures_data[, .SD[canton == i]], path = paste(directory_location,"COVID_measures_CH.ods", sep = ""), sheet = paste("Measures_", i, sep = ""), append = TRUE, update = TRUE, row_names = FALSE, col_names = TRUE, verbose = TRUE)
}

# Write as .csv but only cantons
fwrite(expanded_measures_data[, .SD[canton != "CH"]], paste(directory_location,"COVID_measures_KT_only.csv", sep = ""))


# Write as .csv but only CH
fwrite(expanded_measures_data[, .SD[canton == "CH"]], paste(directory_location,"COVID_measures_CH_only.csv", sep = ""))

# Write as .csv cantons and CH
fwrite(expanded_measures_data, paste(directory_location,"COVID_measures_CH.csv", sep = ""))


########################################
# NEW 17.12.2020: Add weather data from meteoschweiz
# set up a temporary location to not have to download the dataset everytime one runs the script  # "/tmp/meteo.csv"
download.file("https://data.geo.admin.ch/ch.meteoschweiz.klima/nbcn-tageswerte/liste-download-nbcn-d.csv", paste(directory_location,"meteo.csv", sep = ""))
meteo <- fread(paste(directory_location,"meteo.csv", sep = ""))

# unpack the meteo data from zip
meteo_list_new <- list()
url <- unlist(meteo[1:29, "URL Current year"])
for (i in 1:29){
  meteo_list_new[[i]] <- fread(url[i])
}
meteo_data_new <- rbindlist(meteo_list_new)

# Add past data to get the values for 2020, and also a reference period for future projections
meteo_list_old <- list()
url_old <- unlist(meteo[1:29, "URL Previous years (verified data)"])
for (i in 1:29){
  meteo_list_old[[i]] <- fread(url_old[i])
}
meteo_data_old <- rbindlist(meteo_list_old)
meteo_data_old <-copy(meteo_data_old[date >= 20000101,])

# remove url file from disc
file.remove(paste(directory_location,"meteo.csv", sep = ""))

# add old data to meteo_data
meteo_data <- rbindlist(list(meteo_data_old, meteo_data_new))

# create translation data frame
ct <- meteo[1:29, c("station/location", "Canton")]
names(ct) <- c("station", "Canton")

# translate station names to cantons
meteo_data[, canton := ct[station == `station/location`[1], Canton], by = c("station/location")]

# fix that absolutely abysmal date format
meteo_data[, `:=` (date2 = as.Date(paste(substr(as.character(date), 1, 4), "-", substr(as.character(date), 5, 6), "-", substr(as.character(date), 7, 8), sep = "")))]

# calculate means per date for cantons with several stations
meteo_data[, maximum_temperature := mean(as.numeric(tre200dx), na.rm = TRUE), by = c("canton", "date2")]
meteo_data[, rain := mean(as.numeric(rre150d0), na.rm = TRUE), by = c("canton", "date2")]
meteo_data[, mean_temperature := mean(as.numeric(tre200d0), na.rm = TRUE), by = c("canton", "date2")]
meteo_data[, outdoor_relative_humidity := mean(as.numeric(ure200d0), na.rm = TRUE), by = c("canton", "date2")]

#########
# Indoor relative humidity

# input vectors, humidity in percentages, temperature in °Celsius
outdoor_humidity <- c(meteo_data$outdoor_relative_humidity)
outdoor_temp_C <- c(meteo_data$mean_temperature) 
indoor_temp_C <- 20

# Transform temperature to Kelvin
outdoor_temp_K <- outdoor_temp_C + 273.15
indoor_temp_K <- indoor_temp_C + 273.15

# Calculate maximum  vapor pressure over a surface of water at indoor and outdoor temperature (K)
E_indoor <- exp(-6064.4642 * (indoor_temp_K ^ (-1)) + 21.1249952  - 2.7245552 * (10 ^ (-2)) * indoor_temp_K + 1.6853396 * (10 ^ (-5)) * (indoor_temp_K ^ 2) + 2.4575506 * log(indoor_temp_K)) # Sättigungsdampfdruck
E_outdoor <- exp(-6064.4642 * (outdoor_temp_K ^ (-1)) + 21.1249952  - 2.7245552 * (10 ^ (-2)) * outdoor_temp_K + 1.6853396 * (10 ^ (-5)) * (outdoor_temp_K ^ 2) + 2.4575506 * log(outdoor_temp_K)) # Sättigungsdampfdruck

# Calculate maximum  humidity indoor and outdoor via temperature (K)
P_max_indoor <- E_indoor / (461.5 * indoor_temp_K)
P_max_outdoor <- E_outdoor / (461.5 * outdoor_temp_K)

# Calculate the absolute humidity outdoor
absolute_humidity <- outdoor_humidity * P_max_outdoor

# Calculate indoor relative humidity from outdoor absolute humidity and indoor maximum humidity
indoor_humidity <- absolute_humidity / P_max_indoor

# Cap relative humidity at 100 %
indoor_humidity[indoor_humidity > 100] <- 100

#######
# Add to meteo data
meteo_data[, indoor_relative_humidity := indoor_humidity]

# slim down dataset to relevant variables
weather_data <- copy(meteo_data[, list(date2, canton, maximum_temperature, rain, mean_temperature, outdoor_relative_humidity, indoor_relative_humidity)])

# merge to measure dataset, which will be used downstream to connect to epi data
measures_KT <- merge(expanded_measures_data[, .SD[canton != "CH"]], unique(meteo_data[, .(date2, canton, maximum_temperature, rain, mean_temperature, outdoor_relative_humidity, indoor_relative_humidity)]), by.x = c("date", "canton"), by.y = c("date2", "canton"), all.x = TRUE)

#################################################
# Add epidemiological data from open ZH

# Load the epi data by canton from openZH
download.file("https://raw.githubusercontent.com/openZH/covid_19/master/COVID19_Fallzahlen_CH_total_v2.csv", paste(directory_location,"ogd_zh_ch.csv", sep = ""))

# read in data
ogd_zh_ch <- fread(paste(directory_location,"ogd_zh_ch.csv", sep = ""))

# remove file from disc
file.remove(paste(directory_location,"ogd_zh_ch.csv", sep = ""))

# clean data
ogd_zh_ch[, `:=` (time = NULL, TotalPosTests1 = NULL, ninst_ICU_intub = NULL, current_quarantined_total = NULL)]

# rename data
names(ogd_zh_ch) <- c("date", "canton", "cumulative_tested", "cumulative_cases", "new_hospitalisations", "current_hospitalisations", "current_intensive_care", "current_ventilated", "cumulative_hospital_released", "cumulative_deceased", "source", "current_isolated", "current_quarantined", "current_quarantined_riskareatravel")

# Set dates
ogd_zh_ch[, `:=` (date = as.Date(date, format = "%Y-%m-%d"))]

# Merge the measures dataset and the epi data by applying a left outer join
covid_canton_openZH <- merge(measures_KT, ogd_zh_ch, by.x = c("date", "canton"), by.y = c("date","canton"), all.x = TRUE)

# Write the combined dataset as .csv
fwrite(covid_canton_openZH, paste(directory_location,"COVID_measures_KT_epi_openZH.csv", sep = ""))
