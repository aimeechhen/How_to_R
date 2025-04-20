
# common/popular packages
library(sf)
library(raster) # might be getting depreciated? switch to terra
library(terra)
library(tidyterra)
# rgdal depreciated, use terra
# sp depreciated, use sf


#...............................................................
# How to spatial data basics:

# 1. import the file(s)
# 2. visualize the data
# 3. inspect spatial data properties

# Properties
# 1. crs (coordinate reference system)
# 2. extent (or bounding box), i.e., the range of the data spatially, how large is it etc.
# 3. resolution, how fine scale is the data? 10m scale? 1km scale? 5km scale?
# 4. other

# if working with multiple files
# ensure all files are the same object type, i.e., sf, spatraster etc
# check the data properties before converting/manipulating anything!!
# then start matching data properties via
# reprojecting, transforming, cropping, buffering, resampling, scaling etc
# various packages calls them different things




#////////////////////////////////////////////////////
#////////////////////////////////////////////////////



# get bounding box values
bbox <- st_bbox(x)
#set extent
bbox_ext <- ext(bbox["xmin"], bbox["xmax"], bbox["ymin"], bbox["ymax"])

# or combine, get bounding box and set extent
bbox_ext <- ext(st_bbox(x))

#........................................................................
# check if all rasters in a list have the same extent

# Function to check if all rasters have the same extent
check_extent_match <- function(raster_list) {
  # Extract the extents of each raster
  extents <- lapply(raster_list, ext)
  
  # Compare all extents to the first raster's extent
  reference_extent <- extents[[1]]
  match_results <- sapply(extents, function(x) x == reference_extent)
  
  # Return a list with results and details
  list(
    all_match = all(match_results),
    match_details = match_results,
    reference_extent = reference_extent
  )
}

# Check if all extents match
result <- check_extent_match(raster_list)

# Print results
if (result$all_match) {
  cat("All rasters have matching extents.\n")
} else {
  cat("Rasters do not have matching extents.\n")
  print(result$match_details)
}


#.....................................................................

# for Lauren

library(raster)
library(ncdf4)
library(sf)

# Import rasters
hfi_raster <- raster("C:/Users/achhen/Downloads/ml_hfi_v1_2019.nc")
library(geodata)
# Download elevation raster (Global)
world_elevation <- elevation_global(0.5, "C:/Users/achhen/Downloads/elevation/world_elevation")
# Download elevation raster (Canada)
elevation_raster <- elevation_30s(country="CAN", path="C:/Users/achhen/Downloads/elevation/canada_elevation")
# Convert spatraster to a raster object
elevation_raster <- raster(elevation_raster)

library(canadianmaps)
# Download shapefile of Canada
# Convert to spatial features (sf) object
provinces <- st_as_sf(PROV)
# Extract BC
bc_shape <- provinces[provinces$PRENAME == 'British Columbia',]
# Extract boundaries only
bc_shape <- st_geometry(bc_shape)
# Extract the bounding box of the sf object
bc_bbox <- st_bbox(bc_shape)

# Crop the raster to the extent of the BC
hfi_raster_crop <- crop(hfi_raster, bc_bbox)
elevation_raster_crop <- crop(elevation_raster, bc_bbox)

# Match all CRS 
hfi_raster_crop_reproj <- projectRaster(hfi_raster_crop, crs = crs(bc_shape))
elevation_raster_crop_reproj <- projectRaster(elevation_raster_crop, crs = crs(bc_shape))

# Match all resolution based HFI resolution
elevation_resampled <- resample(elevation_raster_crop_reproj, hfi_raster_crop_reproj, method = "bilinear")

# Rename to match the other script
HFI <- hfi_raster_crop_reproj
elevation_m <- elevation_resampled




#.................................................
# from Stefano

# finding the center between series of points
data.frame(long = c(11.1, 23.7), lat = c(42.6, 52.7)) %>%
  st_as_sf(coords = c('long', 'lat')) %>%
  st_set_crs('EPSG:4326') %>%
  st_union() %>%
  st_centroid()

# add another variable if you want to keep groups separate
data.frame(long = rnorm(100),
           lat = rnorm(100),
           group = sample(c('a', 'b'), 100, replace = TRUE)) %>%
  st_as_sf(coords = c('long', 'lat')) %>%
  st_set_crs('EPSG:4326') %>%
  group_by(group) %>%
  summarise(geometry = st_union(geometry)) %>%
  ungroup() %>%
  st_centroid()




#................................................................



# how to extract raster values based on polygon ----
#reproject the CRS to a geographic coordinate system (e.g., WGS 84)
FOIPPA <- st_transform(FOIPPA, crs = st_crs("epsg:4326"))
#get bounding box
bbox <- st_bbox(FOIPPA)

#Get elevation raster for the region(s) of interest (units = meters)
dem_raster <- get_elev_raster(locations = FOIPPA, 
                              z = 9,
                              clip = 'bbox',
                              expand = 0.2)
raster::plot(dem_raster)

# crop and mask elevation raster to extract values within boundaries
cropped_dem <- crop(dem_raster, FOIPPA)
masked_dem <- mask(cropped_dem, FOIPPA)

# extract elevation values
el_value <- as.data.frame(masked_dem, xy = TRUE, na.rm = TRUE)
# rename columns
colnames(el_value) <-  c("long", "lat", "el")



# how to convert shapefile polygons (sf object) into a dataframe and their coordinates ----
# Extract the coordinates
coords <- st_coordinates(cathedral)
# Combine coordinates with the attributes of the sf object
cathedral_coords <- cbind(st_drop_geometry(cathedral), coords)
# create df so it can be used in movevis
cathedral_df <- data.frame(x = cathedral_coords$X,
                           y = cathedral_coords$Y)


# how to define an area of interest ----
centroid <- st_centroid(cathedral)
# defining the area of interest based on the center of the collar data/park and radius around it (in meters)
area_of_interest <- st_buffer(centroid, dist = 15000)
# Create a geometry for the area of interest
area_of_interest <- st_as_sfc(st_bbox(area_of_interest))
st_crs(area_of_interest) <- 4326 
# extract aoi
aoi_bbox <- as.numeric(st_bbox(area_of_interest)[c("xmin", "xmax", "ymin", "ymax")])

plot(area_of_interest)
plot(cathedral, add = TRUE)




# draw around a bunch of points to create a polygon
hull <- data %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 3005) %>%
  summarize(geometry = st_union(geometry)) %>%
  st_convex_hull()