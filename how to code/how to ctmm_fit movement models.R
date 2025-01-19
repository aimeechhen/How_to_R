
library(ctmm)


#import the data
collar_data <- read.csv('./data/collar_data.csv')

#Convert to telemetry
goats <- as.telemetry(collar_data, mark.rm = TRUE)

#____________________________________________________________
# Fit movement models

FIT <- list()
for(i in 1:length(goats)){
  
  #Exctract individual
  DATA <- goats[[i]]
  
  # create guesstimate non-interactively
  GUESS <- ctmm.guess(DATA,CTMM=ctmm(error=FALSE),interactive=FALSE) # Error is off for now to speed up the process
  
  # fit models
  FIT[[i]] <- ctmm.select(DATA, GUESS, trace = 3, cores=-1)
  
}
#rename for convenience
names(FIT) <- names(goats)

#......................................
# extract summary details - various formats
#......................................

# Formats

# raw summary (SI units, everything is converted to uniform units
summary(FIT,units=FALSE)
# default summary (concise units) (default is units = TRUE, need not specify), the units will vary i.e. the 'concise' units
summary(FIT,units=TRUE)
# text-formatted summary
sigfig( summary(FIT)$CI )







#____________________________________________________________
# Estimate speed

#https://ctmm-initiative.github.io/ctmm/reference/speed.html

SPEED <- list()
SPEEDS <- list()
for(i in 1:length(goats)){
  #Extract individual
  DATA <- goats[[i]]
  FITS <- FIT[[i]]
  # estimate mean speed (may be a mix of OU and OUF, so using robust = true)
  SPEED[[i]] <- speed(FITS, DATA, robust = TRUE, units = FALSE, trace = TRUE)
  # estimate instantaneous speed
  SPEEDS[[i]] <- speed(FITS, DATA, robust = TRUE, units = FALSE, trace = TRUE)
  
}