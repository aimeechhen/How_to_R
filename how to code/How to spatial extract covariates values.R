
# Extract location raster values based on location (coordinates) of collar tracking data

library(sf)
library(raster)
library(terra)
library(ggplot2)
library(tidyterra) # to plot spatrasters

# Note: to extract, location (coordinates) data needs to be in point format, ie. spatvector or you will get this error
#Error in (function (classes, fdef, mtable)  : unable to find an inherited method for function ‘extract’ for signature ‘"SpatRaster", "SpatRaster"’

# Spatial carpentry

rm(list = ls())

# Import collar data
dat = read.csv('./data/input_data/20240703_moving_window_formatted_for_tele_dat.csv')

#convert coordinate locations into sf object
dat.sf <- st_as_sf(dat, coords = c('location.long', 'location.lat'))

# set crs as lat/long
st_crs(dat.sf)
st_crs(dat.sf) <- 4326
# st_crs(dat.sf) <- 3005

#convert sf into spatvector object to be able to extract values
locations <- vect(dat.sf)
crs(locations)
locations

#______________________________________
# Using ctmm telemetry object

dat = read.csv('./data/input_data/20240703_moving_window_formatted_for_tele_dat.csv')

dat$timestamp = as.POSIXct(dat$timestamp, format = "%Y-%m-%d %H:%M:%S")
# period = 'all_data'
# tel.dat <- dat
dat = dat[dat$year == "2022",]
# tel.dat <- tel.dat[tel.dat$month_day >= '07-01' & tel.dat$month_day <= '07-31', ]

tel.data = as.telemetry(dat, timeformat = '%Y-%m-%d %H:%M:%S', timezone = 'UTC')
# collars = dat %>% distinct(individual.local.identifier)

# tel.data <- tel.data[1:2]

tel.data <- tel.data[[1]]
SUBSET <- tel.data
SUBSET.SF <- as.sf(SUBSET)
locations <- vect(SUBSET.SF)


#...............................................................
# Covariates

# if you get an issue when trying to set crs via spatraster. The extent doesnt match or the system doesnt get converted -> Fix: import as raster then convert to spatraster. then you can extract values




#................................................................
## Elevation ----

elevation <- raster('./data/rasters/elev_25m.tif')

# Inspect raster properties and do some spatial carpentry
plot(elevation)
# Check crs
crs(elevation)
# reproject into lat/long crs
elevation <- projectRaster(elevation, crs = "EPSG:4326")
#check extent
extent(elevation)

# convert raster into spatraster object
el <- rast(elevation)
#check raster properties
crs(el)
ext(el)
el

# Compare location and raster properties
#check if crs matches
same.crs(locations, el)
#check if extent matches
ext(locations)
ext(el)

# Extract habitat values for each point
# dat$el_values <- extract(el, locations)[,2]
el_values <- extract(el, locations)[,2]

# extract mean habitat values for each moving window segment
mean_el <- mean(extract(el, locations)[,2])

#................................................................
## Distance to escape ----

dist_escape <- raster('./data/rasters/dist_escape_25m.tif')

# Inspect raster properties and do some spatial carpentry
plot(dist_escape)
# Check crs
crs(dist_escape)
# reproject into lat/long crs
dist_escape <- projectRaster(dist_escape, crs = "EPSG:4326")
#check extent
extent(dist_escape)

# convert raster into spatraster object
esc <- rast(dist_escape)
#check raster properties
crs(esc)
ext(esc)
esc

# Compare location and raster properties
#check if crs matches
same.crs(locations, esc)
#check if extent matches
ext(locations)
ext(esc)

# Extract habitat values for each point
dist_escape_values <- extract(esc, locations)[,2]

# extract mean habitat values for each moving window segment
mean_dist_escape <- mean(extract(esc, locations)[,2])


#...............................................................
slope <- raster('./data/rasters/slope_25m.tif')

# Inspect raster properties and do some spatial carpentry
plot(slope)
# Check crs
crs(slope)
# reproject into lat/long crs
slope <- projectRaster(slope, crs = "EPSG:4326")
#check extent
extent(slope)

# convert raster into spatraster object
slp <- rast(slope)
#check raster properties
crs(slp)
ext(slp)
slp

# Compare location and raster properties
#check if crs matches
same.crs(locations, slp)
#check if extent matches
ext(locations)
ext(slp)

# Extract habitat values for each point
slope_values <- extract(slp, locations)[,2]

# extract mean habitat values for each moving window segment
mean_slope <- mean(extract(slp, locations)[,2])


load('./data/input_data/moving_window/TEST.rda')
RESULTS <- do.call(rbind, lapply(RES, as.data.frame))



#...............................................................
# Plot ----
#...............................................................

# Import Provincial park polygons
bc_parks <- st_read("data/rasters/bc_provincial_parks/TA_PARK_ECORES_PA_SVW/TA_PEP_SVW_polygon.shp")
# Convert CRS to lat/long projection
bc_parks <- st_transform(bc_parks, crs = st_crs(4326))
st_crs(bc_parks)
#subset to cathedral park
cathedral <- bc_parks[bc_parks$PROT_NAME == "CATHEDRAL PARK", ] #row 95


#plot
ggplot() +
  geom_spatraster(data = el) +
  geom_sf(data = cathedral, fill = NA, color = "white") +
  geom_point(data = dat,
             aes(x = location.long, y = location.lat), color = "purple") +
  labs(fill = "Elevation (m)") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), #removes horizontal gridlines
        panel.grid.minor = element_blank()) + #removes vertical gridlines
        coord_sf(crs = 4326)
        


#plot
ggplot() +
  geom_spatraster(data = dist_esc) +
  geom_sf(data = cathedral, fill = NA, color = "white") +
  geom_point(data = dat,
             aes(x = location.long, y = location.lat), color = "purple") +
  labs(fill = "Distance to escape terrain (m)") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), #removes horizontal gridlines
        panel.grid.minor = element_blank()) + #removes vertical gridlines
  coord_sf(crs = 4326)
