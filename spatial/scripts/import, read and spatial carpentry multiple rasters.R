
library(ctmm)

#import home range UD
load("data/goat_akdes.rda")

#import multiple home range rasters and merge into one
folder_path <- "data/home_range/UD"
AKDES_rasters <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)

# Load the first raster as a reference for resolution
res_ref <- rast(AKDES_rasters[1])

# Initialize the merged raster with the reference raster
AKDES_merged <- res_ref

for (raster_path in AKDES_rasters) {
  # Import raster
  raster_data <- rast(raster_path)
  # Reproject raster
  raster_data <- project(raster_data, "+proj=longlat +datum=WGS84")
  #  match the reference resolution
  raster_data <- resample(raster_data, res_ref)
  # Add to the raster stack
  AKDES_merged <- merge(AKDES_merged, raster_data)
}

writeRaster(AKDES_merged, filename = "data/home_range/hr_raster.tif", overwrite = TRUE)

hr.raster <- rast("data/home_range/hr_raster.tif")