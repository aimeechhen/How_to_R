
#Rekha, corrupted NOAA files workaround

#import data 
canada <- geoboundaries("Canada")

worldvi <- unique(list.files(path = 'Canada/NDVI/NOAA_Files/', 
                             pattern = ".nc", full.names = T))
sizes <- file.size(worldvi) / 1e6
hist(sizes, xlab = 'Approximate file size in MB')
worldvi[sizes < 50]
plot(rast(worldvi[sizes < 50][1]))

# check what files are corrupt ----
corrupt <- sapply(worldvi,
                  function(filename) {
                    .r <- tryCatch(rast(filename),
                                   error = function(e) return(as.character(e)))
                    return(is.character(.r))
                  }) %>%
  suppressWarnings()
corrupt
corrupt <- corrupt[which(corrupt)] # only keep TRUE values
corrupt

while(any(corrupt)) {
  # find file names
  files <- substr(x = names(corrupt),
                  start = nchar('Canada/NDVI/NOAA_Files//') + 1,
                  stop = nchar(names(corrupt)))
  
  years <- substr(files,
                  start = nchar(files) - nchar('yyyymmdd_cyyyymmddhhmmss.nc') + 1,
                  stop = nchar(files) - nchar('mmdd_cyyyymmddhhmmss.nc'))
  
  # re-download the corrupt NDVi rasters
  urls <- paste0('https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/',
                 years, '/', files)
  
  lapply(1:length(urls), function(.i){
    path <- paste0("Canada/NDVI/NOAA_Files/", files[.i])
    try(download.file(urls[.i], destfile = path))
  })
  
  # check again what files are corrupt
  corrupt <- sapply(names(corrupt),
                    function(filename) {
                      .r <- tryCatch(rast(filename),
                                     error = function(e) return(as.character(e)))
                      return(is.character(.r))
                    }) %>%
    suppressWarnings()
  corrupt <- corrupt[which(corrupt)] # only keep TRUE values
}