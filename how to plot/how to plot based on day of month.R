
# how to plot data based on day of the month to see trends in the month across all months


library(ggplot2)
library(lubridate)

dat <- read.csv("data.csv")
dat$date = as.Date(dat$date, format = "%Y-%m-%d")

dat$dom <- as.numeric(day(dat$date))

plot(table(x = dat$dom))

dom_summary <- as.data.frame(table(dat$dom, dat$encounter_type))
colnames(dom_summary) <- c("dom", "encounter_type", "count")

ggplot(dom_summary, aes(x = dom, y = count, fill = encounter_type)) +
  geom_bar(stat = "identity") +
  xlab("day of month")

ggplot(dom_summary, aes(x = dom, y = count, color = encounter_type, group = encounter_type)) +
  geom_line(size = 1) +        
  geom_point(size = 3) +       
  labs(x = "Day of Month",      
       y = "Count")
