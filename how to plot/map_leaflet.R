

library(leaflet)

#Basemap using map tiles (OpenStreetMap tiles used by default)
#https://rstudio.github.io/leaflet/basemaps.html

library(sf)


# import data points
df <- read.csv("data.csv")

m <- leaflet(df) %>% # if you have a lot of data points this will take a while
  addTiles() %>% 
  addMarkers() %>% 
  addCircleMarkers()


# just map, no data to add, with shapefile
leaflet() %>%
  addTiles() %>%
  setView(lng = -120.17, lat = 49.05, zoom = 12) %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addPolylines(data = cathedral, color = "red",  # for outline, for fill use addPolygons()
               # dashArray = "9,9",  # dashed outline
               stroke = 1, opacity = 0.5) %>%
  addMiniMap(width = 150, height = 150)



#...................................
# save as a static plot
# ...................................
library(mapview)
webshot::install_phantomjs()
mapshot(m, file = "figures/leaflet_map.png")



#...................................
# include shapefile of bc ----
library(geodata)
bc <- gadm(country = "Canada", level = 1, path = tempdir())
bc <- bc[bc$NAME_1 == "British Columbia", ]
bc


# with bc shapefile
leaflet() %>%
  addTiles() %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  setView(lng=-120, lat=50, zoom = 12) %>% # center the map at this coordinate
  addPolygons(data = bc, color = "blue", fill = FALSE, weight = 2) # shapefile outline








#............................................................
# leaflet + gps + rasters ----
#............................................................


# Set working directory
setwd("C:/Users/achhen/Documents/GitHub/Giant_Anteater")

#import data, cleaned GPS giant anteater data
DATA_GPS <- readRDS("RDS/DATA_GPS.RDS")
DATA_TELEMETRY <- readRDS("RDS/DATA_TELEMETRY.RDS")
DATA_META <- readRDS("RDS/DATA_META.RDS")
DATA_BIO <- readRDS("RDS/DATA_BIO.RDS")

#add site location
DATA_GPS$site <- NA
DATA_GPS$site[DATA_GPS$ID %in% c("Alexander", "Anthony", "Bumpus", "Cate", "Christoffer",
                                 "Elaine", "Jackson", "Kyle", "Little_Rick", "Makao",
                                 "Puji", "Rodolfo")] <- 1
DATA_GPS$site[DATA_GPS$ID %in% c("Annie", "Beto", "Hannah", "Jane", "Larry",
                                 "Luigi", "Margaret", "Maria", "Reid", "Sheron",
                                 "Thomas")] <- 2

#subset site 1 GPS data and create a new dataframe 
GPS_site1 <- DATA_GPS[DATA_GPS$site == 1,]
GPS_site1 <- left_join(GPS_site1, DATA_BIO, by = "ID")
# Convert dataframe into an sf object
gps_sf1 <- st_as_sf(GPS_site1, coords = c("GPS.Longitude", "GPS.Latitude"), crs = 4326)


library(terra)

#https://rstudio.github.io/leaflet/raster.html
#Raster images
#import raster data
pasture <- terra::rast("map/pasture.TIF")
#range of raster for site 1 size
pasture_ext <- ext(gps_sf1)
pasture_crop <- crop(pasture, pasture_ext)

native_forest <- terra::rast("map/native_forest.TIF")
#range of raster for site 1 size
native_forest_ext <- ext(gps_sf1)
native_forest_crop <- crop(native_forest, native_forest_ext)

planted_forest <- terra::rast("map/planted_forest.TIF")
#range of raster for site 1 size
planted_forest_ext <- ext(gps_sf1)
planted_forest_crop <- crop(planted_forest, planted_forest_ext)

#............................................................
# Raster Layers Colours
#............................................................

#light -> dark
pasture_col <- colorNumeric(c("#FFFFFF", "#fec44f", "#7A5900"), 
                            values(pasture),
                            na.color = "transparent")
#pasture_col <- colorBin("YlOrBr", domain = NULL, bins = 5, na.color = "transparent")

native_forest_col <- colorNumeric(c("#FFFFFF", "#41ab5d", "#00441b"), 
                                  values(native_forest),
                                  na.color = "transparent")

planted_forest_col <- colorNumeric(c("#FFFFFF", "#fa9fb5", "#c51b8a"), 
                                   values(planted_forest),
                                   na.color = "transparent")

#............................................................
# Plot map
#............................................................

m <- leaflet()
m <- setView(m, lng=-53.73, lat=-21.14, zoom = 14)
m <- addTiles(m)
m

#Plot raster layers on base map
#pasture
m_pasture <- addRasterImage(m, pasture_crop, 
                            colors = pasture_col, 
                            opacity = 0.3)
m_pasture

#native forest on base map
m_nforest <- addRasterImage(m, native_forest_crop, 
                            colors = native_forest_col, 
                            opacity = 0.3)
m_nforest

#planted forest on base map
m_pforest <- addRasterImage(m, planted_forest_crop, 
                            colors = planted_forest_col, 
                            opacity = 0.3)
m_pforest

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#plot multiple raster layers on basemap
m <- leaflet()
m <- setView(m, lng=-53.73, lat=-21.14, zoom = 14)
m <- addTiles(m)
m

#add 1st raster layer, pasture
m <- addRasterImage(m, pasture_crop, 
                    colors = pasture_col, 
                    opacity = 0.3)
m

#add 2nd raster layer, native forest
m <- addRasterImage(m, native_forest_crop, 
                    colors = native_forest_col, 
                    opacity = 0.3)
m

#add 3rd raster layer, planted forest
m <- addRasterImage(m, planted_forest_crop, 
                    colors = planted_forest_col, 
                    opacity = 0.3)
m

#add legends
m <- addLegend(m, pal = pasture_col, values = values(pasture),
               title = "Pasture")
m <- addLegend(m, pal = native_forest_col, values = values(native_forest),
               title = "Native Forest")
m <- addLegend(m, pal = planted_forest_col, values = values(planted_forest),
               title = "Planted Forest")
m


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#piping method to see if there is a difference

#plot multiple raster layers on basemap
m <- leaflet() %>%
  #Set the view of the map (center and zoom level)
  setView(lng=-53.73, lat=-21.14, zoom = 14) %>%
  # Add default OpenStreetMap map tiles
  addTiles() %>%
  #add 1st raster layer, pasture
  addRasterImage(pasture_crop, 
                 colors = pasture_col, 
                 opacity = 0.3) %>%
  addLegend(pal = pasture_col, values = values(pasture),
            title = "Pasture") %>%
  #add 2nd raster layer, native forest
  addRasterImage(native_forest_crop, 
                 colors = native_forest_col, 
                 opacity = 0.3) %>%
  addLegend(pal = native_forest_col, values = values(native_forest),
            title = "Native Forest") %>%
  #add 3rd raster layer, planted forest
  addRasterImage(planted_forest_crop, 
                 colors = planted_forest_col, 
                 opacity = 0.3) %>%
  addLegend(pal = planted_forest_col, values = values(planted_forest),
            title = "Planted Forest") %>%
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  #gps tracking data for site 1
  plot_site1 <- 
  ggplot() +
  geom_sf(data = gps_sf1, aes(color = Sex),
          size = 1) +
  scale_color_manual(values = c('#004488', '#A50026'), breaks = c('Male', 'Female')) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  coord_sf(xlim = c(-53.67, -53.8), #lat
           ylim = c(-21.2, -21.08)) #long

library(grid)

# Convert ggplot2 plot to a raster image
site1_raster <- ggplotGrob(plot_site1)

#add ggplot to leaflet basemap
m %>%   #add ggplot to leaflet basemap
  ggplot() +
  geom_sf(data = gps_sf1, aes(color = Sex),
          size = 1) +
  scale_color_manual(values = c('#004488', '#A50026'), breaks = c('Male', 'Female')) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  coord_sf(xlim = c(-53.67, -53.8), #lat
           ylim = c(-21.2, -21.08)) #long




