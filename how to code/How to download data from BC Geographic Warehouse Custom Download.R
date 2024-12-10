

#BC Geographic Warehouse Custom Download
#Select 'Access/Download'
#Enter order details:
#Coordinate System = BC Albers (m)
#Format = ArcView Shape (if you want .shp file, CSV doesn't give you want you want, i.e. geometries, coordinates etc.)
#Area of Interest = None
#Submit and then download via link that is sent to your email address
#Extract zip file to get .shp file





library(bcdata)
# https://catalogue.data.gov.bc.ca/

# extract information on the data
bcdc_query_geodata("x") # insert object name from data catalogue
bcdc_query_geodata("WHSE_LAND_AND_NATURAL_RESOURCE.PROT_HISTORICAL_INCIDENTS_SP")

# download the data
bc_data <- bcdc_query_geodata("x") %>% 
  collect()

bcdc_get_citation("url")




