
# Plotting collar data for visualization
#https://movevis.org/


devtools::install_github("16EAGLE/moveVis")
library(moveVis)
library(move)

# Load collar data
load("data/goat/goat_data.rda")

# Convert dataframe collar data into a move object
move_data <- df2move(goat_data, 
                     proj = "epsg:4326",
                     x = "location.long", y = "location.lat", time = "timestamp",
                     track_id = "goat_id")

# if you need to transform, must use sp as st_transform() doesnt work for movestack objects
move_data <- sp::spTransform(move_data, crs("+init=epsg:4326"))

# align move_data to a uniform time scale (may take a while)
m <- align_move(move_data, res = 120, unit = "mins")

# create spatial frames with a OpenStreetMap watercolour map (basemap is used by default)
frames <- frames_spatial(m, path_colours = rainbow(10)) %>% #,
                         # map_service = "osm_stamen", map_type = "watercolor", alpha = 0.5) %>% 
  add_labels(x = "Longitude", y = "Latitude") %>% # add some customizations, such as axis labels
  add_northarrow() %>% 
  add_scalebar() %>% 
  add_timestamps(type = "label") %>% 
  add_progress()

frames[[100]] # preview one of the frames, e.g. the 100th frame

# preview a frame and adding a customization to test
frames[[100]] +
geom_path(aes(x = x, y = y), data = cathedral_df,
          colour = "black", linetype = "dashed", linewidth = 1.5)), data = cathedral_df)


# animate frames (may take a while, like hours, for a lot of data)
# animate_frames(frames, out_file = "figures/moveVis.gif")
Start <- Sys.time()
animate_frames(frames, out_file = "figures/moveVis.mp4")
# Approx animation duration = ~750.25s (~12.5 min) @ 25 fps for 18757 frames
End <- Sys.time()




# adding ggplot items such as rasters, shapefiles, ggplot customizations etc

#shapefile
add_gg(gg = expr(
geom_sf(data = cathedral, color = "black", fill = NA, linewidth = 1, linetype = "dashed")), data = cathedral) %>%

  #shapefile converted into points, dataframe object
  add_gg(gg = expr(
    geom_path(aes(x = x, y = y), data = cathedral_df,
              colour = "black", linetype = "dashed", linewidth = 1.5)), data = cathedral_df) %>%
  
  # ggplot customizations
  add_gg(expr(theme(legend.title = element_blank()))) %>% 
  add_gg(expr(guides(linetype = "none"))) %>% 
  
  # adding a static text to the plot
  add_text("Cathedral Provincial Park Boundary", 
           x = -120.07, y = 49.003, #based on coordinates because the plot was based on coordinates for x and y
           colour = "black", size =2)