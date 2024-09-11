#https://stackoverflow.com/questions/69758242/export-command-history-in-rstudio


library(dplyr)
library(magrittr)
library(lubridate)
library(bit64)
library(stringr)

# Read the history database
lns <- readLines("C:/Users/achhen/AppData/Local/RStudio/history_database") %>% 
  str_split(pattern=":", n=2)

# Create a data frame with the history and formatted dates
hist_db <- data_frame(
  epoch = as.integer64(sapply(lns, "[[", 1)), 
  history = sapply(lns, "[[", 2)
)

hist_db %<>% 
  mutate(
    nice_date = as.POSIXct(as.numeric(epoch) / 1000, origin = "1970-01-01", tz = "PST8PDT"),
    day = ceiling_date(nice_date, unit = "day", change_on_boundary = FALSE) - days(1)
  ) %>%
  dplyr::select(-epoch)

# Get unique and sorted days
dd <- hist_db$day %>% unique %>% sort

# Generate a unique filename using the current date and time
timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
ff <- paste0("Rhistory_session_", timestamp, ".txt")

# Write history to the new file grouped by day
cat("R history", "\n", rep("-", 80), "\n", file=ff, sep="")

for(i in seq_along(dd)) {
  cat("\n\n", format(dd[i]), "\n", rep("-", 80), "\n", file=ff, sep="", append=TRUE)
  
  hist_db %>%
    filter(day == dd[i]) %>%
    dplyr::select(nice_date, history) %>%
    arrange(nice_date) %>%
    write.table(ff, sep="\t", quote=F, row.names=FALSE, col.names=FALSE, append=TRUE)
}

# Print the location of the saved file
cat("Rhistory saved as:", file.path(getwd(), ff), "\n")
