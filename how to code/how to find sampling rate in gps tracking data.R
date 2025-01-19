
# how to find sampling rate in movement data (gps data)

library(amt)

# convert to track_xyz object (amt object)
df <- make_track(df, 
                     .x = longitude,             # x-coordinates (projected)
                     .y = latitude,             # y-coordinates (projected)
                     .t = timestamp,     # timestamp column in POSIXct format
                     crs = 4326,        # Assuming UTM Zone 10N (adjust if necessary)
                     all_cols = TRUE     # Retain all other columns
)

# subset to single animal
df <- df %>% 
  filter(goat_name == "kid_rock") %>% # subset to 1 animal
  arrange(t_) ## reorder in ascending order

summarize_sampling_rate(df) 