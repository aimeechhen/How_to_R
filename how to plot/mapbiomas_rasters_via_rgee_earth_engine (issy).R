

# Map and extract mapbiomas images


library(rgee)
library(sf)
library(terra)
library(ggplot2)
library(tidyterra)
library(stringr)



rgee::ee_Initialize(user = 'katchhen@gmail.com', drive = TRUE, gcs = FALSE,
                    credentials = "persistent")


# Load image (raster)
integration <- ee$Image('projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_integration_v1')
transition <- ee$Image('projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_transitions_v1')
deforestation <- ee$Image('projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_deforestation_secondary_vegetation_v1')
veg_age <- ee$Image('projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_secondary_vegetation_age_v1')
pasture <- ee$Image('projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_pasture_quality_v1')
irrigation <- ee$Image('projects/mapbiomas-public/assets/brazil/lulc/collection9/mapbiomas_collection90_irrigated_agriculture_v1')
# xx <- ee$Image('')

image <- pasture
image <- deforestation
image <- irrigation

#..................................................
# View image properties

# inspect data details
ee_print(image)
# Get the band names (variables/layer) from the image
image$bandNames()$getInfo()
# Get the properties of the image
image$propertyNames()$getInfo()
# Inspect raw metadata
ee$Image(image)$getInfo()



#..................................................

# extract a band (layer) from the image
pasture_2019 <- image$select('pasture_quality_2019')
deforest_2019 <- image$select('classification_2019')
irrigation_2019 <- image$select('irrigated_agriculture_2019')

#....................................................
# set area of interest
# center point (centroid) of the study area data
longitude <- -48
latitude <- -18
# Define the radius around the center point
radius_of_interest_meters <- 100000
# Create a geometry for the area of interest as GEE object, defining the area of interest based on the center of the data and radius around it
area_of_interest <- ee$Geometry$Point(c(longitude, latitude))$
  buffer(radius_of_interest_meters)
# center the map to aoi
Map$centerObject(eeObject = area_of_interest,
                 zoom = 9)

#....................................................

# map
m1 <-
  Map$addLayer(
    eeObject = area_of_interest,
    visParams = list(color = 'green'),
    name = '1 Area of interest',
    shown = TRUE,
    opacity = 0.2)

m2 <-
  Map$addLayer(
    eeObject = pasture_2019,
    visParams = list(palette = 'tan'),
    name = '2 pasture',
    shown = TRUE,
    opacity = 0.7)

m3 <-
Map$addLayer(
  eeObject = deforest_2019,
  visParams = list(palette = 'brown'),
  name = '3 deforestation',
  shown = TRUE,
  opacity = 0.7)

m4 <-
Map$addLayer(
  eeObject = irrigation_2019,
  visParams = list(palette = 'darkcyan'),
  name = '4 irrigation',
  shown = TRUE,
  opacity = 0.7)


# map all bands
m1 + m2 + m3 + m4
