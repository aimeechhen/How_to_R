

# How to import, inspect, convert, save spatial data

# from a dataframe object
# import your data and convert into an sf object
load("data/data.rda")
df <- read.csv("data/data.csv")
# convert df into sf object
df_sf <- st_as_sf(df, coords = c('longitude', 'latitude'))
# set crs as lat/long system
st_crs(df_sf) <- 4326






# single spatial object (raster or shape file)

# shapefile ----
library(sf)
# import shapefile
shp_file <- st_read("data/shapefile.shp")
# inspect layers
st_layers(shp_file)
# inspect data
View(shp_file)

# save shapefile
st_write(shp_file, dsn = 'data/shapefile', 
         driver = 'ESRI Shapefile', append=FALSE)


#...............................................
# gpx file ----
#...............................................

# import gpx file
gps_data <- st_read("data/gps_data.gpx")
# inspect layers
st_layers("data/gps_data.gpx")
st_layers(gps_data)
#import gps data using the "track_points" layer
gps_data <- st_read("data/gps_data.gpx", layer = 'track_points', quiet = TRUE)
#save gpx file

#Multiple gpx files
# Set the folder path
dir_path <- "./data/collar_data/raw_collar/"
# Load .shp, .tif etc files within a folder including all the subfolders
gpx_files <- list.files(dir_path, pattern = "\\.gpx$", full.names = TRUE)
# Import/read all the files into a list, specifying the layer
gpx_list <- lapply(gpx_files, function(file) st_read(file, layer = "track_points"))
# combine together as one list
gpx_data <- do.call(c, gpx_list)



#...............................................
# tif file ----
#...............................................
library(terra)

# import tif file
raster_file <- rast("data/raster.tif") # can be from a url link too
#View object and layers
print(raster_file)
#save raster
writeRaster(raster_file, filename = "data/raster_file.tiff", format = "GTiff", overwrite = TRUE)




#...............................................
# nc file ----
#...............................................
library(ncdf4)

# import nc file
nc_file <- nc_open("ndvi.nc")
#check the available variables
names(nc_file$var)
# extract layer/variable
mask <- ncvar_get(nc_file, "Mask")


#import nc file as raster or spatraster
nc_file <- raster("data/ndvi.nc", varname = "NDVI")
# or spatraster
nc_file <- rast(nc_file)







#______________________________________________________________________________________
# import multiple spatial files ----

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

