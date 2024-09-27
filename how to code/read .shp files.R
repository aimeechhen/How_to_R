
# read .shp files

#____________________________________________________________________
# 06a.load_merge_shapefiles_per_period.r

# Import 95% home range estimate shapefiles (NOTE: NOT USING 'DF = "PMF"' values)

# Set folder path containing the exported subfolders
folder_path <- "data/home_range/shp"

# Load .shp files from subfolders
shp.dir <- list.files(path = folder_path, pattern = "\\.shp$", recursive = TRUE, full.names = TRUE)

#Read each shapefile into a list
shp.files <- lapply(shp.dir, st_read)
names(shp.files) <- names(AKDES)

# Combine all the shapefiles into a single sf object
#hr.shp = dplyr::bind_rows(shp.files)
hr.shp <- do.call(rbind, shp.files)

# Subset 95% est shapefiles only based on the text "95% est"
library(stringr)
hr.shp <- hr.shp[str_detect(hr.shp$name, "est"),]
# hr.shp <- hr.shp[grepl("95% est", hr.shp$name), ]
rownames(hr.shp) <- NULL

hr.shp = st_transform(hr.shp, crs = st_crs("+proj=longlat +datum=WGS84"))
st_crs(hr.shp)

#save shapefile
st_write(hr.shp, dsn = 'data/home_range/95_HR_estimate', 
         driver = 'ESRI Shapefile', append=FALSE)

# hr.shp <- st_read('data/home_range/95_HR_estimate/95_HR_estimate.shp')