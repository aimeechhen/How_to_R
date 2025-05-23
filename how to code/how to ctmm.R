
# How to ctmm

#............................................................................
# ctmmweb ----
#............................................................................

# if you want to use ctmmweb instead of coding

# Install and run the app -> open Rstudio and run in the console

if (!require("remotes")) install.packages("remotes")
remotes::install_github("ctmm-initiative/ctmmweb")

ctmmweb::app()



#............................................................................
# ctmm data prep ----
#............................................................................

# Format column names to match based on Movebank critera, a requirement for ctmm 

# ID = individual.local.identifier
# timestamp = timestamp (needs to be in the format of: as.POSIXct(df$timestamp, format = "%Y-%m-%d %H:%M:%S")
# latitude = location.lat
# longitude = location.long


#............................................................................
# ctmm telemetry object ----
#............................................................................


# convert to ctmm telemetry object
as.telemetry() 
# When converting into as.telemetry() object, ctmm will create a dataframe (or list if there are tracking data for multiple individuals) with the following columns
names(tel_data)
# [1] "timestamp" "longitude" "latitude"  "t"         "HDOP"      "x"         "y" 

# description of each column:
#   
# timestamp: The original time data, usually in a date-time format ("%Y-%m-%d %H:%M:%S").
# longitude: The longitude coordinate of the tracking data.
# latitude: The latitude coordinate of the tracking data.
# t: Numeric representation of the timestamp, often used for calculations.
# HDOP: Horizontal Dilution of Precision, a measure of the accuracy of the GPS data.
# x: The x-coordinate in a projected coordinate system (e.g., UTM).
# y: The y-coordinate in a projected coordinate system (e.g., UTM).
# 
# Example:
head(tel_data)
# timestamp longitude latitude          t HDOP          x        y
# 2374 2023-01-01 02:45:38 -120.1634 49.03759 1672569938  1.4  -899.0965 1028.434
# 2375 2023-01-01 09:01:56 -120.1635 49.03758 1672592516  1.4  -905.3372 1021.851
# 2376 2023-01-01 15:15:38 -120.1623 49.04228 1672614938  1.8 -1136.9943 1499.506
# 2377 2023-01-01 21:30:37 -120.1626 49.03711 1672637437  1.8  -823.0678 1016.954
# 2378 2023-01-02 03:45:38 -120.1629 49.03842 1672659938  1.4  -925.5369 1123.293
# 2379 2023-01-02 10:00:38 -120.1634 49.03747 1672682438  2.0  -892.6918 1015.719

# from the first line -> '1672569938'  means 2023-01-01 02:45:38

# t = contains the Unix timestamp, which is the number of seconds that have elapsed since 00:00:00 UTC on 1 January 1970 (also known as the Unix epoch)

# To convert Unix timestamp to regular format use:
timestamp_example <- 1672569938 # example from above
converted_time <- as.POSIXct(timestamp_example, origin="1970-01-01", tz="UTC")
converted_time
# [1] "2023-01-01 02:45:38 UTC"




#............................................................................
# Fit movement models ----
#............................................................................

# before any models are fitted, ensure your data are cleaned and calibrated





#............................................................................
# Inspect movement models ----
#............................................................................

# fitted models
# check to see if the units are all the same
summary_outputs <- data.frame()
for (i in seq_along(FITS)) {
  summary <- summary(FITS[[i]], units = FALSE)$CI # using SI units
  summary_outputs <- rbind(summary_outputs, 
                           data.frame(Var1 = names(table(rownames(summary))), 
                                      Freq = as.integer(table(rownames(summary)))))
}

summary_outputs <- aggregate(Freq ~ Var1, data = summary_outputs, FUN = sum)
summary_outputs


# if you want specific rownames and not all
summary_outputs <- rbind(summary_outputs, 
                         data.frame(Var1 = rownames(summary[grepl("velocity", rownames(summary)), ]), 
                                    Freq = as.integer(table(rownames(summary[grepl("velocity", rownames(summary)), ])))))





# use meta() when trying to get information on a population level or two individuals to know them as a group
# use summary()$CI or whatever if you want to look at individuals only
# if you're trying to find the mean of a year for example, go with meta