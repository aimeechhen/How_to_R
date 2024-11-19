

#put a solid black line, you can change the "#px" to change the size eg. 5px for R Markdown
<div style="border-bottom: 3px solid black;"></div>



#_________________________________________________________________________
# Data wrangling ----

#convert list into a dataframe
mw.dat <- do.call(rbind, lapply(RESULTS, as.data.frame))

#subset or drop data based on conditions
goat_data <- goat_data[!(goat_data$date <= "2019-06-23"),]

#combine two datasets and not including a certain condition via filter() using dplyr package
goat_data <- left_join(goat_data, filter(goat_info, goat_id != "CA03"), by = "collar_id")

grepl() # select objects that contains certain text
hr.shp <- combined_sf[grepl("95% est", combined_sf$name), ]

rownames()
df$column <- rownames(df) #extract rownames into column
colnames(mw.dat)[2] <- 'timestamp' #rename column, simplied
colnames(mw.dat)[colnames(mw.dat) == 'Time'] <- 'timestamp' ##rename column, more explicit

library(stringr)
str_detect() # select objects that contains certain text
hr95.shp = hr.shp[str_detect(hr.shp$name, "est"),]


#...................................................................
# Temporal attributes ----
library(lubridate)

#check timezone
attr(df$timestamp[1], "tzone")

# format time from HHMM into to HH:MM:SS
df$time <- format(strptime(df$time, format = "%H%M"), format = "%H:%M:%S")
# combine date and time into timestamp
df$timestamp <- ymd_hms(paste(df$date, df$time))
# format character type into posixct type, when timestamp isn't in typical format eg. "%Y.%m.%d %H:%M:%S"
df$timestamp <- as.POSIXct(df$timestamp, format = "%Y.%m.%d %H:%M:%S")
# Combine date and time columns into a single POSIXct timestamp
df$timestamp <- as.POSIXct(paste(df$date, df$time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
# convert timezone
df$timestamp <- with_tz(df$timestamp, tzone = "America/Los_Angeles")

# Lubridate package
time_window <- hours(1)  # Using lubridate, note this comes out as a 'period' object



#...............................................
# for loops ----
for (i in 1:nrow(x)) {
perimeter <- x[i,]
}

# to indicate you only want to loop through rows 1-8 because of this df[i,] where i in located in rows
for (i in 1:8) {
  # extract perimeter for the current row
  perimeter <- df[i,]
}


# Combine the results into a data frame 
df <- data.frame(matrix(unlist(results), ncol=length(results), byrow=TRUE))


# create object if it doesn't exist then do something
# example if raster doesn't exist, then create an empty raster and set values to 0
if (!exists("first_ignition_time")) {
  first_ignition_time <- raster_perimeter
  values(first_ignition_time) <- 0  # Set initial values to 0
}

fire_cell <- which(values(raster_perimeter) == 1)

print(range(values(r))) # for raster
print(range(as.vector(m))  )  # for matrix


# How to extract text ----

#extract filename from filepath
id_full <- "NOAA/GOES/18/FDCF/2023233000020400000"
id_portion <- basename(id_full)

#extract text before the first _ underscore (i.e. season)
dat.hr$season <- sub("^(.*?)_.*", "\\1", dat.hr$individual.local.identifier)
#extract text after the first _ underscore and before the second _ underscore (i.e. period)
dat.hr$period <- sub("^[^_]*_(.*?)_.*", "\\1", dat.hr$individual.local.identifier)
#extract text after the second _ underscore (i.e. collar_id)
dat.hr$collar_id <- sub("^(?:[^_]*_){2}(.*)", "\\1", dat.hr$individual.local.identifier)


# searches for string of text and extract information from 'individual.local.identifier' column and puts a string of text into a new column based on those conditions
rsf_coeff$season <- NA
rsf_coeff[grepl("spring", rsf_coeff$individual.local.identifier),"season"] <- "spring"
rsf_coeff[grepl("summer", rsf_coeff$individual.local.identifier),"season"] <- "summer"





#_________________________________________________________________________
# Save outputs into a textfile ----

sink() # export and save output of function, requires to terminate exportation process once completed 



#export and save summary output to a textfile
sink("data/home_range/m_hr_spring_summary.txt")
print(summary(m_hr_spring))
cat("\n") #enter blank line
# calculate the CI values
print("CI Values (lower, upper)")
# est + upper & lower z-score * std err
print(-0.1105 + c(-1.96,1.96) * 0.1670)
sink() #terminate output exporting connection/process (multiple functions can be exported)


#_________________________________________________________________________


# create new dataset based on making all the possible combinations
newd <- expand_grid(
  Time = seq(0, 21, length.out = 400),
  Diet = unique(ChickWeight$Diet), # since we are using fixed effects
  Chick = 'new chick') # since we are using random effects


dt = 1 %#% 'day' # '%#%' This converts it into days (si units), you can replace day with another unit




# check data type of covariates
datatype(elev) #FLT4S: 32-bit float (single precision) .-. numerical
#inspect values and check range of value
range(values(elev), na.rm = TRUE)