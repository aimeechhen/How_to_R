
# How to import files (general)

# from a directory/folder
# from a csv
# from a spatial object (raster or shape file)
# from google drive
# from a google sheet


#_______________________________________________________
#_______________________________________________________
# directory/folder including their subfolders ----









# csv ----

df <- read.csv("data/df.csv")


#_______________________________________________________
#_______________________________________________________
# Spatial ----

# single spatial object (raster or shape file)

library(sf)
# import shapefile
shp_file <- st_read("data/shapefile.shp")
# inspect layers
st_layers(shp_file)
# save shapefile
st_write(shp_file, dsn = 'data/shapefile', 
         driver = 'ESRI Shapefile', append=FALSE)


#......................
# import gpx file
gps_data <- st_read("data/gps_data.gpx")
# inspect layers
st_layers(gps_data)
#import gps data using the "track_points" layer
gps_data <- st_read("data/gps_data.gpx", layer = 'track_points', quiet = TRUE)
#save gpx file


#......................
library(terra)
# import tif file
raster_file <- rast("data/raster.tif") # can be from a url link too
#View object and layers
print(raster_file)
#save raster
writeRaster(raster_file, filename = "data/raster_file.tiff", overwrite = TRUE)


#......................
library(ncdf4)
# import nc file




#.....................................................
# import multiple files

library(sf)
# Set folder path where the files are located
folder_path <- "data/shapefiles"
# Load .shp, .tif etc files within a folder including all the subfolders
shp_files <- list.files(path = folder_path, pattern = "\\.shp$", recursive = TRUE, full.names = TRUE)
# Import/read all the files into a list
shp_list <- lapply(shp_files, st_read)
# Extract file names and assign names to the list
names(shp_list) <- gsub("\\.shp$", "", basename(shp_files))
# Combine shapefiles
shp_dat <- do.call(rbind, shp_list)


#.............................................
library(terra)
# Set folder path where the files are located
folder_path <- "data/rasters"
# Load .shp, .tif etc files within a folder including all the subfolders
rast_files <- list.files(path = folder_path, pattern = "\\.tif$", recursive = TRUE, full.names = TRUE)
# Import/read all the files into a list
rast_list <- lapply(rast_files, rast)
# Extract file names and assign names to the list
names(rast_list) <- gsub("\\.tif$", "", basename(rast_files))


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



