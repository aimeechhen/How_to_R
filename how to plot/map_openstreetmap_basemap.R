
# How to create base maps with layers

library(ggplot2)
library(osmdata)

#information about osm
#https://rspatialdata.github.io/osm.html
#get the list of recognized features
available_features("agriculture")

#lists out the tags associated with each feature (eg. streets)
#available features of the different classifications of streets and other map features this package works with
available_tags("highway")
available_tags("waterway")

#............................................................
# Base map
#............................................................

# Get bounding box for the geographic location of a city
#Campo Grande, Brazil
bbox <- getbb("Campo Grande Brazil")

#........
# Roads
#........

# Create an overpass query for big streets
big_streets <- opq(bbox)
# Add OSM features for highways
big_streets <- add_osm_feature(big_streets, key = "highway", 
                               value = c("motorway", 
                                         "primary", "motorway_link",
                                         "primary_link"))
# Retrieve OSM data as an sf object
big_streets <- osmdata_sf(big_streets)

# Create an overpass query for medium streets
med_streets <- opq(bbox)
med_streets <- add_osm_feature(med_streets, key = "highway", 
                               value = c("secondary", 
                                         "tertiary", 
                                         "secondary_link", 
                                         "tertiary_link"))
# Retrieve OSM data as an sf object
med_streets <- osmdata_sf(med_streets)

# Create an overpass query for small streets
small_streets_query <- opq(bbox)
small_streets_query <- add_osm_feature(small_streets_query, key = "highway", 
                                       value = c("residential", 
                                                 "living_street", 
                                                 "unclassified", 
                                                 "service", 
                                                 "footway"))
# Retrieve OSM data as an sf object
small_streets <- osmdata_sf(small_streets_query)

#......
# Water
#.......
# Create an overpass query for rivers
water_query <- opq(bbox)
water_query <- add_osm_feature(water_query, key = "waterway", 
                               value = "river")
# Retrieve OSM data as an sf object
water <- osmdata_sf(water_query)

# Print the results
med_streets
small_streets
water

#Test basemap plot of Campo Grande, Brazil
ggplot() +
  #water layer
  geom_sf(data = water$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .8,
          alpha = .3) +
  #road layer
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .3,
          alpha = .5)
  # geom_sf(data = med_streets$osm_lines,
  #         inherit.aes = FALSE,
  #         color = "#666666",
  #         size = .2,
  #         alpha = .3) +
  # geom_sf(data = small_streets$osm_lines,
  #         inherit.aes = FALSE,
  #         color = "black",
  #         size = .5,
  #         alpha = .6) 

