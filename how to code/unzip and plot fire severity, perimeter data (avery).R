
# load packages
library(sf)

# check to see if you are in the right place
getwd()

#________________________
# Severity ----

# location of zipped folder
zipfile <- "Data/Fire Severity/BCGW_7113060B_1728589520219_724.zip"

# create a new folder for where the files will be unzipped to
dir.create("Data/Fire Severity/fire_severity_data_bc")

# set folder path
unzip_folder <- "Data/Fire Severity/fire_severity_data_bc"

#unzip the zipped folder
fire_severity_data_bc <- unzip(zipfile, exdir = unzip_folder)

# inspect folder where the extracted files are
fire_severity_data_bc

# check the layers in the shapefile
st_layers("Data/Fire Severity/fire_severity_data_bc/VEG_BURN_SEVERITY_SP/BURN_SVRTY_polygon.shp")

# import extracted shapefile
severity_shp <- st_read("Data/Fire Severity/fire_severity_data_bc/VEG_BURN_SEVERITY_SP/BURN_SVRTY_polygon.shp")

# inspect data
View(severity_shp)

# subset a single fire
fire <- severity_shp[63,]

# plot shapefile to inspect
plot(fire$geometry)

#...............................................
# bc shapefile ----

library(geodata)
# extract canada shapefile
can <- gadm(country = "Canada", level = 1, path = tempdir())
# subset to bc only
bc <- can[can$NAME_1 == "British Columbia", ]
plot(bc)

# check crs
st_crs(bc)
st_crs(fire)

# convert spatvector to sf object
bc_sf <- st_as_sf(bc)

# they dont match, need to reproject to match. matching bc shape to wildfire
bc <- st_transform(bc_sf, crs = st_crs(fire))

#check crs
st_crs(bc)
st_crs(fire)

#........................................................
# plot severity ----
library(ggplot2)

# plot bc and single fire shapefile
ggplot() +
  geom_sf(data = bc$geometry) +
  geom_sf(data = fire$geometry, color = "red")


# look at all fires of 2019, subset to year 2019
fire_2019 <- severity_shp[severity_shp$FIRE_YEAR == "2019",]

ggplot() +
  geom_sf(data = bc$geometry) +
  geom_sf(data = fire_2019$geometry, color = "red")

# subset different years
fire_2017 <- severity_shp[severity_shp$FIRE_YEAR == "2017",]
fire_2018 <- severity_shp[severity_shp$FIRE_YEAR == "2018",]

# plot bc shapefile and multiple years
ggplot() +
  geom_sf(data = bc$geometry) +
  geom_sf(data = fire_2017$geometry, color = "blue") +
  geom_sf(data = fire_2018$geometry, color = "green") +
  geom_sf(data = fire_2019$geometry, color = "magenta")






#______________________________________________________________
# Perimeters ----

# load packages
library(sf)

# check to see if you are in the right place
getwd()

# location of zipped folder
zipfile <- "Data/Fire perimeters/XXXXXXXXXXXX.zip"

# create a new folder for where the files will be unzipped to
dir.create("Data/Fire perimeters/fire_perimeters_data_bc")

# set folder path
unzip_folder <- "Data/Fire perimeters/fire_perimeter_data_bc"

#unzip the zipped folder
fire_perimeters_data_bc <- unzip(zipfile, exdir = unzip_folder)

# inspect folder where the extracted files are
fire_perimeters_data_bc

# check the layers in the shapefile
st_layers("")

# import extracted shapefile
perimeters_shp <- st_read("")

# inspect data
View(perimeters_shp)

# subset a single fire
fire <- perimeters_shp[63,]

# plot shapefile to inspect
plot(fire$geometry)

#.................................................
#bc shapefile ----
library(geodata)
# extract canada shapefile
can <- gadm(country = "Canada", level = 1, path = tempdir())
# subset to bc only
bc <- can[can$NAME_1 == "British Columbia", ]
plot(bc)

# check crs
st_crs(bc)
st_crs(fire)

# convert spatvector to sf object
bc_sf <- st_as_sf(bc)

# they dont match, need to reproject to match. matching bc shape to wildfire
bc <- st_transform(bc_sf, crs = st_crs(fire))

#check crs
st_crs(bc)
st_crs(fire)

#.........................................
# plot perimeters ----
library(ggplot2)

# plot bc and single fire shapefile
ggplot() +
  geom_sf(data = bc$geometry) +
  geom_sf(data = fire$geometry, color = "red")


# look at all fires of 2019, subset to year 2019
fire_2019 <- perimeters_shp[perimeters_shp$FIRE_YEAR == "2019",]

ggplot() +
  geom_sf(data = bc$geometry) +
  geom_sf(data = fire_2019$geometry, color = "red")

# subset different years
fire_2017 <- perimeters_shp[perimeters_shp$FIRE_YEAR == "2017",]
fire_2018 <- perimeters_shp[perimeters_shp$FIRE_YEAR == "2018",]

# plot bc shapefile and multiple years
ggplot() +
  geom_sf(data = bc$geometry) +
  geom_sf(data = fire_2017$geometry, color = "blue") +
  geom_sf(data = fire_2018$geometry, color = "green") +
  geom_sf(data = fire_2019$geometry, color = "magenta")



                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   #+ color = c("yellow", "red", "orange", "green")
                   scale_color_manual(values = c("yellow", "orange", "red", "green"),
                                      labels = c("Low", "Medium", "High", "Unburned")
                                      
                                      
                                      