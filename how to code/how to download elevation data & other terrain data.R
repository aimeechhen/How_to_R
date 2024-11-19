# how to get elevation data & other terrain data

library(dplyr)        # for data wrangling
library(purrr)        # for functional programming (map_***(), etc.)
library(sp)           # for spatial data, SpatialPoints()
library(sf)           # for spatial data
library(terra)        # for raster data
library(progress)     # for elevation, get_elev_raster()
library(raster)




library(geodata) # https://github.com/rspatial/geodata
# Download elevation raster (3s = 90m; 30s = 1km, global = specify)
elev_ca <- elevation_30s(country="CAN", path=tempdir() )
elev_us <- elevation_30s(country="USA", path=tempdir() )
elev <- merge(elev_us, elev_ca)

writeRaster(elev, filename = "data/habitat/elev.tif", overwrite = TRUE)
elev <- rast("data/habitat/elev.tif")




library(elevatr)      # to download digital elevation models https://rspatialdata.github.io/elevation.html
#import gps data
gps <- read.csv("data/gps.csv")
#Convert gps coordinates to sf object, spatial data points
coord_sf <- st_as_sf(gps, coords = c("longitude", "latitude"))
#Retrieve coordinate reference system (CRS) and set the CRS to a geographic coordinate system (e.g., WGS 84)
st_crs(coord_sf) <- st_crs("+proj=longlat +datum=WGS84")
#Get the bounding box of the goat data
bbox <- st_bbox(coord_sf)


#Get elevation raster for the region(s) of interest (units = meters)
# zoom level 1:14, 14 fine scale -> z = 9-12 ~90m resolution; z = 13-14 ~10-30m resolution
dem_raster <- get_elev_raster(locations = coord_sf, 
                              z = 9,
                              clip = 'bbox',
                              expand = 0.2)
plot(dem_raster)



# write the csv
#Extract the Digital Elevation Model (DEM) data from the raster
dem_data <- mutate(gps,
                   el = terra::extract(dem_raster, coord_sf),
                   ID1 = 1:n(),
                   ID2 = ID1) %>%
  relocate(ID1:ID2)


#plot coordinates for visual
ggplot(dem_data, aes(longitude, latitude,el)) +
  geom_tile()

write.csv(coords, file = 'data/habitat/dem_data.csv', row.names = FALSE) 







#............................................................
# Terrain variables ----
#............................................................

library(terra)

#Data download: terrain data (slope, aspect, roughness)
#"roughness": Calculates the roughness of the terrain.
#"tpi": Computes the topographic position index (TPI).
#"tri": Calculates the terrain ruggedness index (TRI).
#"flowdir": Computes the flow direction.

#Calculate slope of the terrain (in degrees)
slope <- terrain(dem_raster, opt = "slope", unit = "degrees")

# Calculate aspect, the direction that the slope faces (in degrees)
aspect_raster <- terrain(dem_raster, opt = "aspect", unit = "degrees")

# Calculate roughness
roughness_raster <- terrain(dem_raster, opt = "roughness")

# Calculate topographic position index (TPI)
tpi_raster <- terrain(dem_raster, opt = "tpi")

# Calculate terrain ruggedness index (TRI)
tri_raster <- terrain(dem_raster, opt = "tri")

# Calculate flow direction
flowdir_raster <- terrain(dem_raster, opt = "flowdir")






## Calculate hillshade (based on https://gist.github.com/Pakillo/c0bd8f6e96e87625e715d3870522653f?permalink_comment_id=3995139)
slope_raster <- terrain(elev, "slope", unit = "radians")
aspect_raster <- terrain(elev, "aspect", unit = "radians")
hs <- shade(slope_raster, aspect_raster)

## Plot hillshading as basemap
# (here using terra::plot, but could use tmap)
plot(hs, col = gray(0:100 / 100), legend = FALSE, axes = FALSE,
     xlim = c(-5.50, -5.30), ylim = c(36.69, 36.82))
# overlay with elevation
plot(elev, col = terrain.colors(25), alpha = 0.5, legend = FALSE,
     axes = FALSE, add = TRUE)
# add contour lines
contour(elev, col = "grey40", add = TRUE)