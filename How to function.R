


#_________________________________________________________________________
# How to import files ----

# Import all home-range PMF rasters in a folder
folder_path <- "data/home_range/UD"
hr_pmf_list <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)

# Import all the raster files into a list
pmf_rasters <- lapply(hr_pmf_list, rast)

# Extract file names without extension and assign names to the raster list
names(pmf_rasters) <- gsub("\\.tif$", "", basename(hr_pmf_list))


#_________________________________________________________________________
# How to extract text ----

#extract text before the first _ underscore (i.e. season)
dat.hr$season <- sub("^(.*?)_.*", "\\1", dat.hr$individual.local.identifier)
#extract text after the first _ underscore and before the second _ underscore (i.e. period)
dat.hr$period <- sub("^[^_]*_(.*?)_.*", "\\1", dat.hr$individual.local.identifier)
#extract text after the second _ underscore (i.e. collar_id)
dat.hr$collar_id <- sub("^(?:[^_]*_){2}(.*)", "\\1", dat.hr$individual.local.identifier)


# searches for string of text and extract information from 'individual.local.identifier' column and puts a string of text into a new column based on those conditions
rsf_coeff$season <- NA
rsf_coeff[grepl("spring", rsf_coeff$individual.local.identifier),"season"] <- "spring"
rsf_coeff[grepl("summer", rsf_coeff$individual.local.identifier),"season"] <- "summer"


#_________________________________________________________________________


# create new dataset based on making all the possible combinations
newd <- expand_grid(
  Time = seq(0, 21, length.out = 400),
  Diet = unique(ChickWeight$Diet), # since we are using fixed effects
  Chick = 'new chick') # since we are using random effects



#_________________________________________________________________________
# Save outputs into a textfile ----

#export and save summary output to a textfile
sink("data/home_range/m_hr_spring_summary.txt")
print(summary(m_hr_spring))
cat("\n") #enter blank line
# calculate the CI values
print("CI Values (lower, upper)")
# est + upper & lower z-score * std err
print(-0.1105 + c(-1.96,1.96) * 0.1670)
sink() #terminate output exporting connection/process (multiple functions can be exported)


