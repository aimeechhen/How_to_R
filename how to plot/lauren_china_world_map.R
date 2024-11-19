


#.......................................................
# Lauren's China ----
#......................................................

library(terra)
library(sf)
library(geodata)
china <- gadm(country= "China", level=0, path = tempdir())
#define the projection system
crs_wintri <- "ESRI:53018" 
#Reproject
china <- project(china, crs_wintri)
#plot
plot(china)



#.......................................................
# ggplot: Lauren's Map (World) ----
#......................................................

library(sf)
library(ggplot2)
library(geodata)

#res = 1 and 5 indicating the level of detail. 1 is high 5 is low
world <- world(resolution=5, level=0, path = tempdir(), version="latest")

# Convert to sf object
world_sf <- st_as_sf(world)

#define the projection system
crs_wintri <- "ESRI:53018" 

# Convert CRS to lat/long projection
world_sf <- st_transform(world_sf, crs = crs_wintri)
st_crs(world_sf)

#import my data
mp_coord <- read.csv("C:/Users/Pokedex/Downloads/global_coords.csv")

ggplot() + 
  geom_sf(data = world_sf, fill = NA, color = "darkgrey", size = 1) +
  geom_point(data = mp_coord, aes(x = long, y = lat), color = "black")

