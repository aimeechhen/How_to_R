
# how to convert sf to spatraster (i.e. rasterize a sf object)

# set spatial properties of the raster by defining the extent and crs as a template for the raster
ext_value <- ext(st_bbox(x))
crs_value <- "EPSG:32610" # UTM projection that is in metric measurements
res_value <- 25 # 25m resolution based on UTM projection

# create a template for the spatial properties of the raster   
raster_template = rast(ext(ext_value),
                       crs = crs_value,
                       res = res_value)


# convert geometries into vector object (i.e into a spatvector object) then convert spatvector into a spatraster object using the spatial properties outlined in the template
raster_perimeter <- rasterize(vect(perimeter), raster_template)