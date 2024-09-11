
library(sf)
library(ctmm)

test <- read_sf("~/Downloads/GPS_Collar30548_20230724150825.kml")

test2 <- data.frame(id = sub(" - Fix.*", "", sub(".*Collar ", "", gsub("<(.|\n)*?>","",test$Description))),
                    date = sub("   Time.*", "", sub(".*Date: ", "", gsub("<(.|\n)*?>","",test$Description))),
                    time = sub("   Altitude.*", "", sub(".*Time: ", "", gsub("<(.|\n)*?>","",test$Description))),
                    long = st_coordinates(test)[,1],
                    lat = st_coordinates(test)[,2],
                    altitude = sub("   Status:.*", "", sub(".*Altitude: ", "", gsub("<(.|\n)*?>","",test$Description))),
                    DOP = sub("   Sats.*", "", sub(".*DOP: ", "", gsub("<(.|\n)*?>","",test$Description))),
                    temperature = sub("&deg;C  .*", "", sub(".*Temperature: ", "", gsub("<(.|\n)*?>","",test$Description))))

test2$timestamp <- paste(test2$date, test2$time)

test3 <- as.telemetry(test2)

plot(test3)