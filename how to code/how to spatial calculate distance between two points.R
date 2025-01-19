
# Calculate the distance from the centroid of the collar data to the furthest point of the fire perimeter

# load in collar data to set area of interest
source('./scripts/collar_data_and_shapefile.r')

# calculate the center point of the collar data based on all the data points. st_union is used due to multiple points
centroid <- st_centroid(st_union(collar_data_sf))

# import FOIPPA fire perimeters
FOIPPA <- st_read('data/fire/bc_gov_FOIPPA/crater_boundaries/23 K52125 Perimeter History Jun17.shp')
# convert projection into lat/long
FOIPPA <- st_transform(FOIPPA, crs = 4326)

# Calculate distances from the centroid to each multipolygon's boundary
perimeter_dist <- st_distance(centroid, st_boundary(FOIPPA))

# Convert 'units' type into numeric type
perimeter_dist <- as.numeric(perimeter_dist)

# Find the maximum distance (in m)
max(perimeter_dist, na.rm = TRUE)

