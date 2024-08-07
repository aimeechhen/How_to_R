library("xml2")
library("rvest")
library("dplyr")
library("terra")



#extract all links for each year
url_path <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/"
pg <- read_html(url_path)
linkys <- html_attr(html_nodes(pg, "a"), "href")

LINKS <- list()
for(i in 1:length(linkys)){
  link <- paste(url_path, linkys[i], sep = "")
  LINKS[i] <- link
}

LINKS <- do.call(rbind, LINKS)

#extract links for each file in each year
for(i in 42:length(LINKS)){
  url <- LINKS[i]
  pag <- read_html(url)
  ndvi_links <- paste(LINKS[i], html_attr(html_nodes(pag, "a"), "href"),  sep = "")
  filenames <- html_attr(html_nodes(pag, "a"), "href")
  
  for(j in 6:length(ndvi_links)){
    url_path <- ndvi_links[j]
    path <- paste("Canada/NDVI/NOAA_Files/",filenames[j], sep="")
    try(download.file(url_path, destfile = path))
  }
  
  Sys.sleep(5)
}

#test the files to see if they work
file1 <- "Canada/NDVI/NOAA_Files/AVHRR-Land_v005_AVH13C1_NOAA-07_19810624_c20170610041337.nc"
file2 <- "AVHRR-Land_v005_AVH13C1_NOAA-07_19810627_c20170610050500.nc"
NDVI <- terra::rast(file2)
plot(NDVI[[1]])


#----------------------------------------------------------------
#OUTDATED - files are corrupt


#extract all the names of the links from the parent directory
url.main <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/"
resource <- GET(url.main)
parse <- htmlParse(resource)
years <- xpathSApply(parse, path = "//a", xmlGetAttr, "href")

yearnames <- as.character(c(1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 
                            1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,
                            2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023))

#convert each name to a working link (separate by 1900s and 2000s due to structure of link names)
yearlinks1 <- sprintf("%s%s", url.main, sub("^.1*", "1", years[6:24]))
yearlinks2 <- sprintf("%s%s", url.main, sub("^.2*", "2", years[25:48]))
yearlinks <- c(yearlinks1, yearlinks2) 

#nested for loop to download all files for each year
for(i in 1:length(yearlinks)) {
  
  #output provides all links to files
  url <- yearlinks[i]
  res <- GET(url)
  pars <- htmlParse(res)
  daysfiles <- xpathSApply(pars, path = "//a", xmlGetAttr, "href")
  dayslinks <- sprintf("%s%s", url, sub("^.*AVHRR-Land", "AVHRR-Land", daysfiles))
  
  pg <- read_html(url)
  links <- html_attr(html_nodes(pg, "a"), "href")
  #Then identify and subset all of the links with ".nc" in the name
  filenames <- daysfiles[6:length(daysfiles)]
  LINK.nc <- dayslinks[12:length(dayslinks)]
  
  #download the files for each year
  for(j in 1:length(LINK.nc)) {
    
    download.file(LINK.nc[j], destfile = paste0("Canada/NDVI/NOAA_Files/",paste(filenames[i])))
  }
  
  Sys.sleep(2)  
  
}

file <- "Canada/NDVI/NOAA_Files/AVHRR-Land_v005_AVH13C1_NOAA-07_19810624_c20170610041337.nc"

testy <- terra::rast(file)

#test a single url to make sure it's working
url2 <- "https://www.ncei.noaa.gov/data/land-normalized-difference-vegetation-index/access/1981/AVHRR-Land_v005_AVH13C1_NOAA-07_19810625_c20170610042839.nc"

download.file(url2, destfile = "Canada/NDVI/AVHRR.files/AVHRR2.1981.nc")



