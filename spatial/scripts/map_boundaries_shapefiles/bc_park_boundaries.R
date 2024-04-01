
#2024-02-13
#Download BC provincial park shapefiles
#https://catalogue.data.gov.bc.ca/dataset/parks-and-protected-areas-regional-boundaries

#BC Geographic Warehouse Custom Download
#Select 'Access/Download'
#Enter order details:
#Coordinate System = BC Albers (m)
#Format = ArcView Shape (if you want .shp file, CSV doesn't give you want you want, i.e. geometries, coordinates etc.)
#Area of Interest = None
#Submit and then download via link that is sent to your email address
#Extract zip file to get .shp file


#..................................................................
# AS A SF OBJECT
#..................................................................

library(sf)

#Provincial park polygons
bc_park <- st_read("data/prov_park/TA_PARK_ECORES_PA_SVW/TA_PEP_SVW_polygon.shp")
#check layers in shp file
st_layers("data/prov_park/TA_PARK_ECORES_PA_SVW/TA_PEP_SVW_polygon.shp")

# Choose one of the boundaries, View(park) to see park listing)
cathedral <- bc_park[bc_park$PROT_NAME == "CATHEDRAL PARK", ] #row 95
plot(cathedral)

# Extract individual geometries
cathedral_geo <- st_geometry(cathedral)

# Select a geometry (polygon)
cathedral_geo <- cathedral_geo[1]

# Plot park shapefile
plot(cathedral_geo)



#..................................................................
# AS A RASTER
#..................................................................

library(raster)
shp <- shapefile("data/NP_boundaries/CLAB_AB_2023-09-08/CLAB_AB_2023-09-08.shp")
plot(shp)

#Identify which parks are in the shapefile
shp@data[["PROT_NAME"]]

#subset yoho shapefile out
cathedral <- shp[shp$PROT_NAME == "CATHEDRAL PARK", ]

#plot the specific park you want
plot(cathedral)







#.........................................................

#Park Region polygons
bc_region <- st_read("data/prov_park/ADM_BC_PARKS_REGIONS_SP/PARK_REG_polygon.shp")

# Choose one of the boundaries, View(park) to see park listing)
# Kootenay Okanagan region
park_region <- bc_region[2, ]
plot(park_region)

# Extract individual geometries
park_region_geo <- st_geometry(park_region)

# Select a geometry (polygon)
park_region_geo <- region_geo[1]

# Plot park shapefile
plot(park_region_geo)


#........

#Plot both region and park
plot(park_region_geo)
plot(cathedral_geo, add = TRUE)