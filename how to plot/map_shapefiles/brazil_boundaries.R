
# shape file of Brazil

#............................................................
# Shape file map of Brazil ----
#............................................................

library(geobr)           #shape files for Brazil
library(ggplot2)

# country outline
br <- read_country(year = 2020, simplified = TRUE, showProgress = TRUE)

# Remove plot axis
no_axis <- theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank())
plot_br <- 
ggplot() +
  geom_sf(data=br, fill = "white", color="black", size=.15, show.legend = FALSE) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="none") +
  no_axis

ggsave(plot = plot_br, filename = "spatial/figures/br_outline.png", device = NULL,
       path = NULL, scale = 1, width = 6.86, height = 6, units = "in", dpi = 600, bg = "transparent")

# read all states
states <- read_state(year = 2020, showProgress = TRUE)

# Create a new variable in your 'states' dataset specifying the fill color
states$fill_color <- "grey"  # Set the default color for all states
states$fill_color[states$abbrev_state == "MS"] <- "white"  # Change color for the specific state


# #Brazil with meso regions outlined
# BR_meso_region <- read_meso_region(code_meso = "all", year = 2017, simplified = TRUE, showProgress = TRUE)
# 
# #state of Mato Grosso du Sul
# MS_state_micro <- read_micro_region(code_micro= "MS", year = 2017, simplified = FALSE, showProgress = TRUE)






plot_BR <-
  ggplot() +
  geom_sf(data=states, aes(fill = fill_color), color="black", size=.15, show.legend = FALSE) +
  #labs(subtitle="Brazil", size=8) +
  scale_fill_identity() +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="none") +
  no_axis
plot_BR

ggsave(plot = plot_BR, filename = "figures/map/plot_BR.png", device = NULL,
       path = NULL, scale = 1, width = 6.86, height = 6, units = "in", dpi = 600)

plot_MS <-
  ggplot() +
  geom_sf(data=MS_state_micro, fill="white", color="black", size=.15, show.legend = FALSE) +
  labs(subtitle="Mato Grosso du Sul", size=8) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="none") +
  no_axis
plot_MS

ggsave(plot = last_plot(), filename = "figures/map/MS_state_micro.png", device = NULL,
       path = NULL, scale = 1, width = 6.86, height = 6, units = "in", dpi = 600)

plot_BR_MS <- grid.arrange(plot_BR, plot_MS, 
                           ncol=2, widths = c(6,5.2))
# Save the figure
ggsave(plot_BR_MS,
       width = 10, height = 5, units = "in",
       dpi = 600,
       bg = "white",
       file="figures/map/plot_BR_MS.png")

#~~~~~~~~~~~~~~~~~~~~~~~~~
#MAPBIOMAS
library(sf)
map_states <- read_sf("data/map/dashboard_states-static-layer.shp")

mato <- map_states[map_states$name == "Mato Grosso do Sul",]

plot(map_states)
#~~~~~~~~~~~~~~~~~~~~~~~~~

# Assuming your data is in WGS 84 coordinate reference system (EPSG:4326)
gps_sf <- st_as_sf(DATA_GPS, coords = c("GPS.Longitude", "GPS.Latitude"), crs = 4326)

# Remove plot axis
no_axis <- theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank())

# South America level
# Load a basemap, for example, a world map using the 'rnaturalearth' package
library(rnaturalearth)
world <- ne_countries(scale = "medium", returnclass = "sf")

# Filter out South America by continent code (continent = "South America")
south_america <- world[world$continent == "South America", ]

# Filter out Brazil by country name (name = "Brazil")
brazil <- world[world$name == "Brazil", ]

#Brazil with meso regions outlined
library(geobr)
BR_meso_region <- read_meso_region(code_meso = "all", year = 2017, simplified = TRUE, showProgress = TRUE)

ggplot() +
  geom_sf(data = south_america, fill = "darkgrey") +
  geom_sf(data = BR_meso_region, fill="white", color="black", size=.15, show.legend = FALSE) +
  # geom_sf(data = gps_sf, color = "red", size = 1) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# country level
#state of Mato Grosso du Sul
MS_state <- read_meso_region(code_meso= "MS", year = 2017, simplified = FALSE, showProgress = TRUE)
#state of Mato Grosso du Sul
MS_state_micro <- read_micro_region(code_micro= "MS", year = 2017, simplified = FALSE, showProgress = TRUE)


ggplot() +
  geom_sf(data = BR_meso_region, fill = "darkgrey") +
  geom_sf(data = MS_state_micro, fill="white", color="black", size=.15, show.legend = FALSE) +
  #geom_sf(data = gps_sf, color = "red", size = 1) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# state level

#region of Mato Grosso du Sul
MS_region <- read_region(year = 2017, simplified = FALSE, showProgress = TRUE)


