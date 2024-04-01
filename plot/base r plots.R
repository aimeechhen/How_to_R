
# base r plotting

png(file = "figures/individual figures/figure2_right_overlap.png", width = 2.86, height = 6, units = "in", res = 600)
par(mfrow=c(2,1))
par(mgp = c(2, 0.5, 0))             #Adjust the third element (margin for axis title spacing)
par(mar = c(3, 3, 1.25, 0.25))      #margin defaults (order: bottom, left, top, and right)
plot(AKDE_1, 
     col.DF = COL_1, 
     col.level = COL_1, 
     col.grid = NA, 
     level = NA,
     lwd.level = 1,            #line thickness
     #font=2,                  #bold axis text
     cex.lab = 1,              #size of axis title
     cex.axis = 0.8,           #size of axis text font
     axes = FALSE,             #remove all axes
     ylab = "",                #remove y-axis label
     xlab = "",                #remove x-axis label
     yaxt="n",                 #remove y-axis text
     xaxt="n",                 #remove x-axis text
     font.lab = 2)             #bold axis labels
title("C", adj = 0)
plot(canada_wintri,
     col="white",              #fill
     border = "darkgrey",      #boundary colours
     lwd = 5,                  #line thickness (1 = default?)
     add = TRUE)               # Add another layer
dev.off()