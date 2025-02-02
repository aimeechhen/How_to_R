
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
# combine together as one list
rds_dat <- do.call(c, rds_list)




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



