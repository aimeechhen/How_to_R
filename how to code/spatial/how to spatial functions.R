
#spatial carpentry

coordinates(layer) #see a layers coordinates
projection(layer) # see a layers projection


#____________________________________________________________________
# sp ----

library(sp)

is.projected() #sets/retrieves projection attributes on classes extending SpatialData
polygonFromExtent(x, sp = TRUE) #polygon from extent



#____________________________________________________________________
# sf ----

library(sf)

st_read()
st_as_sf()
st_crs() #retrieve coordinate reference system (crs)
st_write() #save general objects
write_sf() #save specialized/more complicated objects
st_geometry(df) <- NULL # remove geometry, coerce to data.frame
sf <- st_set_geometry(df, sfc) # set geometry, return sf, (sfc = simple feature geometry list column)
st_set_geometry(sf, NULL) # remove geometry, coerce to data.frame


#____________________________________________________________________
# raster ----

library(raster)

extent()
compareCRS()
crs()
projectRaster() #reproject crs
resample() #match extent, resolution
rasterize() #convert shapefile into a raster, (raster mask)
mask() #apply mask to raster
crop() #trim/cut raster
stack() #combine rasters
brick()
extract(raster, point) #extract raste values at points
intersectExtent() # set extents to overlap area



#____________________________________________________________________
# terra ----

library(terra)

crs() #get/set coordinate reference system (crs)
same.crs() #compare coordinate reference systems
ext(GOAT_HR)
project(GOAT_HR, "+proj=longlat +datum=WGS84")
scale() #scale/center raster data


c() #combine SpatRasters (multiple layers), note: must have the same extent & resolution
merge() #combine SpatRasters with different extents (but same origin and resolution)
mosaic() #combine SpatRasters with different extents using a function for overlapping cells
writeRaster() #write SpatRaster object to a file
add(x) <- value #add in place a SpatRaster to another SpatRaster object, comparable with c, but w/o copying object