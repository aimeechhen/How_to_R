

#put a solid black line, you can change the "#px" to change the size eg. 5px for R Markdown
<div style="border-bottom: 3px solid black;"></div>

# how to compare scripts for differences
library(diffr)
# will open in Viewer to display side by side
diffr("filename1", "filename2")
  
  
excel_sheets(file) # list all the sheet names in the excel file

#____________________________________________________________
# object/element types ----

names(x)
slotNames(x) # slot objects (s4)
str(x) # structure of object
class(x) # object type
head(x) # beginning of df
tail(x) # end of the df










#_________________________________________________________________________
# Data wrangling ----

# add goat_name column, match them based on collar_id
HR_size$collar_id <- collar_data$collar_id[match(HR_size$goat_name, collar_data$goat_name)]

#Split the column into multiple rows
df_expanded <- separate_rows(df, your_column, sep = ",")

#convert list into a dataframe
mw.dat <- do.call(rbind, lapply(RESULTS, as.data.frame))

#subset or drop data based on conditions
goat_data <- goat_data[!(goat_data$date <= "2019-06-23"),]

#combine two datasets and not including a certain condition via filter() using dplyr package
goat_data <- left_join(goat_data, filter(goat_info, goat_id != "CA03"), by = "collar_id")


rownames()
df$column <- rownames(df) #extract rownames into column
colnames(mw.dat)[2] <- 'timestamp' #rename column, simplified
colnames(mw.dat)[colnames(mw.dat) == 'Time'] <- 'timestamp' ##rename column, more explicit


# store models/UDs in a list, name the entry based on goat name and subset window start date, not the times[i] as that is in unix format (this is for a for loop)
fits[[paste0(DATA@info[1], "_", as.character(WINDOW_START))]] <- FITS

# Compare two columns
head(df[, c("a", "b")])

# create a dataframe -> Combine the lists into a dataframe and set the column names to match
df <- setNames(as.data.frame(do.call(cbind, list(goat_name, window_start, window_end, n_fixes, mean_elev, mean_dist_escape))), 
                       c("goat_name", "window_start", "window_end", "n_fixes", "mean_elev", "mean_dist_escape"))
# without having to manually rename the columns -> combine into a tibble then convert into a dataframe
df <- as.data.frame(tibble(goat_name, window_start, window_end, n_fixes, mean_elev, mean_dist_escape))

# Combine the results into a data frame 
df <- data.frame(matrix(unlist(results), ncol=length(results), byrow=TRUE))


# create object if it doesn't exist then do something -> example if raster doesn't exist, then create an empty raster and set values to 0
if (!exists("first_ignition_time")) {
  first_ignition_time <- raster_perimeter
  values(first_ignition_time) <- 0  # Set initial values to 0
}

fire_cell <- which(values(raster_perimeter) == 1)

print(range(values(r))) # for raster
print(range(as.vector(m))  )  # for matrix


# remove unnecessary characters ("[", " ", etc.) and replace with "_", useful for cleaning column names
janitor::clean_names() 

# combine two dataframes and match the same column names together and whatever columns are missing, they are just added and given NA values
combined_df <- bind_rows(df1, df2)

# combine two df by rownames (i.e. adding columns of df2 to df1 and matching based on row names)
merge(df1, df2, by = 0, all.x = TRUE)

#..................................................
# Expressions, character strings etc ----
#..................................................


grepl() # select objects that contains certain text
# Examplse:
df <- combined_sf[grepl("95% est", combined_sf$name), ]
strictosidine <- df[grepl("strictosidine", df$ann_cro_2, ignore.case = TRUE), ]
tau_p <- summary[grepl("position", rownames(summary)),] # extract the row with the rowname that contains the text string
# some are in hours and mostly in days, so convert the ones with hour units into day units (i.e. 24 hours)
tau_p[grep("hours", rownames(tau_p)), ] <- tau_p[grep("hours", rownames(tau_p)), ] / 24

# searches for string of text and extract information from 'individual.local.identifier' column and puts a string of text into a new column based on those conditions
df$season <- NA
df[grepl("spring", df$individual.local.identifier),"season"] <- "spring"
df[grepl("summer", df$individual.local.identifier),"season"] <- "summer"


library(stringr)
str_detect() # select objects that contains certain text
hr95.shp <- df[str_detect(df$name, "est"),]


#......................................................................
## How to extract text ----

#extract filename from filepath
id_full <- "NOAA/GOES/18/FDCF/2023233000020400000"
id_portion <- basename(id_full)

#extract text before the first _ underscore (i.e. season)
df$season <- sub("^(.*?)_.*", "\\1", df$individual.local.identifier)
#extract text after the first _ underscore and before the second _ underscore (i.e. period)
df$period <- sub("^[^_]*_(.*?)_.*", "\\1", df$individual.local.identifier)
#extract text after the second _ underscore (i.e. collar_id)
df$collar_id <- sub("^(?:[^_]*_){2}(.*)", "\\1", df$individual.local.identifier)
# extract the goat name from individual.local.identifier, i.e. drop the "_year" portion
df$goat_name <- gsub("_[0-9]{4}$", "", df$individual.local.identifier)
# extract the year, i.e. last 4 digits after the _
df$year <- gsub(".*_([0-9]{4})$", "\\1", df$individual.local.identifier)

# trying to get all the names of an object via copy and paste so you don't have to manually type it out and remove all the trailing spaces so you dont have to manually backspace or delete either
cat(paste0('"', (sub("[ \t]+$", "", names(x))), '",\n'))
# then copy and paste from the console to your script and just delete all the space in front at once (ctrl + alt + down arrow) via multi-line select

#......................................................................
## How to replace text across multiple scripts----

# list all the scripts in the folder that you want to edit and all the subfolders
scripts <- list.files("./path/to/folder", pattern = "\\.R$", recursive = TRUE, full.names = TRUE)

# text youre trying to find and replace
old_text <- "xyz"
new_text <- "abc"

# go through all the scripts
for (file in scripts) {
  lines <- readLines(file) # read the scripts
  lines <- gsub(old_text, new_text, lines) # find the text or string and replaces it
  writeLines(lines, file) #save the editing
}






#......................................................................
# how to print messages ----
#......................................................................

library(crayon) # to change message colours

# print a message every 2000 iterations to track progress
if (j %% 2000 == 0) {
  cat("Completed", j, "iterations\n")
}










#//////////////////////////////////////////////////////////////////


# check data type of covariates
datatype(elev) #FLT4S: 32-bit float (single precision) .-. numerical
#inspect values and check range of value
range(values(elev), na.rm = TRUE)


# check if all rows have the same values between two columns, ensure both are the same object type
identical(df$col1, df$col2)
# identify which rows are not matching
which(df$col1 != df$col2)
# comparing df to see if they are the same or not
df1[which(rowSums(df1 != df2) > 0), ] #the > 0 means any differences in the rows that is greater than 0 i.e. none or no differences, set to = if you want to see no differences


# check for duplicates, which rows have the same values in the columns
df[which(duplicated(df[ , c("x_", "y_", "t_")])), ]
# check for duplicates which rows that are duplicated (the | is to check in both direction, i.e., includes the row and the matching row -> if a was matched with c then a gets included in the print out not just c, and vice versa, if z gets matched with x)
df[which(duplicated(df[, c("x_", "y_", "t_")]) | duplicated(df[, c("x_", "y_", "t_")], fromLast = TRUE)), ]

# checks to see if a row has the same value as the row before it
which(diff(df$x) == 0)

# to figure out what caused the warning message when fitting model
diagnose(model)

# check for NA or Inf infinite values
sapply(df, function(x) sum(is.na(x))) # checking across all columns
sapply(df, function(x) sum(is.infinite(x))) # checking across all columns



#//////////////////////////////////////////////////////////////////
# Temporal attributes ----
library(lubridate)

#check timezone
attr(df$timestamp[1], "tzone")
tz(collar_data$timestamp)
TIMESTAMP <- as.POSIXct(df, 
                        origin="1970-01-01", # add if in Unix timestamp format to convert
                        tz = lutz::tz_lookup_coords(df$latitude[1],
                                                    df$longitude[1],
                                                    method = "fast")) # fast method is used because all the data are in the same timezone, adjust if they cross timezone boundaries

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
# format into HH:MM:SS but no longer will be a posixct (requires date and time) this will become a character object
df$time <- format(df$timestamp, format = "%H:%M:%S") # turns into character

# modifying the year of the timestamp and put it in a new column
df$timestamp_2021 <- df$timestamp
year(df$timestamp_2021) <- 2021

# Lubridate package
time_window <- hours(1)  # Using lubridate, note this comes out as a 'period' object


dt = 1 %#% 'day' # '%#%' ctmm package feature -> This converts it into days (si units), you can replace day with another unit





#//////////////////////////////////////////////////////////////////









#_________________________________________________________________________


# create new dataset based on making all the possible combinations
newd <- expand_grid(
  Time = seq(0, 21, length.out = 400),
  Diet = unique(ChickWeight$Diet), # since we are using fixed effects
  Chick = 'new chick') # since we are using random effects







#//////////////////////////////////////////////////////////////////
# for loops ----
for (i in 1:nrow(x)) {
  perimeter <- x[i,]
}

# to indicate you only want to loop through rows 1-8 because of this df[i,] where i in located in rows
for (i in 1:8) {
  # extract perimeter for the current row
  perimeter <- df[i,]
}






# For Reo ----
# i want to take values from other columns (i.e X.1, X.2) and move them into Ret.time and AuC column while keeping the same tissue type
# then repeat this for every row

# Create a new empty data frame
new_dat <- data.frame(Tissue = character(), 
                      Ret.time = numeric(), 
                      AuC = numeric(), 
                      stringsAsFactors = FALSE)
# Loop through all rows in dat
for (i in 1:nrow(dat)) {
  # Add first row
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = dat$Ret.time[i], 
                                       AuC = dat$AuC[i]))
  # Add rows for X.1 and X.2 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$X.1[i]), dat$X.1[i], NA), 
                                       AuC = ifelse(!is.na(dat$X.2[i]), dat$X.2[i], NA)))
  # Add rows for X.4 and X.5 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$X.4[i]), dat$X.4[i], NA), 
                                       AuC = ifelse(!is.na(dat$X.5[i]), dat$X.5[i], NA)))
}
