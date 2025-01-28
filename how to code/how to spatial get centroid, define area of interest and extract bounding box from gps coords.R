

# import your data and convert into an sf object
load("data/collar_data/collar_data_20240703.rda")
# convert df into sf object
collar_data_sf <- st_as_sf(collar_data, coords = c('longitude', 'latitude'))
# set crs as lat/long system
st_crs(collar_data_sf) <- 4326

# calculate the center point of the collar data based on all the data points. st_union is used due to multiple points
centroid <- st_centroid(st_union(collar_data_sf))

# Create a geometry for the area of interest, defining the area of interest based on the center of the collar data and radius around it (in meters)
area_of_interest <- st_buffer(centroid, dist = 50000)

# visualise
plot(area_of_interest)
plot(centroid, add = TRUE, col = 'red', pch = 19)
plot(collar_data_sf, add = TRUE, col = 'blue')

# extract bounding box of area of interest
bbox <- st_bbox(area_of_interest)



