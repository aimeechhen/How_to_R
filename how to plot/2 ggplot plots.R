
library(ggplot2)
library(gridExtra) # Multi-panel plotting
library(khroma) # Colour palette that contains colour blind friendly colours, khroma palette -> https://cran.r-project.org/web/packages/khroma/vignettes/tol.html
muted <- colour("muted")

fill = NA
color = "white"



# Labelling
expression('Diffusion (m'^2*'/s)') # superscript
bquote('Diffusion (' * m^2 * '/s)') # superscript



#modify legend
labs(fill = "Elevation (m)") #title
guides(fill=guide_legend(title="New Legend Title"))
guides(col = guide_colourbar(title = "Some title"))




#__________________________________________________________________________
# GEOM functions ----

linewidth = 1.5 # line thickness
linetype = "dashed", "solid" #etc changes the line style

## bar plot, stacked ----
geom_bar(stat = "identity", position = "stack", fill = "red")
geom_hline(yintercept = 1, col = "grey70", linetype = "dashed") # add a horizontal line
geom_vline(xintercept = as.Date('2020-03-31'), color = "black", linewidth = 1, linetype = 2) + # start of covid
  
geom_sf(data= cathedral, fill = NA, size = 1.5) +
geom_sf(data = goes, color = "purple", fill = NA, size = 1.5) +
  
  
  # labels, titles
  ggtitle("A)") + 
  labs(tag = "x") + # tag = "x", used with ggtitle() to have additional labels
  
  
  
  #__________________________________________________________________________
  # ggplot scale ----

# date label codes
# month as MMM = %b

# set your axis range
limits = c(x,x) # c(to,from)
#set your axis alues breaks
breaks = seq(x,x, by = x) #seq(to,from,by=value you want the axis to be in sequenced in)


# change to 365 days on the x axis so its a full year
scale_x_continuous(limits = c(-2, 340), expand = c(0, 1), # so the plot extends a bit after december
                   breaks = c(0, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335), # Approximate month starts
                   breaks = seq(0, 365, by = 30), 
                   labels = c(month.abb, ""))  # Use month abbreviations
#to account for an extra month use c(month.abb, ""), if not, then use labels =  month.abb
scale_x_continuous(limits = c(0,1), expand = c(0,0.02))
scale_y_continuous(limits = c(0,1))
scale_y_continuous(labels = function(x) sprintf("%.1e", x))  # adjust scientific notation to contain a decimal point
scale_y_continuous(labels = function(x) parse(text = gsub("e", " %*% 10^", sprintf("%.1e", x))))  # scientific format
#format numbers in scientific notation with 10^n
scientific_10 <- function(x) {
  parse(text=gsub("e", " %*% 10^", scales::scientific_format()(x)))
}
#format numbers in scientific notation with one decimal
scientific_1 <- function(x) {
  parse(text = gsub("e", " %*% 10^", sprintf("%.1e", x)))
}
scale_y_continuous(name = expression("95% Home Range Area Estimate (km"^2*")")) # how to superscript axis title
scale_y_continuous(labels = scientific_10)
scale_y_continuous(labels = label_comma())
scale_y_continuous(labels = scales::label_number_si())
scale_y_continuous(labels = math_format())

scale_y_log10(expand = c(0,0.1))


scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 week",
             date_labels = "%b")
scale_x_date(date_breaks = "1 month", date_labels = "%m-%y") +



guides(shape = FALSE, alpha = FALSE)        #remove legends for shape and alpha

scale_shape_manual(values = c(16, 17))      #manually assign shape
scale_alpha_manual(values = c(0.8,0.6))     #manually adjust colour transparency of the object
scale_fill_manual(values = c("#228833", "#de2d26", "#feb24c"), 
                  breaks = c('before', 'during', 'after'))
scale_color_manual(values = c("#228833", "#de2d26", "#feb24c"), 
                    breaks = c('before', 'during', 'after'))

scale_color_manual(name = "Date", values = rainbow(length(unique(fire_data$date)))) +

# use a blind color friendly palette
library(khroma)
khroma::scale_color_muted()
khroma::scale_color_bright()
khroma::scale_fill_muted()
scale_color_muted(name = "National Parks", labels = c("Glacier","Kootenay","Revelstoke","Pacific Rim","Yoho"))

#__________________________________________________________________________
# ggplot themes ----

element_blank() #to remove

# change the panel background colour and transparency
panel.background = element_rect(scales::alpha("#005f73", 0.6))


theme_minimal()
theme_classic() #does not include gridlines by default
theme_bw()
theme_void() #Set a completely blank theme, to get rid of all background and axis elements
theme(
  panel.grid.major = element_blank(), #removes horizontal gridlines
  panel.grid.minor = element_blank(), #removes vertical gridlines
  

  axis.title.y = element_text(size=10, family = "sans", face = "bold"),
  axis.title.x = element_text(size=10, family = "sans", face = "bold"),
  axis.text.y = element_text(size=8, family = "sans"),
  axis.text.x  = element_text(size=8, family = "sans"),
  axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1), # vertical labels
  axis.ticks = element_blank(),
  
  # legend
  legend.position = "top",
  legend.direction = "horizontal",
  legend.justification = "center",
  legend.position="none", #removes legend
  legend.position = c(0.5, 1.05), #manually set legend center and above plot (horizontal, vertical)
  legend.position = c(0.8, 0.9), #manually set position (horizontal, vertical)
  legend.title = element_blank(), 
  legend.text = element_text(size=6, family = "sans", face = "bold"),
  legend.key.height = unit(0.3, "cm"),
  legend.key=element_blank(),
  legend.background = element_rect(fill = "transparent"),
  
  panel.background = element_rect(fill = "transparent"),
  panel.border = element_blank(), #plot boundary
  aspect.ratio = 1, # sets the ratio of height and width of the panel to be the same
  aspect.ratio = 2,  #  height 2x the width
  
  plot.title = element_text(hjust = 0.5, size = 14, family = "sans", face = "bold"), #center title
  plot.title = element_text(size = 12, family = "sans", face = "bold"),
  plot.tag = element_text(size = 16, family = "sans", face = "bold"), # used with labs(tag = "x")
  plot.tag.position = c(-0.12, 0.5), # horizontal, vertical
  plot.background = element_rect(fill = "transparent", color = NA),
  plot.margin = unit(c(0.2,0.1,0.2,0.2), "cm"), #top, right, bot, left
  plot.margin = unit(c(0.75,0.5,0.25,0.25), "in"), #top, right, bot, left
  

)


#__________________________________________________________________________
# multi-panel plotting ----

#use facet wrap
facet_wrap(~ ID,# sort by ID
           ncol = 2, nrow = 5,
           scales = "free_y", # only xaxis is fixed
           scales = "fixed") +  #set axis so theyre the same for every plot


#use gridExtra package
plot <- grid.arrange(plot1, plot2,
                     ncol=2)



#__________________________________________________________________________
# saving ggplots ---

ggsave(figure3b_encounters,
       file="figures/individual_figures/figure3b_encounters.png",
       width = 6.86, height = 3, units = "in", dpi = 600, bg = "transparent")

# if you do not want to assign the plot to a vector/object
ggsave(last_plot(),  file="figures/fig1.png",
       width = 6.86, height = 6, units = "in", dpi = 600, bg = "transparent")






#__________________________________________________________________________
# animate ggplots ---

library(gganimate)


enter_fade() +
  exit_fade()
enter_appear() +
  exit_disappear()
transition_time() #transitions are 'travelling' from one tile to the next.
#prevent the points from lingering or connecting, make them only visible for their time step
shadow_mark(past = FALSE, future = FALSE)

ease_aes('linear')



p <- 
  ggplot() +
  geom_sf(data = goes, aes(color = "red")) +
  geom_point(data = modis, aes(x = LONGITUDE, y = LATITUDE, color = "red", group = timestamp)) +
  geom_point(data = dat, aes(x = location.long, y = location.lat, group = timestamp), color = "blue") + 
  theme_bw() +
  labs(title = "modis, goes, collar", color = "Date")

# Animate the plot
p_animated <- p + 
  transition_time(date) +
  labs(title = "Date: {frame_time}") +
  theme(legend.position = "none") 


# Print the animated plot
print(p_animated)


# Set animation parameters to make it slower
animation <- animate(p_animated, nframes = length(unique(dat$date)) * 10, fps = 10)
print(animation)

nframes <- length(1950:max(ice$year)) + 10
animate(plt.world, duration = 30, nframes = nframes, end_pause = 10,
        width = 800, height = 800)




#__________________________________________________________________________
# CTMM package ----
# plot & rotate the study area plot where North is pointing up
projection(DATA_TELEMETRY) <- median(DATA_TELEMETRY)
plot(DATA_TELEMETRY,col=rainbow(length(DATA_TELEMETRY)))
title("All Anteaters")
compass()

# reproject 95% UDs to lat long and only keep estimates and drop CIs (Stefano)
AKDE_1_proj <- lapply(AKDE_1, function(.akde) {
  SpatialPolygonsDataFrame.UD(.akde) %>%
    st_as_sf() %>%
    st_transform('EPSG:4326')
}) %>%
  bind_rows() %>%
  filter(grepl('est', name)) %>%
  st_geometry()
