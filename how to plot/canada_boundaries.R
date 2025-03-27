
library(canadianmaps)
library(tidyverse)
library(sf)


library(canadianmaps)
canada <- st_as_sf(PROV) %>%  # convert to spatial features (sf) object
  st_geometry() # extract boundaries only

bc_shape <- st_as_sf(PROV) %>%  # convert to spatial features (sf) object
  filter(PRENAME == 'British Columbia') %>% # filter to BC only
  st_geometry() # extract boundaries only


#.........................................................
# Base R plot (Canada+BC)
#.........................................................

library(geodata)
#define the projection system
crs_wintri <- "ESRI:53018"  

#download boundaries
provinces <- gadm(country="Canada", level=1, path = tempdir()) #include provinces border

#subset to bc boundaries
bc <- provinces[provinces$NAME_1 %in% "British Columbia", ]

#reproject
bc_wintri <- project(bc, crs_wintri)

# plot bc
plot(bc)

#..............................................................
# Base R: canada + us ----
#..............................................................

library(geodata)
#level 0 = country; level 1 = province/state; level 2 = counties
provinces <- gadm(country="Canada", level=1, path = tempdir())
states <- gadm(country="USA", level=1, path = tempdir())

#plot both shape files, layered
plot(provinces)
plot(states, add = TRUE)

#Check names
CanUS <- rbind(states, provinces)
print(unique(CanUS$NAME_1))

#https://stackoverflow.com/questions/10763421/r-creating-a-map-of-selected-canadian-provinces-and-u-s-states

# OR
#https://plantarum.ca/2023/02/13/terra-maps/

CanUS <- rbind(states, provinces)
plot(CanUS, xlim = c(-180, -50), border = "darkgrey", col = "grey")
plot(CanUS[CanUS$NAME_1 %in% "British Columbia", ], border="black", 
     col="white", add=TRUE)



