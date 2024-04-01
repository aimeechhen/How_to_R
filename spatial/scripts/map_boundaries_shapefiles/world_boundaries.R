
# World shapefile boundaries





#........................................................................
# Base R (world+canada+bc) ----
#........................................................................


library(rworldmap)
library(terra)
library(sf)
library(geodata)

canada <- gadm(country="Canada", level=0, path = tempdir())
provinces <- gadm(country="Canada", level=1, path = tempdir())



#define the projection system
crs_wintri <- "ESRI:53018"  

#Get world boundaries for clipping (not critical, but makes maps nicer looking)
world_sf <- st_as_sf(rworldmap::getMap(resolution = "low"))

#Drop antarctica
world_sf <- subset(world_sf, continent != "Antarctica")

#Reproject
world_wintri <- lwgeom::st_transform_proj(world_sf, crs = crs_wintri)
canada_wintri <- project(canada, crs_wintri)
provinces_wintri <- project(provinces, crs_wintri)

# Convert to spatvector class
world_wintri <- vect(world_wintri) 


png(file="Figures/world_bc_map.png",
    width=6.86, height=3, units="in", res=600)
#World baselayer
plot(world_wintri, border = "darkgrey", col = "lightgrey", axes = FALSE)
#add canada layer
plot(canada_wintri, col="white", lwd = 0.5, add = TRUE)
#add BC layer
plot(provinces_wintri[provinces_wintri$NAME_1 %in% "British Columbia", ], border="black", lwd = 0.5,
     col="#de2d26", add=TRUE)
dev.off()


png(file="Figures/world_bc_map_provinces.png",
    width=6.86, height=3, units="in", res=600)
#World baselayer
plot(world_wintri, border = "darkgrey", col = "lightgrey", axes = FALSE)
#add Canada layer with provinces
plot(provinces_wintri, col="white", lwd = 0.5, add = TRUE)
#add BC layer
plot(provinces_wintri[provinces_wintri$NAME_1 %in% "British Columbia", ], border="black", lwd = 0.5,
     col="#de2d26", add=TRUE)
dev.off()



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

