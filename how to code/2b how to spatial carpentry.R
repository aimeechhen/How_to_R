

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
