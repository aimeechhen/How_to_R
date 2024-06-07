

library(raster)
library(ncdf4)
library(sf)

# Import rasters
soil_raster <- raster("C:/Users/achhen/Downloads/HWSD2.bil")
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
soil_raster_crop <- crop(soil_raster, bc_bbox)
hfi_raster_crop <- crop(hfi_raster, bc_bbox)
elevation_raster_crop <- crop(elevation_raster, bc_bbox)

# Match all CRS 
soil_raster_crop_reproj <- projectRaster(soil_raster_crop, crs = crs(bc_shape))
hfi_raster_crop_reproj <- projectRaster(hfi_raster_crop, crs = crs(bc_shape))
elevation_raster_crop_reproj <- projectRaster(elevation_raster_crop, crs = crs(bc_shape))

# Match all resolution based HFI resolution
soil_resampled <- resample(soil_raster_crop_reproj, hfi_raster_crop_reproj, method = "bilinear")
elevation_resampled <- resample(elevation_raster_crop_reproj, hfi_raster_crop_reproj, method = "bilinear")

# Rename to match the other script
HFI <- hfi_raster_crop_reproj
soil <- soil_resampled
elevation_m <- elevation_resampled



#Convert goat coordinates to sf object, spatial data points
coord_sf <- st_as_sf(goat_gps, coords = c("location.long", "location.lat"))
#Retrieve coordinate reference system (CRS) and set the CRS to a geographic coordinate system (e.g., WGS 84)
st_crs(coord_sf) <- st_crs("+proj=longlat +datum=WGS84")





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
