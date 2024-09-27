
library(leaflet)
library(sf)


# import data points
df <- read.csv("C:/Users/achhen/Downloads/RA_Coords.csv")

m <- leaflet(df)
m <- addTiles(m)
m <- addMarkers(m, ~Long, ~Lat)
m

m <- leaflet(df)
m <- addTiles(m)
m <- addCircleMarkers(m, ~Long, ~Lat)
m



# save as a static plot
library(mapview)
webshot::install_phantomjs()
mapshot(m, file = "figures/leaflet_map.png")


# get shapefile of bc for example
library(geodata)
bc <- gadm(country = "Canada", level = 1, path = tempdir())
bc <- bc[bc$NAME_1 == "British Columbia", ]
bc


# plot it with bc shapefile
leaflet() %>%
  addTiles() %>%
  setView(lng=-120, lat=50, zoom = 12) %>% # center the map at this coordinate
  addPolygons(data = bc, color = "blue", fill = FALSE, weight = 2) %>%  # shapefile outline
  addMarkers(data = df, lng = ~Long, lat = ~Lat) # data points
# addCircleMarkers(m, ~Long, ~Lat)


