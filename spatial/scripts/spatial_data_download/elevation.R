
# elevation data

#Data download: elevation data

library(dplyr)        # for data wrangling
library(elevatr)      # to download digital elevation models
library(purrr)        # for functional programming (map_***(), etc.)
library(sp)           # for spatial data, SpatialPoints()
library(sf)           # for spatial data
library(terra)        # for raster data
library(progress)     # for elevation, get_elev_raster()

#import collar data
#data_gps <- read.csv("data/goat-data.csv")
data_gps <- readRDS("data/rds/data_gps_uncleaned.rds")

#subset the coordinates
gps_coordinates <- data_gps[,6:7]

# #convert coordinates to spatial data points
# gps_location <- SpatialPoints(select(gps_coordinates, location.long, location.lat))
# 
# #convert projection into a geographic coordinate system
# ctmm::projection(gps_location) <- '+proj=longlat' 

#rename columns to access elevation data (x = long; y = lat)
colnames(gps_coordinates)[1] <- "x"
colnames(gps_coordinates)[2] <- "y"

#extracting point elevations from the AWS Terrain Tiles
#using EPSG:4326 instead of EPSG:3005 because some points looks like they are located outside of Canada
#EPSG:4326 = global coordinate system
#EPSG:3005 = projected coordinate system specific to Canada (NAD83(CSRS) / UTM zone 5 (in meters))
elevation_point <- get_elev_point(gps_coordinates, prj = 4326, src = "aws")

saveRDS(elevation_point, file = "rds/elevation_point.rds")





#........................................................

library(elevatr)

#import data containing latitude and longitude
load("data/goat/goat_data_v2.rda")

#create a dataframe of long and lat
goat_data_coord <- goat_data[,c("location.long", "location.lat")]

# Convert the dataframe to an sf object and set crs to lat/long
goat_data_sf <- st_as_sf(goat_data_coord, coords = c("location.long", "location.lat"), crs = 4326)

#import a Digital Elevation Model (DEM) for the region(s) of interest
dem <- get_elev_raster(locations = goat_data_sf,
                       z = 3,
                       clip = 'bbox',
                       expand = 0.1)