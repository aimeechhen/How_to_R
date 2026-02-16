
# How to import files (general)

# from a directory/folder
# from a csv
# rds file
# from google drive
# from a google sheet



#_______________________________________________________
# directory/folder including their subfolders ----



# csv ----

df <- read.csv("data/df.csv")


#_______________________________________________________

#..........................................
# RDS files

# Set the folder path
folder_path <- "data/rds"
# Load .shp, .tif etc files within a folder including all the subfolders
rds_files <- list.files(folder_path, pattern = "\\.rds$", full.names = TRUE)
# Import/read all the files into a list
rds_list <- lapply(rds_files, readRDS)
# combine together as one list OR
rds_single_list <- do.call(c, rds_list)
# combine into df
rds_data <- do.call(rbind, rds_list)

# if you want specific files that contain particular text string (i.e., there are other files in the folder and you dont want all of them), ignore.case = TRUE -> not case sensitive
rds_files <- list.files(folder_path, pattern = ".*text_string.*\\.rds$", full.names = TRUE,  ignore.case = TRUE)


#_______________________________________________________
#_______________________________________________________
# from google drive ----
library(googledrive)



#_______________________________________________________
#_______________________________________________________
# from a google sheet ----

library(googlesheets4)






#_______________________________________________________
#_______________________________________________________



