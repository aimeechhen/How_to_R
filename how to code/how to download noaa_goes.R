
# Download NOAA GOES-18 data from Amazon

# geosatellite data via NOAA GOES
# https://www.noaa.gov/information-technology/open-data-dissemination/stories/cloud-access-to-provisional-goes-18-data-now-available-through-noaa-open-data-dissemination-nodd
# GOES Program documents: https://www.goes-r.gov/resources/docs.html

# data online bucket (source): https://noaa-goes18.s3.amazonaws.com/index.html
# data info: https://github.com/awslabs/open-data-docs/tree/main/docs/noaa/noaa-goes16
# data product info: https://www.goes-r.gov/products/overview.html#ABI

# FIRE/HOT SPOT CHARACTERIZATION
# https://www.goes-r.gov/products/baseline-fire-hot-spot.html

# ABI-L2-FDCC - Advanced Baseline Imager Level 2 Fire (Hot Spot Characterization) CONUS
# ABI-L2-FDCF - Advanced Baseline Imager Level 2 Fire (Hot Spot Characterization) Full Disk
# ABI-L2-FDCM - Advanced Baseline Imager Level 2 Fire (Hot Spot Characterization) Mesoscale
# https://home.chpc.utah.edu/~u0553130/Brian_Blaylock/cgi-bin/goes16_download.cgi



library(aws.s3)
library(tidyverse)

#check if bucket exist
bucket_exists("s3://noaa-goes18/ABI-L2-FDCC/2023")
bucket_exists("s3://noaa-goes18/ABI-L2-FDCF/2023")
bucket_exists("s3://noaa-goes18/ABI-L2-FDCM/2023")

# List all files in the S3 bucket and its subfolders
goes_bucket <- get_bucket("noaa-goes18", prefix = "ABI-L2-FDCC/2023/", max = Inf)

setwd("C:/Users/achhen/Desktop/goes_data")

#..............................................................
# 1. ABI-L2-FDCC - Advanced Baseline Imager Level 2 Fire (Hot Spot Characterization) CONUS ----
#..............................................................

# Retrieve all files in the bucket as a dataframe (takes a few minutes to retrieve)
goes_files <- get_bucket_df("noaa-goes18", prefix = "ABI-L2-FDCC/2023/", max = Inf) %>% 
  as_tibble()

library(httr)

# Create a function to download and save an object from S3
download_files <- function(key, bucket, index, total) {
  # Generate a filename from the key
  filename <- basename(key)
  # Extract the directory structure from the key
  dirs <- dirname(key)
  # Create directories if they don't exist
  full_path <- file.path("spatial", "data", "noaa_goes18", dirs)
  dir.create(full_path, recursive = TRUE, showWarnings = FALSE)
  # Specify the full path to save the file
  full_path <- file.path(full_path, filename)
  # Construct the URL for downloading the object
  url <- paste0("https://", bucket, ".s3.amazonaws.com/", URLencode(key))
  # Download the object
  response <- GET(url, progress())
  # Check if download was successful
  if (status_code(response) == 200) {
    # Save the content to the specified path
    writeBin(content(response, "raw"), full_path)
    # Print progress
    cat("Downloaded", index, "of", total, "files:", key, "\n")
  } else {
    # Print an error message if download failed
    cat("Failed to download:", key, "\n")
  }
}

# Download files using custom function
START <- Sys.time()
total_files <- nrow(goes_files)
for (i in 1:total_files) {
  download_files(goes_files$Key[i], bucket = "noaa-goes18", index = i, total = total_files)
}
END <- Sys.time()






#..............................................................
# 2. ABI-L2-FDCF - Advanced Baseline Imager Level 2 Fire (Hot Spot Characterization) Full Disk ----
#..............................................................

# Retrieve all files in the bucket as a dataframe (takes a few minutes to retrieve)
goes_files <- get_bucket_df("noaa-goes18", prefix = "ABI-L2-FDCF/2023/", max = Inf) %>% 
  as_tibble()

library(httr)

# Create a function to download and save an object from S3
download_files <- function(key, bucket, index, total, processed_dirs) {
  # Generate a filename from the key
  filename <- basename(key)
  # Extract the directory structure from the key
  dirs <- dirname(key)
  # Create directories if they don't exist
  full_path <- file.path("spatial", "data", "noaa_goes18", dirs)
  dir.create(full_path, recursive = TRUE, showWarnings = FALSE)
  # Specify the full path to save the file
  full_path <- file.path(full_path, filename)
  # Construct the URL for downloading the object
  url <- paste0("https://", bucket, ".s3.amazonaws.com/", URLencode(key))
  # Download the object
  response <- GET(url, progress())
  # Check if download was successful
  if (status_code(response) == 200) {
    # Save the content to the specified path
    writeBin(content(response, "raw"), full_path)
    # Print progress if the directory is new
    if (!dirs %in% processed_dirs) {
      cat("Downloaded directory:", dirs, "(", index, "of", total, "files)\n")
      # Add the new directory to the processed_dirs list
      return(dirs)
    }
  } else {
    # Print an error message if download failed
    cat("Failed to download:", key, "\n")
  }
  return(NULL)
}

# Download files using custom function
START <- Sys.time()
total_files <- nrow(goes_files)
processed_dirs <- character()

for (i in 1:total_files) {
  new_dir <- download_files(goes_files$Key[i], bucket = "noaa-goes18", index = i, total = total_files, processed_dirs)
  if (!is.null(new_dir)) {
    processed_dirs <- c(processed_dirs, new_dir)
  }
}
END <- Sys.time()






#..............................................................
# 3. ABI-L2-FDCM - Advanced Baseline Imager Level 2 Fire (Hot Spot Characterization) Mesoscale ----
#..............................................................


# Retrieve all files in the bucket as a dataframe (takes a few minutes to retrieve)
goes_files <- get_bucket_df("noaa-goes18", prefix = "ABI-L2-FDCM/2023/", max = Inf) %>% 
  as_tibble()

# Run custom function from above

# Download files using custom function
START <- Sys.time()
total_files <- nrow(goes_files)
processed_dirs <- character()

for (i in 1:total_files) {
  new_dir <- download_files(goes_files$Key[i], bucket = "noaa-goes18", index = i, total = total_files, processed_dirs)
  if (!is.null(new_dir)) {
    processed_dirs <- c(processed_dirs, new_dir)
  }
}
END <- Sys.time()
