
# BC maps

# creating a map, shapefiles
library(canadianmaps) # to download a shapefile of BC
library(sp)           # for spatial data, SpatialPoints()
library(sf)           # for spatial data
library(terra)        # for raster data
library(dplyr)        # for data wrangling

bc_shape <- st_as_sf(PROV) %>%  # convert to spatial features (sf) object
  filter(PRENAME == 'British Columbia') %>% # filter to BC only
  st_geometry() # extract boundaries only

plot(bc_shape)

# file path to save downloaded spatial file in
spatial_filepath <- 'data/bc.shp'

# save downloaded spatial file locally
st_write(bc_shape, 'data/bc.shp')

bc <- st_read("data/bc.shp")


#............................................................

library(canadianmaps) # to download a shapefile of BC

# Convert to spatial features (sf) object
bc_shape <- st_as_sf(PROV)
#select province
bc_shape <- subset(PROV, PRENAME == 'British Columbia')
# Extract boundaries only
bc_shape <- st_geometry(bc_shape)
plot(bc_shape)
#convert to spatial format
bc_shape_sf <- as(bc_shape, "Spatial")
plot(bc_shape_sf)
#extent of bc
ext(bc_shape_sf)
#set the extent values
bc_ext <- ext(bc_shape_sf)


library(geodata)
bc <- gadm(country = "Canada", level = 1, path = tempdir())
bc <- bc[bc$NAME_1 == "British Columbia", ]