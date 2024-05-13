
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
