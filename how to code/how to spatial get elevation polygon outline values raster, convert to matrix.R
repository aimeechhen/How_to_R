
# how to get elevation values for a polygon outline as a raster and convert it to a matrix

# how to get the elevation for the fire boundary

library(terra)
library(tictoc)
library(ggplot2)
library(elevatr)     # for elevation, get_elev_raster()
library(raster)
library(dplyr)
library(sf)
source('scripts/source/foippa fire prep.r')


# dat_sf <-  FOIPPA
# 
# #reproject the CRS to a geographic coordinate system (e.g., WGS 84) required for get_elev_raster()
# dat_sf <- st_transform(dat_sf, crs = st_crs("epsg:4326"))
# #get bounding box
# bbox <- st_bbox(dat_sf)
# 
# #Get elevation raster for the region(s) of interest (units = meters)
# el_raster <- get_elev_raster(locations = dat_sf, 
#                              z = 9,
#                              clip = 'bbox',
#                              expand = 0.2)
# # convert into spatraster object
# el_rast <- rast(el_raster)
# 
# # set up empty list
# matrix_list <- list()
# 
# for (i in 1:nrow(dat_sf)) {
#   # extract polygon
#   fire_poly <- dat_sf[i,]
#   message("currently on fire polygon ", i, " of ", nrow(dat_sf))
#   plot(fire_poly$geometry)
#   capture_timestamp <- dat_sf$timestamp[i]
#   
#   # get the outline of the fire polygons
#   outline <- st_boundary(fire_poly)
#   # convert the outline to vector object
#   outline_spatvector <- vect(outline)
#   # extract the elevation values of the outline
#   outline_el_value <- terra::extract(el_rast, outline_spatvector, xy=TRUE)
#   names(outline_el_value)[2] <- "el"
#   
#   #...............MATRIX.....................
#   # set up the matrix
#   x_coords <- outline_el_value$x
#   y_coords <- outline_el_value$y
#   elevation <- outline_el_value$el
#   #define the matrix grid
#   x_unique <- sort(unique(x_coords))
#   y_unique <- sort(unique(y_coords))
#   #create empty matrix grid
#   m <- matrix(NA, 
#               nrow = length(y_unique), 
#               ncol = length(x_unique),
#               dimnames = list(y_unique, x_unique))
#   #fill matrix with extracted elevation values
#   for (j in seq_along(elevation)) {
#     x_idx <- which(x_unique == x_coords[j])
#     y_idx <- which(y_unique == y_coords[j])
#     m[y_idx, x_idx] <- elevation[j]
#   }
#   
#   # store filled matrix in a list
#   matrix_list[[i]] <- mt
#   # visualise
#   image(m, main = paste(capture_timestamp))  #note the image is rotated, its a property of the image() function and how it reads matrix values
#   
# }
# 
# names(matrix_list) <- FOIPPA$timestamp
# 
# 
# save(matrix_list, file = "./data/fire/20241129_elevation_matrix_list.rda")
# load(file = "./data/fire/20241129_elevation_matrix_list.rda")
# 
# 