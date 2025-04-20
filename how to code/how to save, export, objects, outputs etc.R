

# How to save objects, export stuff, etc.

#.............................................................
# saving files ----
#.............................................................

## csv ----
# save as csv if you are planning to view the file outside of R, for easy access without having to open and load the file/data
write.csv(x, file = "./path/to/folder/file.csv")
x <- read.csv(file = "./path/to/folder/file.csv")



#.........................................................
# rda 
# useful if you dont want to import the file and assign it to an object, it is read in and assigned to the object text string when you originally saved it
save(x, file = "./path/to/folder/file.rda")
load(file = "./path/to/folder/file.rda") # this will load into the environment as 'x'



#.........................................................
# rds
# if you are importing it in and needing to assign it to different object names depending on the scenario the file/data is being used
saveRDS(x, file = file = "./path/to/folder/file.rds")
abc <- readRDS(file = "./path/to/folder/file.rds") # object cannot be x as there might already be something named x in the environment, or it might be whale for one script and marine for another script

#.........................................................
## Save outputs into a textfile ----

sink() # export and save output of function, requires to terminate exportation process once completed 

#export and save summary output to a textfile
sink("data/home_range/m_hr_spring_summary.txt") # set up with file location and filename
#insert whatever you want to do here for that stuff to be recorded
print(summary(x))
cat("\n") #enter blank line
print(str(df))
cat("\n") #enter blank line
# etc
sink() #terminate output exporting connection/process (multiple functions can be exported)



