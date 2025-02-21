

library(maptiles)
library(tidyterra)


basemaptile <- get_tiles(bbox, provider = "OpenStreetMap", zoom = 13)

ggplot() +
  geom_spatraster_rgb(data = basemaptile)