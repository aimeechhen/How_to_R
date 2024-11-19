
library(ctmm)


#import the data
collar_data <- read.csv('./data/collar_data.csv')

#Convert to telemetry
goats <- as.telemetry(collar_data, mark.rm = TRUE)

#____________________________________________________________
# Fit movement models

FITS <- list()
for(i in 1:length(goats)){
  
  #Exctract individual
  DATA <- goats[[i]]
  
  # create guesstimate non-interactively
  GUESS <- ctmm.guess(DATA,CTMM=ctmm(error=FALSE),interactive=FALSE) # Error is off for now to speed up the process
  
  # fit models
  FITS[[i]] <- ctmm.select(DATA, GUESS, trace = 3, cores=-1)
  
}
#rename for convenience
names(FITS) <- names(goats)




#____________________________________________________________
# Estimate speed

#https://ctmm-initiative.github.io/ctmm/reference/speed.html

SPEED <- list()
SPEEDS <- list()
for(i in 1:length(goats)){
  #Extract individual
  DATA <- goats[[i]]
  FIT <- FITS[[i]]
  # estimate mean speed (may be a mix of OU and OUF, so using robust = true)
  SPEED[[i]] <- speed(FIT, DATA, robust = TRUE, units = FALSE, trace = TRUE)
  # estimate instantaneous speed
  SPEEDS[[i]] <- speed(FIT, DATA, robust = TRUE, units = FALSE, trace = TRUE)
  
}