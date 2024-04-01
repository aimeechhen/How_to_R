
library(ggplot2)
library(gridExtra) # Multi-panel plotting
library(khroma) # Colour palette that contains colour blind friendly colours

#__________________________________________________________________________
# GEOM functions ----

## bar plot, stacked ----
geom_bar(stat = "identity", position = "stack", fill = "red")



#__________________________________________________________________________
# ggplot scale ----

# change to 365 days on the x axis so its a full year
scale_x_continuous(limits = c(-2, 340), expand = c(0, 1), # so the plot extends a bit after december
                   breaks = seq(0, 365, by = 30),
                   labels = c(month.abb, "")) +  # Use month abbreviations abbreviations
guides(shape = FALSE, alpha = FALSE)        #remove legends for shape and alpha

scale_shape_manual(values = c(16, 17))      #manually assign shape
scale_alpha_manual(values = c(0.8,0.6))     #manually adjust colour transparency of the object
scale_fill_manual(values = c("#228833", "#de2d26", "#feb24c"), 
                  breaks = c('before', 'during', 'after'))
scale_colour_manual(values = c("#228833", "#de2d26", "#feb24c"), 
                    breaks = c('before', 'during', 'after'))

# use a blind color friendly palette
library(khroma)
khroma::scale_color_muted() +
khroma::scale_fill_muted()

#__________________________________________________________________________
# ggplot themes ----

element_blank() #to remove

# change the panel background colour and transparency
panel.background = element_rect(scales::alpha("#005f73", 0.6))


theme_minimal() +
theme_bw() +
  
  theme(
    #remove gridlines
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    
    plot.title = element_text(hjust = 0.5, size = 14, family = "sans", face = "bold"), #center title
    axis.title.y = element_text(size=10, family = "sans", face = "bold"),
    axis.title.x = element_text(size=10, family = "sans", face = "bold"),
    axis.text.y = element_text(size=8, family = "sans"),
    axis.text.x  = element_text(size=8, family = "sans"),
    
    legend.position = c(0.5, 1.05), #manually set legend center and above plot (horizontal, vertical)
    legend.position = c(0.8, 0.9), #manually set position (horizontal, vertical)
    legend.position = "top",
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
    plot.margin = unit(c(0.2,0.1,0.2,0.2), "cm")) #top, right, bot, left



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
last_plot()
