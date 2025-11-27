
# base r plotting

#http://www.sthda.com/english/wiki/graphical-parameters

# base r palettes
palette()
barplot(x, col = rainbow(6), xlab="Rainbow colors", sub="rainbow(n)")
barplot(x, col = heat.colors(6), xlab="Yellow through red", sub="heat.colors(n)")
barplot(x, col = terrain.colors(6), xlab="Gray through green(n)", sub="terrain.colors(n)")
barplot(x, col = topo.colors(6), xlab="Purple through tan", sub="topo.colors(n)")
barplot(x, col = cm.colors(6), xlab="Pinks and blues", sub="cm.colors(n)")



#save plot
png(file = "figures/figure1.png", width = 6.86, height = 6, units = "in", res = 600)
par(mfrow=c(2,1))                    # plot arrangement
par(mgp = c(2, 0.5, 0))             #Adjust the third element (margin for axis title spacing)
par(mar = c(3, 3, 1.25, 0.25))      #margin defaults (order: bottom, left, top, and right)

plot(df, 
     col.DF = col_palette,        #ctmm::plot() argument: Color option for the density function. Can be an array. Note: may give you errors when trying to plot UD, use 'col.UD= '
     col.UD = col_palette,         #ctmm::plot() argument: Color option for UDs
     col.level = col_palette, 
     col.grid = NA, 
     col = rainbow(49),
     col = viridis(5), 
     cex = ,                  # shape size 
     las = 2,                 # rotate axis label 
     pch = ,                  # marker shape
     level = NA,
     lwd.level = 1,            #line thickness
     lwd = 3,                  #line thickness
     #font=2,                  #bold axis text
     font.lab = 2,             #bold axis labels
     adj = 0,                  #location of title (0 = left align)
     side = 2,                 # location of title wrt to the panel, 2 = left side of the plot
     cex.lab = 1,              #size of axis title
     cex.axis = 0.8,           #size of axis text font
     axes = FALSE,             #remove all axes
     ylab = "",                #remove y-axis label
     xlab = "",                #remove x-axis label
     yaxt="n",                 #remove y-axis text
     xaxt="n",                 #remove x-axis text
     main = "Title") #add title
title("C", adj = 0)

# modify axis titles, ensure you remove them first, see above
# xaxis: side = 1
# yaxis: side = 2
axis(side = 2, at = seq(0,9000,by = 1000)) #manually add axis tick labels 
axis(side = 2, las = 2) # Rotate the axis labels (title).
legend(legend = c("item1", "item2"))
abline(0,0, col = "red") 

#add another layer to the plot
plot(canada_wintri,
     col="white",              #fill
     border = "darkgrey",      #boundary colours
     lwd = 5,                  #line thickness (1 = default?)
     add = TRUE)               # Add another layer
dev.off()



#____________________________________________________
# ctmm package
plot(AKDE_1_reproj, 
     col.level = COL_1,
     col.UD=COL_1,             #change colours of UD utilization distribution
     col.grid = NA, 
     level = NA,
     lwd.level = 1,            #line thickness
     #font=2,                  #bold axis text
     cex.lab = 1,              #size of axis title
     cex.axis = 0.8,           #size of axis text font
     font.lab = 2)             #bold axis labels
title("C", adj = 0)