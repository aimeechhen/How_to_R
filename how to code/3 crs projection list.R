

# Define the projection of a vector
proj4string(data) <- crs()

# Set crs
crs(x) <- crstype


#..........................................
# BC Albers projection ----

# NAD83 / BC Albers
# units = meters (see: https://spatialreference.org/ref/epsg/3005/)
bc_albers <- "ESRI:3005"
bc_albers <- "EPSG:3005"

library(bcmaps)
transform_bc_albers()


#..........................................
# Canada Albers Equal Area Conic projection ----

ca_albers <- "ESRI:102001"
ca_albers <- "EPSG:102001"


#..........................................
# Lat/long projection ----


# WGS 84 /
lat_long <- "+proj=longlat +datum=WGS84"
"+init=epsg:4326"
crs('EPSG:4326')
lat_long <-  "EPSG:4326"



#..........................................
# Wintri projection system ----

crs_wintri <- "ESRI:53018" 

epsg_53018 <- crs("+init=epsg:53018")

# Project the spatvector object to EPSG:53018
china_projected <- project(china, epsg_53018)

##..........................................
# projection in meter units ----

crs_meters <- "EPSG:32610"





#........................................
# other projection systems ----

# NAD 1983 UTM Zone 10N
"EPSG:26910"







#...........................................................
# NOAA GOES satellite crs (Maybe, need to double check, place holder for now)
goes_crs <- "PROJCRS[\"Geostationary_Satellite\", 
    BASEGEOGCRS[\"GRS 1980(IUGG)\", 
        DATUM[\"GRS 1980(IUGG)\", 
            ELLIPSOID[\"GRS80\", 6378137, 298.257222101]], 
        PRIMEM[\"Greenwich\", 0.0]], 
    CONVERSION[\"Geostationary Satellite (Sweep X)\", 
        METHOD[\"Geostationary Satellite (Sweep X)\", ID[\"EPSG\", 9838]], 
        PARAMETER[\"Longitude of natural origin\", -137.0], 
        PARAMETER[\"Satellite Height\", 35786023.0], 
        PARAMETER[\"False easting\", 0.0], 
        PARAMETER[\"False northing\", 0.0]], 
    CS[Cartesian, 2], 
        AXIS[\"(X)\", east], 
        AXIS[\"(Y)\", north], 
    USAGE[ 
        SCOPE[\"unknown\"], 
        AREA[\"World\"], 
        BBOX[-90, -180, 90, 180]]]"

# NOAA GOES satellite crs wkt
goes_wkt <- 'PROJCRS["Geostationary_Satellite",
    BASEGEOGCRS["GRS 1980",
        DATUM["GRS_1980",
            ELLIPSOID["GRS 1980",6378137,298.257222101]]],
    CONVERSION["Geostationary Satellite (Sweep X)",
        METHOD["Geostationary Satellite (Sweep X)", ID["EPSG", 9838]],
        PARAMETER["Longitude of natural origin",-137, ANGLEUNIT["degree",0.0174532925199433], ID["EPSG",8802]],
        PARAMETER["Satellite Height",35786023, LENGTHUNIT["metre",1], ID["EPSG",9001]],
        PARAMETER["False easting",0, LENGTHUNIT["metre",1], ID["EPSG",8806]],
        PARAMETER["False northing",0, LENGTHUNIT["metre",1], ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["(X)",east, ORDER[1], LENGTHUNIT["metre",1]],
        AXIS["(Y)",north, ORDER[2], LENGTHUNIT["metre",1]]]'
