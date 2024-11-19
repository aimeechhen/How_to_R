
# NOAA NDVI data
#https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.ncdc:C01558


# 2018 data ----
# Set the URL
url_2018 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/2018/"

#~~~~~~~~~the files are accessed via manual click to download rather than automatic downloading from the url
library(rvest) #to extract weblinks to files
# Read the HTML content of the webpage
webpage <- read_html(url_2018)
# Extract the links to the files
file_links <- html_attr(html_nodes(webpage, "a"), "href")
# Filter the links to keep only the files you want to download
file_links <- file_links[grep(".nc", file_links)]
#~~~~~~~~~

# Set the download directory.
# dir.create("spatial/data/noaa_ndvi/2018")
output_dir <- "spatial/data/noaa_ndvi/2018"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop through the file links and download each file
for (file_link in file_links) {
  file_url <- paste0(url_2018, file_link)
  output_path <- file.path(output_dir, file_link)
  # Download the file
  download.file(file_url, destfile = output_path, mode = "wb")
  cat("Downloaded:", file_link, "\n")
}


#___________________________________________________________________
# 2019 data ----
# Set the URL
url_2019 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/2019/"

#~~~~~~~~~the files are accessed via manual click to download rather than automatic downloading from the url
library(rvest) #to extract weblinks to files
# Read the HTML content of the webpage
webpage <- read_html(url_2019)
# Extract the links to the files
file_links <- html_attr(html_nodes(webpage, "a"), "href")
# Filter the links to keep only the files you want to download
file_links <- file_links[grep(".nc", file_links)]
#~~~~~~~~~

# Set the download directory
# dir.create("spatial/data/noaa_ndvi/2019")
output_dir <- "spatial/data/noaa_ndvi/2019"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop through the file links and download each file
for (file_link in file_links) {
  output_path <- file.path(output_dir, file_link)
  
  # Check if the file already exists (because the server can timeout or R can crash and you have to restart)
  if (!file.exists(output_path)) {
    file_url <- paste0(url_2019, file_link)
    # Download the file
    download.file(file_url, destfile = output_path, mode = "wb")
    cat("Downloaded:", file_link, "\n")
  } else {
    cat("File already exists, skipping:", file_link, "\n")
  }
}




#___________________________________________________________________
# 2020 data ----
# Set the URL
url_2020 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/2020/"

#~~~~~~~~~the files are accessed via manual click to download rather than automatic downloading from the url
library(rvest) #to extract weblinks to files
# Read the HTML content of the webpage
webpage <- read_html(url_2020)
# Extract the links to the files
file_links <- html_attr(html_nodes(webpage, "a"), "href")
# Filter the links to keep only the files you want to download
file_links <- file_links[grep(".nc", file_links)]
#~~~~~~~~~

# Set the download directory
# dir.create("spatial/data/noaa_ndvi/2020")
output_dir <- "spatial/data/noaa_ndvi/2020"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop through the file links and download each file
for (file_link in file_links) {
  output_path <- file.path(output_dir, file_link)
  
  # Check if the file already exists (because the server can timeout or R can crash and you have to restart)
  if (!file.exists(output_path)) {
    file_url <- paste0(url_2020, file_link)
    # Download the file
    download.file(file_url, destfile = output_path, mode = "wb")
    cat("Downloaded:", file_link, "\n")
  } else {
    cat("File already exists, skipping:", file_link, "\n")
  }
}




#___________________________________________________________________
# 2021 data ----
# Set the URL
url_2021 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/2021/"

#~~~~~~~~~the files are accessed via manual click to download rather than automatic downloading from the url
library(rvest) #to extract weblinks to files
# Read the HTML content of the webpage
webpage <- read_html(url_2021)
# Extract the links to the files
file_links <- html_attr(html_nodes(webpage, "a"), "href")
# Filter the links to keep only the files you want to download
file_links <- file_links[grep(".nc", file_links)]
#~~~~~~~~~

# Set the download directory
# dir.create("spatial/data/noaa_ndvi/2021")
output_dir <- "spatial/data/noaa_ndvi/2021"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop through the file links and download each file
for (file_link in file_links) {
  output_path <- file.path(output_dir, file_link)
  
  # Check if the file already exists (because the server can timeout or R can crash and you have to restart)
  if (!file.exists(output_path)) {
    file_url <- paste0(url_2021, file_link)
    # Download the file
    download.file(file_url, destfile = output_path, mode = "wb")
    cat("Downloaded:", file_link, "\n")
  } else {
    cat("File already exists, skipping:", file_link, "\n")
  }
}



#___________________________________________________________________
# 2022 data ----
# Set the URL
url_2022 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/2022/"

#~~~~~~~~~the files are accessed via manual click to download rather than automatic downloading from the url
library(rvest) #to extract weblinks to files
# Read the HTML content of the webpage
webpage <- read_html(url_2022)
# Extract the links to the files
file_links <- html_attr(html_nodes(webpage, "a"), "href")
# Filter the links to keep only the files you want to download
file_links <- file_links[grep(".nc", file_links)]
#~~~~~~~~~

# Set the download directory
# dir.create("spatial/data/noaa_ndvi/2022")
output_dir <- "spatial/data/noaa_ndvi/2022"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop through the file links and download each file
for (file_link in file_links) {
  output_path <- file.path(output_dir, file_link)
  
  # Check if the file already exists (because the server can timeout or R can crash and you have to restart)
  if (!file.exists(output_path)) {
    file_url <- paste0(url_2022, file_link)
    # Download the file
    download.file(file_url, destfile = output_path, mode = "wb")
    cat("Downloaded:", file_link, "\n")
  } else {
    cat("File already exists, skipping:", file_link, "\n")
  }
}




#___________________________________________________________________
# 2023 data ----
# Set the URL
url_2023 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/2023/"

#~~~~~~~~~the files are accessed via manual click to download rather than automatic downloading from the url
library(rvest) #to extract weblinks to files
# Read the HTML content of the webpage
webpage <- read_html(url_2023)
# Extract the links to the files
file_links <- html_attr(html_nodes(webpage, "a"), "href")
# Filter the links to keep only the files you want to download
file_links <- file_links[grep(".nc", file_links)]
#~~~~~~~~~

# Set the download directory
# dir.create("spatial/data/noaa_ndvi/2023")
output_dir <- "spatial/data/noaa_ndvi/2023"

# Create the output directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Loop through the file links and download each file
for (file_link in file_links) {
  output_path <- file.path(output_dir, file_link)
  
  # Check if the file already exists (because the server can timeout or R can crash and you have to restart)
  if (!file.exists(output_path)) {
    file_url <- paste0(url_2023, file_link)
    # Download the file
    download.file(file_url, destfile = output_path, mode = "wb")
    cat("Downloaded:", file_link, "\n")
  } else {
    cat("File already exists, skipping:", file_link, "\n")
  }
}


