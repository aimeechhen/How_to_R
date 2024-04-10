
#BC Albers projection

# NAD83 / BC Albers
bc_albers <- "ESRI:3005"
bc_albers <- "EPSG:3005"

library(bcmaps)
transform_bc_albers()


#..........................................

# Canada Albers Equal Area Conic projection
ca_albers <- "ESRI:102001"
ca_albers <- "EPSG:102001"




#..........................................

# Lat/long
# WGS 84 /
"+proj=longlat +datum=WGS84"
#EPSG:4326

wgs84 <- "EPSG:4326"




#..........................................

#Wintri projection system
crs_wintri <- "ESRI:53018" 

epsg_53018 <- crs("+init=epsg:53018")

# Project the spatvector object to EPSG:53018
china_projected <- project(china, epsg_53018)



