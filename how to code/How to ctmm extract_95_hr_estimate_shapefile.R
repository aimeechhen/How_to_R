



# how to save home range estimates

#............................................................
# Save home range estimates: shp files ----
#............................................................

# Save 95% home range estimate as shapefile:
# DF = "PMF" is not possible in a shp file, shp is only for points or boundaries
#Note: if you run into an error, update the ctmm package. writeShapefile() is no longer in use. Use writeVector(), package switched from the depreciated rgdal package to the terra package

dir.create("data/home_range/shp", recursive = TRUE)
for (name in names(AKDES)) {
  shp.path <- file.path("data/home_range/shp", paste0(name, ".shp"))
  writeVector(AKDES[[name]], shp.path, filetype="ESRI Shapefile",
              level.UD=0.95, level=0.95, overwrite = TRUE)
}

#............................................................
# Save population home range estimates: shp files ----
#............................................................

# Save 95% population home range estimate as shapefile:
dir.create("data/home_range/shp_pkde/pkde_a", recursive = TRUE)
writeVector(PKDE_A, "data/home_range/shp_pkde/pkde_a", 
            filetype="ESRI Shapefile", level.UD=0.95, level=0.95, overwrite = TRUE)






#______________________________________________________________
# extract raster 95 hr estimate
# 06a.load_merge_shapefiles_per_period.r ----

library(sf)
library(stringr)


# shp_path = paste0("./data/home_range", "/UDs_with_error")

#-------------------------------------------------------------------------------

#folder with UD
shp_path <- "./data/home_range/UDs_with_error"

#load UDs from that folder:
shp.dir = list.files(shp_path, pattern="*.shp$", all.files=TRUE, 
                     full.names=FALSE)

#read the shapefiles in
shps = lapply(shp.dir, st_read)

#change the directory back to the project directory
# getwd()
# setwd('../../../../')
# getwd()

period.shp = dplyr::bind_rows(shps)
period.shp = period.shp[str_detect(period.shp$name, "est"),]

period.shp = st_transform(period.shp, crs = st_crs('+init=EPSG:3005'))

st_crs(period.shp)
st_write(period.shp, dsn = './data/home_range/merged_95_HR', paste0(period, "_merged_95_HR_Albers_230619.shp"), 
         driver = 'ESRI Shapefile')

#EOF


shp_path = paste0("./data/home_range/", "/UDs_with_error")



#________________________________________________________________
# 06.extract.raster.95.hr.estimate.r ----


#Script to extract raster covariates and assign to each of the 95% HR polygons.

#For each period home range estimates for each animal were merged as single
#features into one shapefile for simplicity of extracting raster covariates

#using 'mean' as the function.

library(sf)
library(terra)
library(dplyr)
library(stringi)

#-------------------------------------------------------------------------------
#create a folder to hold temp files as they take up much HD space.
path = paste0(tempdir(),'//raster')
dir.create(path)

rm(list = ls())
gc()

#landscape
#rpath = "C:/Users/Ryan/OneDrive/ABMI/caribou_anthropause"

#original rasters
#elev = rast(paste0(rpath,'/spatial/dem/derived/cropped_20k/elev_20k.tif'))
#slope = rast(paste0(rpath,'/spatial/dem/derived/cropped_20k/slope_20k.tif'))
#proj.age = rast(paste0(rpath,'/spatial/dem/derived/cropped_20k/proj_age_AGE_20k.tif'))
#heli.ten = rast(paste0(rpath,'/spatial/dem/derived/cropped_20k/heli_tenures_20k.tif'))


#large extent to capture 2022  
elev = rast('data/habitat/rasters/elev_25m.tif')
dis_escape = raster('data/habitat/rasters/dist_escape_25m.tif')

scl.elev = scale(elev)
scl.slope = scale(slope)
scl.age = scale(proj.age)


rstack1 = c(elev, scl.elev, scl.slope, scl.age, heli.ten)

#-------------------------------------------------------------------------------




period = 'prior1'
#to get this next file I merged all HR shapes in QGIS for a given period.
#shapefiles were selected for the 95% HR estimate:
dat.shp = st_read(dsn = './data/home_range/merged_95_HR',
                  layer = paste0(period,'_merged_95_HR_Albers'))

#dat.shp = dat.shp[dat.shp$est == 'est',]

#all raster values:
dat.extract = extract(rstack1, dat.shp, fun = 'mean', bind = TRUE, na.rm = TRUE)

dat.df = as.data.frame(dat.extract)
dat.df$BINOMIAL = period
#dat.df$name = as.character(dat.df$layer)
#length(dat.df$name)
dat.df$ID = stri_sub(dat.df$name, from = 0, to = 5)
dat.cols = as.data.frame(colnames(dat.df))

dat.a = dat.df[,c("BINOMIAL","ID","elev_220809","slope_220809","proj_age_220809","heli_ten_220809")]

write.csv(dat.a, paste0('./data/home_range/',period,'/',period,'_covariates_95_230214.csv'), row.names = FALSE)
rm(dat.shp)
#-------------------------------------------------------------------------------
rm(list = ls())
gc()

#join all those files together:
p1 = read.csv("./data/home_range/prior1/prior1_covariates_95_230214.csv")
p2 = read.csv("./data/home_range/prior2/prior2_covariates_95_230214.csv")
po = read.csv("./data/home_range/after/after_covariates_95_230214.csv")
du = read.csv("./data/home_range/during/during_covariates_95_230214.csv")
results = read.csv('./data/home_range/Caribou_Results_with_Error_230213.csv')

dat.b = rbind(p1, p2, du, po)

#join spatial covariates with home range output:
dat.b$key = paste(dat.b$BINOMIAL, '-',dat.b$ID)
results$key = paste(results$BINOMIAL, '-', results$ID)
dat.c = merge(results, dat.b, by = 'key')
dat.c$period = dat.c$BINOMIAL

#clean up:
dat.c = dat.c %>%
  dplyr::rename('period' = 'BINOMIAL.x',
                'ID'= 'ID.x')

#drop columns
dat.c$key = dat.c$ID.y = dat.c$BINOMIAL.y = NULL

#get herd for each animal:
herd = read.csv('./data/input_data/herd.csv')
dat.d <- merge(dat.c, herd, by = "ID")

dat.d$Year = as.numeric(round(dat.d$Year,0))

#clean up one more time:
col.dat = as.data.frame(colnames(dat.d))
names(dat.d)
dat.d = dat.d[,c("ID","period","herd","Year","Lat","Long","Frequency","Duration",
                 "n","tau_p","tau_p_min","tau_p_max","tau_v","tau_v_min","tau_v_max",      
                 "diffusion","diffusion_min","diffusion_max","HR","HR_min","HR_max",
                 "Speed","Speed_min","Speed_max","elev_220809","slope_220809",
                 "proj_age_220809","heli_ten_220809")]

write.csv(dat.d, './data/home_range/Caribou_results_with_error_covariates_230214.csv', row.names = FALSE)

#EOF