library(sf)

# ab <- st_read("data/NP_boundaries/CLAB_AB_2023-09-08/CLAB_AB_2023-09-08.shp")
# st_layers("data/NP_boundaries/CLAB_AB_2023-09-08/CLAB_AB_2023-09-08.shp")
# plot(ab)
# 
# # Choose one of the boundaries (view shapefile to see park listing)
# jasp <- ab[3, ]
# plot(jasp)
# 
# # Extract individual geometries
# jasp_geo <- st_geometry(jasp)
# 
# # Plot only the first geometry (polygon) 
# plot(jasp_geo[1])

#..........................................................

library(raster)
shp <- shapefile("data/NP_boundaries/CLAB_AB_2023-09-08/CLAB_AB_2023-09-08.shp")
plot(shp)

#Identify which parks are in the shapefile
shp@data[["CLAB_ID"]]

#subset yoho shapefile out
JASP <- shp[shp$CLAB_ID == "JASP", ]

#plot the specific park you want
plot(JASP)

#..........................................................

#Import all ndvi files
# List all .nc files in the folder
ndvi_files_2018 <- list.files("data/habitat/noaa_ndvi/2018/", 
                         pattern = "\\.nc$", full.names = TRUE)

# Create a raster stack
ndvi_stack <- stack(ndvi_files_2018, varname = "NDVI")

# Merge the raster stack into one raster with the mean value for each pixel
#ndvi_2018 <- mean(ndvi_stack, na.rm = TRUE)

# Save the merged raster
#writeRaster(ndvi_2018, filename = "data/habitat/ndvi_raster_2018_mean_values.tif", format = "GTiff", overwrite = TRUE)

#...........................................................

library(terra)

# Crop NDVI to park size

#convert to spatraster object
ndvi_2018_spat <- rast(ndvi_stack)

#crop the ndvi to match the extent of the jasper park
ndvi_2018_crop <- crop(ndvi_2018_spat, JASP)

#convert back spatraster to raster
ndvi_2018_raster <- as(ndvi_2018_crop, "Raster")

#get NDVI with jasper boundary
ndvi_jasper <- mask(ndvi_2018_raster, JASP)

#extract NDVI values for jasper
ndvi_values <- getValues(ndvi_jasper)

#convert NDVI values to numeric
ndvi_values <- as.numeric(ndvi_values)

#plot the NDVI values
hist(ndvi_values, main = "NDVI Distribution for Jasper Park", xlab = "NDVI")

#plot ndvi for jasper
plot(ndvi_jasper, main = "NDVI Map for Jasper Park")

#................................................

#calculate the mean NDVI
mean_ndvi_jasper <- mean(ndvi_jasper, na.rm = TRUE)

#plot mean ndvi for jasper for 2018
plot(mean_ndvi_jasper, main = "Mean NDVI for Jasper Park for 2018")

#................................................

#rescale the NDVI values from [0, 2500] to [-1, 1]
mean_ndvi_jasper_scaled <- scale(mean_ndvi_jasper, center = 1250, scale = 1250)


#plot mean ndvi rescaled for jasper for 2018
plot(mean_ndvi_jasper_scaled, main = "Mean NDVI rescaled for Jasper Park for 2018")



#.............................................................

#For all the years

# Define the directory path where the NDVI files are located
directory <- "data/habitat/noaa_ndvi/"

# Create an empty list to store the mean scaled NDVI values for each year
mean_ndvi_scaled_list <- list()

# Loop through each year from 2011 to 2022
for (year in 2011:2022) {
  # List all .nc files in the folder for the current year
  ndvi_files <- list.files(paste0(directory, year, "/"), pattern = "\\.nc$", full.names = TRUE)
  
  # Create a raster stack
  ndvi_stack <- stack(ndvi_files, varname = "NDVI")
  
  # Convert to spatraster object
  ndvi_spat <- rast(ndvi_stack)
  
  # Crop the NDVI to match the extent of the jasper park
  ndvi_crop <- crop(ndvi_spat, JASP)
  
  # Convert back spatraster to raster
  ndvi_raster <- as(ndvi_crop, "Raster")
  
  # Get NDVI with jasper boundary
  ndvi_jasper <- mask(ndvi_raster, JASP)
  
  # Extract NDVI values for jasper
  ndvi_values <- getValues(ndvi_jasper)
  
  # Convert NDVI values to numeric
  ndvi_values <- as.numeric(ndvi_values)
  
  # Calculate the mean NDVI
  mean_ndvi <- mean(ndvi_values, na.rm = TRUE)
  
  # Rescale the NDVI values from [0, 2500] to [-1, 1]
  mean_ndvi_scaled <- scale(mean_ndvi, center = 1250, scale = 1250)
  
  # Store the mean scaled NDVI value for the current year in the list
  mean_ndvi_scaled_list[[as.character(year)]] <- mean_ndvi_scaled
}

