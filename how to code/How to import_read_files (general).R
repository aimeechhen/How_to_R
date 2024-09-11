
# How to import files (general)

# from a directory/folder
# from a csv
# from a spatial object (raster or shape file)
# from google drive
# from a google sheet



# directory/folder including their subfolders ----









# csv ----

df <- read.csv("data/df.csv")



# from a spatial object (raster or shape file)

shp_file <- st_read("data/shapefile.shp")
raster_file <- rast("data/raster.tif")



# from google drive ----
library(googledrive)




# from a google sheet ----

library(googlesheets4)






# Spatial ----

library(sf)
library(raster)
library(terra)

# Set folder path where the files are located
folder_path <- "data/home_range"

# Load .shp, .tif etc files within a folder including all the subfolders
shp_files <- list.files(path = folder_path, pattern = "\\.shp$", recursive = TRUE, full.names = TRUE)

# Import/read all the files into a list
shp_list <- lapply(shp_files, st_read)

# Extract file names and assign names to the list
names(shp_list) <- gsub("\\.shp$", "", basename(shp_files))

# Combine shapefiles
shp_dat <- do.call(rbind, shp_list)


#.............................................

# Load .shp, .tif etc files within a folder including all the subfolders
rast_files <- list.files(path = folder_path, pattern = "\\.tif$", recursive = TRUE, full.names = TRUE)

# Import/read all the files into a list
rast_list <- lapply(rast_files, rast)

# Extract file names and assign names to the list
names(rast_list) <- gsub("\\.tif$", "", basename(rast_files))



