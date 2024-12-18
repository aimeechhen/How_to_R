

library(sf)


# .kmz must get unzipped/extracted and they get extracted to a .kml file 

# Directory of all the files
directory <- "data/helicopter/flight_data/2021_Track/"

# Path to the KMZ file
kmz_file <- "data/helicopter/flight_data/2021_Track/AS JUN 21-1.kmz"

# Extract/unzip the .kmz file
extracted_file <- unzip(kmz_file, exdir = paste0(directory, "extracted_kmz"))

# Rename the extracted file to match the original file name that is in the extracted directory

# Original file name without extension
original_filename <- tools::file_path_sans_ext(basename(kmz_file))

# Get the extracted file name
extracted_kmz_filename <- list.files("data/helicopter/flight_data/2021_Track_extracted_kmz", full.names = TRUE)

# Assuming there's only one file extracted from the KMZ, you can get its full path
extracted_file <- extracted_kmz_filename[1]

# Rename the extracted file to match the original file name and add .kml extension
kml_filename <- paste0(dirname(extracted_file), "/", original_filename, ".kml")

# Rename extracted kml file
file.rename(extracted_file, kml_filename)

# Import extracted file
kml_data <- st_read(dsn = kml_filename)


#.................................................................

# For all files

# Directory of all the files
directory <- "data/helicopter/flight_data/2021_Track/"

# Find and list all .kmz files in the folder
kmz_files <- list.files(directory, pattern = "\\.kmz$", full.names = TRUE)

# Iterate over each .kmz file
for (i in seq_along(kmz_files)) {
  # Extract/unzip the .kmz file
  extracted_files <- unzip(kmz_files[i], exdir = paste0(directory, "extracted_kmz"))
  
  # Original file name without extension
  original_file_name <- tools::file_path_sans_ext(basename(kmz_files[i]))
  
  # Assuming there's only one file extracted from the KMZ, you can get its full path
  extracted_file <- extracted_files[1]
  
  # Rename the extracted file to match the original file name and add .kml extension
  new_file_name <- paste0(dirname(extracted_file), "/", original_file_name, ".kml")
  
  # Rename the newly extracted .kml file
  file.rename(extracted_file, new_file_name)
}
