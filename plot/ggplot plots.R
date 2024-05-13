
library(ggplot2)
library(gridExtra) # Multi-panel plotting
library(khroma) # Colour palette that contains colour blind friendly colours, khroma palette -> https://cran.r-project.org/web/packages/khroma/vignettes/tol.html
muted <- colour("muted")






#__________________________________________________________________________
# GEOM functions ----

## bar plot, stacked ----
geom_bar(stat = "identity", position = "stack", fill = "red")
geom_hline(yintercept = 1, col = "grey70", linetype = "dashed") # add a horizontal line
geom_vline(xintercept = as.Date('2020-03-31'), color = "black", linewidth = 1, linetype = 2) + # start of covid
  
  
  
  #__________________________________________________________________________
  # ggplot scale ----

# change to 365 days on the x axis so its a full year
scale_x_continuous(limits = c(-2, 340), expand = c(0, 1), # so the plot extends a bit after december
                   breaks = seq(0, 365, by = 30),
                   labels = c(month.abb, ""))  # Use month abbreviations abbreviations
scale_x_continuous(limits = c(0,1), expand = c(0,0.02))
scale_y_continuous(limits = c(0,1))
scale_y_log10(expand = c(0,0.1))
guides(shape = FALSE, alpha = FALSE)        #remove legends for shape and alpha

scale_shape_manual(values = c(16, 17))      #manually assign shape
scale_alpha_manual(values = c(0.8,0.6))     #manually adjust colour transparency of the object
scale_fill_manual(values = c("#228833", "#de2d26", "#feb24c"), 
                  breaks = c('before', 'during', 'after'))
scale_colour_manual(values = c("#228833", "#de2d26", "#feb24c"), 
                    breaks = c('before', 'during', 'after'))

# use a blind color friendly palette
library(khroma)
khroma::scale_color_muted()
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
  
  plot.title = element_text(hjust = 0.5, size = 14, family = "sans", face = "bold"), #center title
  axis.title.y = element_text(size=10, family = "sans", face = "bold"),
  axis.title.x = element_text(size=10, family = "sans", face = "bold"),
  axis.text.y = element_text(size=8, family = "sans"),
  axis.text.x  = element_text(size=8, family = "sans"),
  axis.ticks = element_blank(),
  
  legend.position = c(0.5, 1.05), #manually set legend center and above plot (horizontal, vertical)
  legend.position = c(0.8, 0.9), #manually set position (horizontal, vertical)
  legend.position = "top",
  legend.position="none", #removes legend
  legend.justification = "center",
  legend.direction = "horizontal",
  legend.title = element_blank(), 
  legend.text = element_text(size=6, family = "sans", face = "bold"),
  legend.key.height = unit(0.3, "cm"),
  legend.key=element_blank(),
  legend.background = element_rect(fill = "transparent"),
  
  panel.background = element_rect(fill = "transparent"),
  panel.border = element_blank(), #plot boundary
  
  plot.background = element_rect(fill = "transparent", color = NA),
  plot.margin = unit(c(0.2,0.1,0.2,0.2), "cm"), #top, right, bot, left
  plot.margin = unit(c(0.75,0.5,0.25,0.25), "in"),
  
)


#__________________________________________________________________________
# multi-panel plotting ----

#use facet wrap
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
