
#Import national park shapefiles and plot their boundaries

#main database: https://open.canada.ca/data/en/dataset/9e1507cd-f25c-4c64-995b-6563bf9d65bd
#selected "Download SHP (English) file through FTP" -> URL: #https://open.canada.ca/data/en/dataset/9e1507cd-f25c-4c64-995b-6563bf9d65bd/resource/2be1b18a-64ce-4be4-9dac-8a957a901ee5
#download files from URL: https://clss.nrcan-rncan.gc.ca/data-donnees/nplb_llpn/
#extract files in folder

library(sf)
bc <- st_read("data/NP_boundaries/CLAB_BC_2023-09-08/CLAB_BC_2023-09-08.shp")
st_layers("data/NP_boundaries/CLAB_BC_2023-09-08/CLAB_BC_2023-09-08.shp")
plot(bc)

# Choose one of the boundaries
koot <- bc[4, ]
plot(koot)

# Extract individual geometries
koot_geo <- st_geometry(koot)

# Plot only the first geometry (polygon) 
plot(koot_geo[1])

#..........................................................

library(raster)
shp <- shapefile("data/NP_boundaries/CLAB_BC_2023-09-08/CLAB_BC_2023-09-08.shp")
plot(shp)

#Identify which parks are in the shapefile
shp@data[["CLAB_ID"]]

#subset yoho shapefile out
yoho <- shp[shp$CLAB_ID == "YOHO", ]

#plot the specific park you want
plot(yoho)


