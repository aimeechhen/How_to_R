
#raster carpentry
library(sp)
is.projected() #sets/retrieves projection attributes on classes extending SpatialData


library(sf)
st_crs() #retrieve coordinate reference system (crs)
st_write() #save general objects
write_sf() #save specialized/more complicated objects
st_geometry(df) <- NULL # remove geometry, coerce to data.frame
sf <- st_set_geometry(df, sfc) # set geometry, return sf, (sfc = simple feature geometry list column)
st_set_geometry(sf, NULL) # remove geometry, coerce to data.frame




library(raster)
extent()
compareCRS()
projectRaster() #reproject crs
resample() #match extent, resolution





library(terra)
crs() #get/set coordinate reference system (crs)
same.crs() #compare coordinate reference systems
ext(GOAT_HR)
project(GOAT_HR, "+proj=longlat +datum=WGS84")
c() #combine SpatRasters (multiple layers), note: must have the same extent & resolution
merge() #combine SpatRasters with different extents (but same origin and resolution)
mosaic() #combine SpatRasters with different extents using a function for overlapping cells
writeRaster() #write SpatRaster object to a file
add(x) <- value #add in place a SpatRaster to another SpatRaster object, comparable with c, but w/o copying object