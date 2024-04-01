

# Grace's map

#plot ndvi for us/ca with national park locations

library(terra)
library(sf)
library(geodata)
library(ggplot2)
library(tidyterra)


#.........................................................
# get us/ca map

#level 0 = country; level 1 = province/state; level 2 = counties
provinces <- gadm(country="Canada", level=1, path = tempdir())
states <- gadm(country="USA", level=1, path = tempdir())
map <- rbind(provinces, states)

#............................

#Import ndvi raster to be used as background
ndvi <- rast("spatial/data/noaa_ndvi/2022/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20220101_c20220419212429.nc")

#extract the ndvi layer from the raster
ndvi <- ndvi$NDVI


#........................................................

#match crs
crs(map) <- "EPSG:4326"
crs(ndvi) <- "EPSG:4326"

#........................................................

# Convert the shapefile to a raster mask
mask <- rasterize(map, ndvi)

# Apply the mask to the NDVI raster
ndvi_masked <- mask(ndvi, mask)

# Check the masked NDVI layer
ndvi_masked

#crop ndvi to map
ndvi_crop <- crop(ndvi_masked, map)

#find the extent of the raster
ext(map)

#set the bounding box
bbox <- ext(c(-179.150558, -52.618888855, 20, 83.1104200000001))

#crop the map
map_crop <- crop(map, bbox)

plot(map_crop)

#crop the ndvi
ndvi_na <- crop(ndvi_crop, bbox)

plot(ndvi_na)


#.............................................................

#Import national park coordinates
new_park_coordinates <- read.csv("spatial/data/grace_nat_park_coordinates.csv")


#.............................................................
# Check plotting layers one at a time ----

# ndvi layer
ggplot() +
  geom_spatraster(data = ndvi_na)

# map borders
ggplot() +
  geom_sf(data = map_crop) 

# park locations
ggplot()+
  geom_point(data = new_park_coordinates, aes(x = longitude, y = latitude), shape = 17, size = 3, alpha = 0.8)


#.......................................................
# ggplot: all layers ----
#......................................................

ggplot() +
  # ndvi layer
  geom_spatraster(data = ndvi_na) +
  # set the color gradient for ndvi
  scale_colour_viridis_c() +
  # add map shapefile that includes provinces and states borders
  geom_sf(data = map_crop, fill = "transparent", color = "black", size = 1) + 
  # add national park locations
  geom_point(data = new_park_coordinates, aes(x = longitude, y = latitude), 
             shape = 17, size = 3, alpha = 0.8)


#use for manual colouring and fill "" with the colour your want
scale_fill_gradient(low = "brown", high = "green") 