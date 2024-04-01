
#............................................................
# Import raw gpx data ----
#............................................................

library(sf)
library(ctmm)
library(dplyr)

# check layers in the gpx file
st_layers("data/goat/GPS_Collar30548_20231005121804.gpx")

#import goat data using the "track_points" layer
goat_30548 <- st_read("data/goat/GPS_Collar30548_20231005121804.gpx", layer = 'track_points', quiet = TRUE)
#add coordinates to the dataframe
goat_30548 <- cbind(goat_30548, st_coordinates(goat_30548))
# add animal identifier with ctmm syntax
goat_30548$individual.local.identifier <- "goat_30548"

goat_30551 <- st_read("data/goat/GPS_Collar30551_20231005121822.gpx", layer = 'track_points', quiet = TRUE)
goat_30551 <- cbind(goat_30551, st_coordinates(goat_30551))
goat_30551$individual.local.identifier <- "goat_30551"

goat_30561 <- st_read("data/goat/GPS_Collar30561_20231005121846.gpx", layer = 'track_points', quiet = TRUE)
goat_30561 <- cbind(goat_30561, st_coordinates(goat_30561))
goat_30561$individual.local.identifier <- "goat_30561"

goat_30567 <- st_read("data/goat/GPS_Collar30567_20231005121907.gpx", layer = 'track_points', quiet = TRUE)
goat_30567 <- cbind(goat_30567, st_coordinates(goat_30567))
goat_30567$individual.local.identifier <- "goat_30567"

goat_30575 <- st_read("data/goat/GPS_Collar30575_20231005121926.gpx", layer = 'track_points', quiet = TRUE)
goat_30575 <- cbind(goat_30575, st_coordinates(goat_30575))
goat_30575$individual.local.identifier <- "goat_30575"

goat_30599 <- st_read("data/goat/GPS_Collar30599_20231005121948.gpx", layer = 'track_points', quiet = TRUE)
goat_30599 <- cbind(goat_30599, st_coordinates(goat_30599))
goat_30599$individual.local.identifier <- "goat_30599"

goat_30613 <- st_read("data/goat/GPS_Collar30613_20231005122000.gpx", layer = 'track_points', quiet = TRUE)
goat_30613 <- cbind(goat_30613, st_coordinates(goat_30613))
goat_30613$individual.local.identifier <- "goat_30613"

goat_30636 <- st_read("data/goat/GPS_Collar30636_20231005122013.gpx", layer = 'track_points', quiet = TRUE)
goat_30636 <- cbind(goat_30636, st_coordinates(goat_30636))
goat_30636$individual.local.identifier <- "goat_30636"

goat_30642 <- st_read("data/goat/GPS_Collar30642_20231005122030.gpx", layer = 'track_points', quiet = TRUE)
goat_30642 <- cbind(goat_30642, st_coordinates(goat_30642))
goat_30642$individual.local.identifier <- "goat_30642"

goat_30648 <- st_read("data/goat/GPS_Collar30648_20231005121711.gpx", layer = 'track_points', quiet = TRUE)
goat_30648 <- cbind(goat_30648, st_coordinates(goat_30648))
goat_30648$individual.local.identifier <- "goat_30648"

#combine imported data into a single dataframe
data_gps <- rbind(goat_30548,
                  goat_30551,
                  goat_30561,
                  goat_30567,
                  goat_30575,
                  goat_30599,
                  goat_30613,
                  goat_30636,
                  goat_30642,
                  goat_30648)

#clean up environment
rm(goat_30548,
   goat_30551,
   goat_30561,
   goat_30567,
   goat_30575,
   goat_30599,
   goat_30613,
   goat_30636,
   goat_30642,
   goat_30648)

#remove sf geometry column
data_gps <- st_drop_geometry(data_gps)

#rename columns
colnames(data_gps)[colnames(data_gps) == "X"] <- "location.long"
colnames(data_gps)[colnames(data_gps) == "Y"] <- "location.lat"
colnames(data_gps)[colnames(data_gps) == "time"] <- "timestamp"

#reorganize dataframe
data_gps <- relocate(data_gps, c(individual.local.identifier,
                                 timestamp,
                                 location.long,
                                 location.lat), .before = track_fid)

#visualization of fixes
plot(x = data_gps$location.long,
     y = data_gps$location.lat)

#identify fixes before the device was on the animal
sum(data_gps$location.long > 0)
sum(data_gps$location.long < 0)
#check the dates pre-collaring
data_gps$year_month <- format(data_gps$timestamp, "%Y-%m")
data_gps$date <- format(data_gps$timestamp, "%Y-%m-%d")
#how many fixes before the device was on the animal 
table(data_gps$year_month)["2018-08"]

#Remove fixes before the device was on the animal
data_gps[data_gps$location.long > 0,]
data_gps <- data_gps[data_gps$location.long < 0,]

#visualization of fixes
plot(x = data_gps$location.long,
     y = data_gps$location.lat)


#............................................................
# Individual gpx file configuration ----
#............................................................


library(sf)
library(ctmm)
library(dplyr)

goat_30548 <- st_read("data/goat/GPS_Collar30548_20231005121804.gpx", layer = 'track_points', quiet = TRUE)
goat_30551 <- st_read("data/goat/GPS_Collar30551_20231005121822.gpx", layer = 'track_points', quiet = TRUE)
goat_30561 <- st_read("data/goat/GPS_Collar30561_20231005121846.gpx", layer = 'track_points', quiet = TRUE)
goat_30567 <- st_read("data/goat/GPS_Collar30567_20231005121907.gpx", layer = 'track_points', quiet = TRUE)
goat_30575 <- st_read("data/goat/GPS_Collar30575_20231005121926.gpx", layer = 'track_points', quiet = TRUE)
goat_30599 <- st_read("data/goat/GPS_Collar30599_20231005121948.gpx", layer = 'track_points', quiet = TRUE)
goat_30613 <- st_read("data/goat/GPS_Collar30613_20231005122000.gpx", layer = 'track_points', quiet = TRUE)
goat_30636 <- st_read("data/goat/GPS_Collar30636_20231005122013.gpx", layer = 'track_points', quiet = TRUE)
goat_30642 <- st_read("data/goat/GPS_Collar30642_20231005122030.gpx", layer = 'track_points', quiet = TRUE)
goat_30648 <- st_read("data/goat/GPS_Collar30648_20231005121711.gpx", layer = 'track_points', quiet = TRUE)

#...........................................
# check layers in the gpx file
st_layers("data/goat/GPS_Collar30548_20231005121804.gpx")

#import goat data using the "track_points" layer
test_data <- st_read("data/goat/GPS_Collar30548_20231005121804.gpx", layer = 'track_points', quiet = TRUE)

#add coordinates to the dataframe
test_data <- cbind(test_data, st_coordinates(test_data))

# # add animal identifier with ctmm syntax
# test_data$individual.local.identifier <- "goat_"

#...........................................
# check layers in the gpx file
st_layers("data/goat/GPS_Collar30548_20231005121804.gpx")

#import goat data using the "track_points" layer
goat_30548 <- st_read("data/goat/GPS_Collar30548_20231005121804.gpx", layer = 'track_points', quiet = TRUE)
#add coordinates to the dataframe
goat_30548 <- cbind(goat_30548, st_coordinates(goat_30548))
# add animal identifier with ctmm syntax
goat_30548$individual.local.identifier <- "goat_30548"
#remove sf geometry column
goat_30548 <- st_drop_geometry(goat_30548)
#rename columns
colnames(goat_30548)[colnames(goat_30548) == "X"] <- "location.long"
colnames(goat_30548)[colnames(goat_30548) == "Y"] <- "location.lat"
colnames(goat_30548)[colnames(goat_30548) == "time"] <- "timestamp"

goat_30551 <- st_read("data/goat/GPS_Collar30551_20231005121822.gpx", layer = 'track_points', quiet = TRUE)
goat_30551 <- cbind(goat_30551, st_coordinates(goat_30551))
goat_30551$individual.local.identifier <- "goat_30551"
goat_30551 <- st_drop_geometry(goat_30551)
colnames(goat_30551)[colnames(goat_30551) == "X"] <- "location.long"
colnames(goat_30551)[colnames(goat_30551) == "Y"] <- "location.lat"
colnames(goat_30551)[colnames(goat_30551) == "time"] <- "timestamp"

goat_30561 <- st_read("data/goat/GPS_Collar30561_20231005121846.gpx", layer = 'track_points', quiet = TRUE)
goat_30561 <- cbind(goat_30561, st_coordinates(goat_30561))
goat_30561$individual.local.identifier <- "goat_30561"
goat_30561 <- st_drop_geometry(goat_30561)
colnames(goat_30561)[colnames(goat_30561) == "X"] <- "location.long"
colnames(goat_30561)[colnames(goat_30561) == "Y"] <- "location.lat"
colnames(goat_30561)[colnames(goat_30561) == "time"] <- "timestamp"

goat_30567 <- st_read("data/goat/GPS_Collar30567_20231005121907.gpx", layer = 'track_points', quiet = TRUE)
goat_30567 <- cbind(goat_30567, st_coordinates(goat_30567))
goat_30567$individual.local.identifier <- "goat_30567"
goat_30567 <- st_drop_geometry(goat_30567)
colnames(goat_30567)[colnames(goat_30567) == "X"] <- "location.long"
colnames(goat_30567)[colnames(goat_30567) == "Y"] <- "location.lat"
colnames(goat_30567)[colnames(goat_30567) == "time"] <- "timestamp"

goat_30575 <- st_read("data/goat/GPS_Collar30575_20231005121926.gpx", layer = 'track_points', quiet = TRUE)
goat_30575 <- cbind(goat_30575, st_coordinates(goat_30575))
goat_30575$individual.local.identifier <- "goat_30575"
goat_30575 <- st_drop_geometry(goat_30575)
colnames(goat_30575)[colnames(goat_30575) == "X"] <- "location.long"
colnames(goat_30575)[colnames(goat_30575) == "Y"] <- "location.lat"
colnames(goat_30575)[colnames(goat_30575) == "time"] <- "timestamp"

goat_30599 <- st_read("data/goat/GPS_Collar30599_20231005121948.gpx", layer = 'track_points', quiet = TRUE)
goat_30599 <- cbind(goat_30599, st_coordinates(goat_30599))
goat_30599$individual.local.identifier <- "goat_30599"
goat_30599 <- st_drop_geometry(goat_30599)
colnames(goat_30599)[colnames(goat_30599) == "X"] <- "location.long"
colnames(goat_30599)[colnames(goat_30599) == "Y"] <- "location.lat"
colnames(goat_30599)[colnames(goat_30599) == "time"] <- "timestamp"

goat_30613 <- st_read("data/goat/GPS_Collar30613_20231005122000.gpx", layer = 'track_points', quiet = TRUE)
goat_30613 <- cbind(goat_30613, st_coordinates(goat_30613))
goat_30613$individual.local.identifier <- "goat_30613"
goat_30613 <- st_drop_geometry(goat_30613)
colnames(goat_30613)[colnames(goat_30613) == "X"] <- "location.long"
colnames(goat_30613)[colnames(goat_30613) == "Y"] <- "location.lat"
colnames(goat_30613)[colnames(goat_30613) == "time"] <- "timestamp"

goat_30636 <- st_read("data/goat/GPS_Collar30636_20231005122013.gpx", layer = 'track_points', quiet = TRUE)
goat_30636 <- cbind(goat_30636, st_coordinates(goat_30636))
goat_30636$individual.local.identifier <- "goat_30636"
goat_30636 <- st_drop_geometry(goat_30636)
colnames(goat_30636)[colnames(goat_30636) == "X"] <- "location.long"
colnames(goat_30636)[colnames(goat_30636) == "Y"] <- "location.lat"
colnames(goat_30636)[colnames(goat_30636) == "time"] <- "timestamp"

goat_30642 <- st_read("data/goat/GPS_Collar30642_20231005122030.gpx", layer = 'track_points', quiet = TRUE)
goat_30642 <- cbind(goat_30642, st_coordinates(goat_30642))
goat_30642$individual.local.identifier <- "goat_30642"
goat_30642 <- st_drop_geometry(goat_30642)
colnames(goat_30642)[colnames(goat_30642) == "X"] <- "location.long"
colnames(goat_30642)[colnames(goat_30642) == "Y"] <- "location.lat"
colnames(goat_30642)[colnames(goat_30642) == "time"] <- "timestamp"

goat_30648 <- st_read("data/goat/GPS_Collar30648_20231005121711.gpx", layer = 'track_points', quiet = TRUE)
goat_30648 <- cbind(goat_30648, st_coordinates(goat_30648))
goat_30648$individual.local.identifier <- "goat_30648"
goat_30648 <- st_drop_geometry(goat_30648)
colnames(goat_30648)[colnames(goat_30648) == "X"] <- "location.long"
colnames(goat_30648)[colnames(goat_30648) == "Y"] <- "location.lat"
colnames(goat_30648)[colnames(goat_30648) == "time"] <- "timestamp"

DATA_gps <- rbind(goat_30548,
                  goat_30551,
                  goat_30561,
                  goat_30567,
                  goat_30575,
                  goat_30599,
                  goat_30613,
                  goat_30636,
                  goat_30642,
                  goat_30648)

# #remove sf geometry column
# DATA_gps <- st_drop_geometry(DATA_gps)
# 
# #rename columns
# colnames(DATA_gps)[colnames(DATA_gps) == "X"] <- "location.long"
# colnames(DATA_gps)[colnames(DATA_gps) == "Y"] <- "location.lat"
# colnames(DATA_gps)[colnames(DATA_gps) == "time"] <- "timestamp"

#reorganize dataframe
DATA_gps <- relocate(DATA_gps, c(individual.local.identifier,
                                 timestamp,
                                 location.long,
                                 location.lat), .before = track_fid)

#check coordinates, data points on x axis point far off
sum(goat_30599$location.long > 10)
sum(goat_30599$location.long < 10)
sum(goat_30548$location.long > 10)
sum(goat_30548$location.long < 10)
sum(goat_30551$location.long > 10)
sum(goat_30551$location.long < 10)
sum(DATA_gps$location.long > 10)
sum(DATA_gps$location.long < 10)
#looks like when the gps collars were tested or turned on for the first time prior to recording collared goats

#check the dates
DATA_gps$year_month <- format(DATA_gps$timestamp, "%Y-%m")
#how many recordings were there in August 2018 (assuming that was when the collars were first turned on)?
table(DATA_gps$year_month)["2018-08"]

#exclude the outliers with August 2018 dates
DATA_gps[DATA_gps$year_month == "2018-08",]
DATA_gps <- DATA_gps[DATA_gps$year_month != "2018-08",]