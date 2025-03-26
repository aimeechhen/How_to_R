


# bc government data catalogue ----
# https://catalogue.data.gov.bc.ca/datasets/

# Manual download
#BC Geographic Warehouse Custom Download
#Select 'Access/Download'
#Enter order details:
#Coordinate System = BC Albers (m)
#Format = ArcView Shape (if you want .shp file, CSV doesn't give you want you want, i.e. geometries, coordinates etc.)
#Area of Interest = None
#Submit and then download via link that is sent to your email address
#Extract zip file to get .shp file

# click on "Download KML Ground Overlay file" to get object name, and inspect data details



library(bcdata)
# https://catalogue.data.gov.bc.ca/

# extract information on the data
bcdc_query_geodata("x") # insert object name from data catalogue
bcdc_query_geodata("WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_INCIDENTS_SP")

# download the data
bc_data <- bcdc_query_geodata("x") %>% 
  collect()

bcdc_get_citation("url")


#.................................................
# biogeoclimatic zones polygons
#.................................................
# https://www.for.gov.bc.ca/hre/becweb/resources/maps/ProvinceWideMaps.html

bec <- bcdc_query_geodata("WHSE_FOREST_VEGETATION.BEC_BIOGEOCLIMATIC_POLY") %>% 
  collect()
plot(bec)

# https://catalogue.data.gov.bc.ca/dataset/bec-map/resource/46ceb84a-3f6d-436c-b4c1-c89beb72d11a






# bc fire ----
# https://catalogue.data.gov.bc.ca/dataset/bc-wildfire-fire-perimeters-current
# https://catalogue.data.gov.bc.ca/dataset/bc-wildfire-fire-perimeters-historical
# map of bc wildfire services and regional boundaries
# https://www.for.gov.bc.ca/ftp/HPR/external/!publish/Maps_and_Data/Maps/Organizational_Overview/

# historical fires
WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_INCIDENTS_SP <- bcdc_query_geodata("WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_INCIDENTS_SP") %>% # search for data
  filter(FIRE_NUMBER == "K52125") %>% # filter based on fire id number
  collect() # download data

bcdc_get_citation("https://catalogue.data.gov.bc.ca/dataset/bc-wildfire-fire-incident-locations-historical/resource/6db589c4-e45e-4ae9-a7b5-775cbfec6037")


#...........................................................
# perimeter area (polygons of the fire) ----

#polygon
WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_FIRE_POLYS_SP <- bcdc_query_geodata("WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_FIRE_POLYS_SP") %>% 
  # filter(FIRE_NUMBER == "K52125") %>% 
  filter(FIRE_YEAR == "2023") %>% 
  collect()


plot(WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_FIRE_POLYS_SP$geometry)

WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_FIRE_POLYS_SP <- st_transform(WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_FIRE_POLYS_SP, crs = "epsg:4326" )

bcdc_get_citation("https://catalogue.data.gov.bc.ca/dataset/bc-wildfire-fire-perimeters-historical/resource/c899578d-0738-4166-9b65-0588464f42ee")
# or ID "22c7cb44-1463-48f7-8e47-88857f207702"







#...........................................................
# Severity ----

# historical
WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SP <- bcdc_query_geodata("WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SP") %>%
  # filter(FIRE_NUMBER == "K52125") %>%
  # filter(FIRE_YEAR == "2023") %>% 
  collect()



# # historical are only for 2018-2021, need to refer to current/same year data for more recent
test <- WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SP[WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SP$FIRE_NUMBER == "K52125",]
test <- WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SP[WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SP$FIRE_YEAR == "2023",]

# https://catalogue.data.gov.bc.ca/dataset/fire-burn-severity-historical
bcdc_get_citation("https://catalogue.data.gov.bc.ca/dataset/fire-burn-severity-historical/resource/714536b6-9957-42ca-8c3a-a3f853d807e6")

# same year
WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SAME_YR_SP <- bcdc_query_geodata("WHSE_FOREST_VEGETATION.VEG_BURN_SEVERITY_SAME_YR_SP") %>% 
  # filter(FIRE_NUMBER == "K52125") %>% 
  # filter(FIRE_YEAR == "2023") %>% 
  collect()

bcdc_get_citation("https://catalogue.data.gov.bc.ca/dataset/fire-burn-severity-same-year")
bcdc_get_citation("https://catalogue.data.gov.bc.ca/dataset/fire-burn-severity-same-year/resource/1ff6244d-cea0-4d66-a246-f523aa2efa91")


#...........................................................
# Fuel types ----

WHSE_LAND_AND_NATURAL_RESOURCE.PROT_FUEL_TYPE_SP <- bcdc_query_geodata("WHSE_LAND_AND_NATURAL_RESOURCE.PROT_FUEL_TYPE_SP") %>%
  collect()
bcdc_get_citation("https://catalogue.data.gov.bc.ca/dataset/bc-wildfire-fire-fuel-types-public/resource/a0d25dd1-e906-4b9f-994e-bf99098621d0")




#...........................................................
# plot ----

library(leaflet)

m <-
  leaflet() %>%
  addTiles() %>%
  setView(lng = -120.0607, lat = 49.1726, zoom = 10) %>%
  # addProviderTiles(providers$Esri.WorldImagery) %>%
  addPolylines(data = WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_FIRE_POLYS_SP, color = "red",  
               # dashArray = "9,9", 
               stroke = 1, opacity = 0.5) #%>%
# addMiniMap(width = 150, height = 150)


# Save
# library(mapview)
# webshot::install_phantomjs()
mapshot(m, file = "figures/leaflet_fire_map.png")





