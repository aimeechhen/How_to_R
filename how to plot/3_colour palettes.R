
# how to plot

# https://www.databrewer.co/R/visualization/introduction

library(gridExtra) # Multi-panel plotting
library(cowplot)


#_____________________________________________________________________
# colour palettes


# base r 
palette()
barplot(x, col = rainbow(6), xlab="Rainbow colors", sub="rainbow(n)")
barplot(x, col = heat.colors(6), xlab="Yellow through red", sub="heat.colors(n)")
barplot(x, col = terrain.colors(6), xlab="Gray through green(n)", sub="terrain.colors(n)")
barplot(x, col = topo.colors(6), xlab="Purple through tan", sub="topo.colors(n)")
barplot(x, col = cm.colors(6), xlab="Pinks and blues", sub="cm.colors(n)")




#............................................................
library(viridis)
# https://www.databrewer.co/R/visualization/16-ggplot2-color-viridis-palette

scale_color_viridis_d() # categorical variable for discrete color legends
scale_color_viridis_c() #to generate continuous color bar
scale_color_viridis_b() # to create binned (stepwise) color scale

# extract hex codes
colors.20 <- viridis(20, option = "A")
colors.20
library(scales)
show_col(colors.20, cex_label = .6) # use 'cex_label' to set label size





#............................................................
library(RColorBrewer)
# https://www.datanovia.com/en/blog/the-a-z-of-rcolorbrewer-palette/
# https://ggplot2.tidyverse.org/reference/scale_brewer.html

# display top group: Sequential (continuous)
# display mid group: qualitative (categorical )
# display bot group: diverging (categorical -> range scale, focus on mid-range value with extremes at both end of the range)

display.brewer.all()
display.brewer.all(colorblindFriendly = TRUE)
# 1. Visualize a single RColorBrewer palette via palette name
display.brewer.pal(n, name)

# extract hex codes from palette
colors.9 <- brewer.pal(n = 9, name = "Set3")
colors.9
# visalise hex codes
library(scales)
show_col(colors.9)


#............................................................
library(khroma) 

# Colour palette that contains colour blind friendly colours, khroma palette -> https://cran.r-project.org/web/packages/khroma/vignettes/tol.html
muted <- colour("muted")
# https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3








