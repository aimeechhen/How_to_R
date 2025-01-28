
# how to convert df to sf to spatraster (i.e. rasterize a df/sf object)

# import your data and convert into an sf object

# convert data into sf object
df_sf <- st_as_sf(df, coords = c('longitude', 'latitude'))
# set crs as lat/long system
st_crs(df_sf) <- 4326

# set spatial properties of the raster by defining the extent and crs as a template for the raster
ext_value <- ext(st_bbox(df_sf))
crs_value <- "EPSG:32610" # UTM projection that is in metric measurements
res_value <- 25 # 25m resolution based on UTM projection

# create a template for the spatial properties of the raster   
raster_template = rast(ext(ext_value),
                       crs = crs_value,
                       res = res_value)

# convert geometries into vector object (i.e into a spatvector object) then convert spatvector into a spatraster object using the spatial properties outlined in the template
r <- rasterize(vect(df_sf), raster_template)




#.......................................................................
# raster of polygons with timestamp

# get the outline of the polygons
outline <- st_boundary(df_sf)
# convert geometries into vector object (i.e into a spatvector object) 
outline_spatvector <- vect(outline)
# extract the timestamp for the current perimeter
capture_timestamp <- FOIPPA$timestamp[i]
# assign the timestamp
outline_spatvector$timestamp <- capture_timestamp
# then convert spatvector into a spatraster object using the spatial properties outlined above and set background cells/pixels in the raster to 0 so the raster contains only values of 0 or 1 (0 = outside the polygon, 1 = inside the polygon) via field and background arguments
r <- rasterize(outline_spatvector, raster_template, field = "timestamp", background = 0)












