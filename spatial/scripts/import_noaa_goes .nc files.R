
# NOAA GOES Data

#import NOAA GOES .nc data
library(ncdf4)

setwd("C:/Users/achhen/Desktop/goes_data")

# #import data
# ncfile <- nc_open("spatial/data/noaa_goes18/ABI-L2-FDCC/2023/001/00/OR_ABI-L2-FDCC-M6_G18_s20230010001170_e20230010003543_c20230010004145.nc")
# #check the available variables
# names(ncfile$var)
# 
# nc_data <- nc_open("spatial/data/noaa_goes18/ABI-L2-FDCC/2023/001/00/OR_ABI-L2-FDCC-M6_G18_s20230010001170_e20230010003543_c20230010004145.nc")
# # Save the print(nc) dump to a text file
# {
#   sink('spatial/data/noaa_goes18/ncdata.txt')
#   print(nc_data)
#   sink()
# }

library(terra)
# #import data as raster (this is 1 day)
# goesfile <- raster("spatial/data/noaa_goes18/ABI-L2-FDCC/2023/001/00/OR_ABI-L2-FDCC-M6_G18_s20230010001170_e20230010003543_c20230010004145.nc", varname = "Temp")

# import as spatraster object
goesfile_spat <- rast("spatial/data/noaa_goes18/ABI-L2-FDCC/2023/001/00/OR_ABI-L2-FDCC-M6_G18_s20230010001170_e20230010003543_c20230010004145.nc")

#https://gis.stackexchange.com/questions/480867/clip-a-netcdf-file-using-gdal-translate-or-gdalwarp

#View the data
goesfile_spat
crs(goesfile_spat)


#_________________________________________________________________________________
# GOES Imager Projection

# https://www.star.nesdis.noaa.gov/atmospheric-composition-training/satellite_data_goes_imager_projection.php#lat_lon_files

# GOES Imager Projection, also called the ABI Fixed Grid, is the projection information included in all ABI Level 1b radiance data files and most ABI Level 2 derived product data files.
# To work with ABI Level 2 files using latitude and longitude to plot the data variables (e.g., ADP, AOD, FDC), then it is necessary to calculate latitude and longitude from the GOES Imager Projection information.
# To calculate, download netCDF4 .nc files from source above, unzip file, open the appropriate file and read in the latitude and longitude arrays.

#https://www.star.nesdis.noaa.gov/atmospheric-composition-training/satellite_data_goes_imager_projection.php#lat_lon_files

library(ncdf4)

# Read GOES calculated conversion projection into lat-long crs file
goes_latlon <- nc_open("spatial/data/noaa_goes18/goes18_abi_full_disk_lat_lon.nc")
goes_latlon
goes_lat <- ncvar_get(goes_latlon, "latitude")
goes_lon <- ncvar_get(goes_latlon, "longitude")
nc_close(goes_latlon)

# # Import GOES calculated conversion projection into lat-long crs file
# goes_latlon_rast <- rast("spatial/data/noaa_goes18/goes18_abi_full_disk_lat_lon.nc")
# goes_latlon_rast

# Read goes data
goes_file <- nc_open("spatial/data/noaa_goes18/ABI-L2-FDCC/2023/001/00/OR_ABI-L2-FDCC-M6_G18_s20230010001170_e20230010003543_c20230010004145.nc")
goes_file
# 46 variables

# Identify which variables you want
names(goes_file$var)

# extract data
goes_temp <- ncvar_get(goes_file, "Temp")

# Close nc file
nc_close(goes_file)

# Check dimensions
dim(goes_lat)
dim(goes_lon)
dim(goes_temp)

# They do not match .-. create raster objects for latitude and longitude
lat_raster <- raster(matrix(goes_lat, nrow = nrow(goes_lat), ncol = ncol(goes_lat)))
lon_raster <- raster(matrix(goes_lon, nrow = nrow(goes_lat), ncol = ncol(goes_lat)))

# And create a raster object for the temperature data
temp_raster <- raster(matrix(goes_temp, nrow = nrow(goes_temp), ncol = ncol(goes_temp)))

# Set the extent of the temperature raster to match the lat/lon rasters
extent(temp_raster) <- extent(lat_raster)

# Then ,resample the temperature raster to match the lat/lon rasters
resampled_temp <- resample(temp_raster, lat_raster, method = "bilinear")

# Now, a raster stack with the data variable and lat/lon arrays can be made
# goes_stack <- stack(
#   raster(matrix(goes_temp, nrow = nrow(goes_lat), ncol = ncol(goes_lat))),
#   raster(matrix(goes_lat, nrow = nrow(goes_lat), ncol = ncol(goes_lat))),
#   raster(matrix(goes_lon, nrow = nrow(goes_lat), ncol = ncol(goes_lat)))
# )

# Create a raster stack with the resampled temperature data and lat/lon arrays
goes_stack <- stack(
  resampled_temp,
  lat_raster,
  lon_raster
)

# Check if names are correct
names(goes_stack)

# Rename
# Name the layers for clarity
names(goes_stack) <- c("temperature", "latitude", "longitude")

# Set the coordinate reference system (CRS)
crs(goes_stack) <- crs("+proj=longlat +datum=WGS84")
crs(goes_stack) <- "EPSG:4326"
crs(goes_stack)

goes_spat <- rast(goes_stack)

library(tidyterra)
ggplot() +
  geom_spatraster(data = goes_spat, aes(fill = temperature))

# python code -> https://www.star.nesdis.noaa.gov/atmospheric-composition-training/python_abi_lat_lon.php





#.............................................................
#Import all noaa goes files
# List all .nc files in the folder
goes_files <- list.files("spatial/data/noaa_goes18/ABI-L2-FDCC/2023/", 
                         pattern = "\\.nc$", full.names = TRUE)
# Create a raster stack
goes_stack <- stack(goes_files, varname = "NDVI")
# Merge the raster stack into one raster with the mean value for each pixel
goes_raster <- mean(goes_stack, na.rm = TRUE)
# Save the merged raster
writeRaster(goes_raster, filename = "spatial/data/noaa_goes18/ABI-L2-FDCC_2023_mean_values.tif", format = "GTiff", overwrite = TRUE)