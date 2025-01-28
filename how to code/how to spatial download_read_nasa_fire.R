
# nasa fire data
#https://firms.modaps.eosdis.nasa.gov/map/#d:2023-08-14;@-119.5,49.3,8.3z

#downloaded 2024-02-12
#clicked on 3 horizontal line to open main menu
#selected DOWNLOADS
#redirected me here https://firms.modaps.eosdis.nasa.gov/download/#t:tsd;d:2023-08-14;@-119.5,49.3,8.3z
#clicked on Create New Request
#Filled out request information
#selected region: World
#selected 2,3,4 fire sources options
# 1. (US ONLY) LANDSAT 30m: Temporal Coverage: 20 June 2022 - present
# 2. MODIS Collection 6.1: Temporal Coverage: 11 November 2000 - present
# 3. VIIRS S-NPP 375m: Temporal Coverage: 20 January 2012 - present
#from S-NPP = Suomi National Polar-orbiting Partnership
# 4. VIIRS NOAA-20 375m: Temporal Coverage: 1 January 2020 - present
#from NOAA Joint Polar Satellite System (JPSS-1) satellite
# 5. (2024+ DATES ONLY) VIIRS NOAA-21 375m: Temporal Coverage: 17 January 2024 - present

#dates: Jan 1 to Dec 31, 2023
#output: .cpg, dbf, .prj, .shp, .shx
#submit request
#downloaded files via email link from nasa


library(sf)
library(stringr)
library(ggplot2)

# Import NASA MODIS fire data
modis_nrt <- st_read("spatial/data/nasa_fire/DL_FIRE_M-C61_425295/fire_nrt_M-C61_425295.shp")
#inspect layers in the shapefile
st_layers("spatial/data/nasa_fire/DL_FIRE_M-C61_425295/fire_nrt_M-C61_425295.shp")

viirs_suomi <- st_read("spatial/data/nasa_fire/DL_FIRE_SV-C2_425297/fire_nrt_SV-C2_425297.shp")
str(viirs_suomi)
st_layers("spatial/data/nasa_fire/DL_FIRE_M-C61_425295/fire_nrt_M-C61_425295.shp")

viirs_noaa <- st_read("spatial/data/nasa_fire/DL_FIRE_J1V-C2_425296/fire_nrt_J1V-C2_425296.shp")
st_layers("spatial/data/nasa_fire/DL_FIRE_J1V-C2_425296/fire_nrt_J1V-C2_425296.shp")

#.........................................................

# Import Provincial park polygons
bc_parks <- st_read("spatial/data/shapefiles/bc_provincial_parks/TA_PARK_ECORES_PA_SVW/TA_PEP_SVW_polygon.shp")
bc_parks <- st_transform(bc_parks, crs = st_crs(modis_nrt))

#subset to cathedral park
cathedral <- bc_parks[bc_parks$PROT_NAME == "CATHEDRAL PARK", ] #row 95
# Convert crs from BC Albers to WGS84 Geographic projection (i.e. "latitude/longitude projection")
cathedral <- st_transform(cathedral, "+proj=longlat +datum=WGS84")

#.........................................................

# Crop global fire data to cathedral park area
modis_nrt_crop <- st_crop(modis_nrt, cathedral)
# fire_modis_archive_crop <- st_crop(fire_modis_archive, cathedral) #no obs.
# Warning message: attribute variables are assumed to be spatially constant throughout all geometries

viirs_suomi_crop <- st_crop(viirs_suomi, cathedral)
viirs_noaa_crop <- st_crop(viirs_noaa, cathedral)


#.........................................................

# Save shapefile
#change the directory back working project
st_write(modis_nrt_crop, dsn = "spatial/data/nasa_fire/cathedral/modis_nrt",
         driver = 'ESRI Shapefile', append=FALSE)
st_write(viirs_suomi_crop, dsn = "spatial/data/nasa_fire/cathedral/viirs_suomi/",
         driver = 'ESRI Shapefile', append=FALSE)
st_write(viirs_noaa_crop, dsn = "spatial/data/nasa_fire/cathedral/viirs_noaa/",
         driver = 'ESRI Shapefile', append=FALSE)

modis_nrt <- st_read("spatial/data/nasa_fire/cathedral/modis_nrt/modis_nrt.shp")
viirs_suomi <- st_read("spatial/data/nasa_fire/cathedral/viirs_suomi/viirs_suomi.shp")
viirs_noaa <- st_read("spatial/data/nasa_fire/cathedral/viirs_noaa/viirs_noaa.shp")


#.........................................................
modis_nrt <- st_read("spatial/data/nasa_fire/cathedral/modis_nrt/modis_nrt.shp")
viirs_suomi <- st_read("spatial/data/nasa_fire/cathedral/viirs_suomi/viirs_suomi.shp")
viirs_noaa <- st_read("spatial/data/nasa_fire/cathedral/viirs_noaa/viirs_noaa.shp")

