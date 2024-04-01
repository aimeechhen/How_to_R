
# ndvi data

#import NOAA NDVI .nc data
library(ncdf4)
#import data
ncfile <- nc_open("spatial/data/noaa_ndvi/2018/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20181224_c20220418130415.nc")
#check the available variables
names(ncfile$var)

#import data as raster (this is 1 day)
ndvifile <- raster("spatial/data/noaa_ndvi/2018/VIIRS-Land_v001-preliminary_NPP13C1_S-NPP_20181224_c20220418130415.nc", varname = "NDVI")
#Convert raster to spatraster object
ndvifile_spat <- rast(ndvifile)
#******there is a plotting difference between raster and spatraster types, why?
plot(ndvifile)
plot(ndvifile_spat)



#.............................................................
#Import all ndvi files
# List all .nc files in the folder
ndvi_files <- list.files("spatial/data/noaa_ndvi/2018/", 
                         pattern = "\\.nc$", full.names = TRUE)
# Create a raster stack
ndvi_stack <- stack(ndvi_files, varname = "NDVI")
# Merge the raster stack into one raster with the mean value for each pixel
ndvi_raster <- mean(ndvi_stack, na.rm = TRUE)
# Save the merged raster
writeRaster(ndvi_raster, filename = "spatial/data/noaa_ndvi/ndvi_raster_2018_mean_values.tif", format = "GTiff", overwrite = TRUE)