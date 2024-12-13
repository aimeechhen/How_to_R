
# data wrangling for reo


library(tidyr)

dat <- read.csv("C:/Users/achhen/Downloads/data2.csv")
#Split the column into multiple rows
df_expanded <- separate_rows(df, your_column, sep = ",")


#.................................................................
dat <- read.csv("C:/Users/achhen/Downloads/data2.csv")
# select objects that contains certain text and subset them into a new object
strictosidine <- dat[grepl("strictosidine", dat$ann_cro_2, ignore.case = TRUE), ]


#.................................................................
dat <- read.csv("C:/Users/achhen/Downloads/Ell.csv")
# i want to take values from other columns (i.e X.1, X.2) and move them into Ret.time and AuC column while keeping the same tissue type
# then repeat this for every row

# Create a new empty data frame
new_dat <- data.frame(Tissue = character(), 
                      Ret.time = numeric(), 
                      AuC = numeric(), 
                      stringsAsFactors = FALSE)

# Loop through all rows in dat
for (i in 1:nrow(dat)) {
  # Add first row
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = dat$Ret.time[i], 
                                       AuC = dat$AuC[i]))
  
  # Add rows for X.1 and X.2 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$X.1[i]), dat$X.1[i], NA), 
                                       AuC = ifelse(!is.na(dat$X.2[i]), dat$X.2[i], NA)))
  
  # Add rows for X.4 and X.5 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$X.4[i]), dat$X.4[i], NA), 
                                       AuC = ifelse(!is.na(dat$X.5[i]), dat$X.5[i], NA)))
}


#.................................................................

library(readxl)

# list all the sheet names in the excel file
excel_sheets("C:/Users/achhen/Downloads/Ellipticine profiling SIR 20241119.xlsx")


S25EO <- read_excel("C:/Users/achhen/Downloads/Ellipticine profiling SIR 20241119.xlsx",
                  sheet = 13)

dat <- S25EO
                  
# Create a new empty data frame
new_dat <- data.frame(Tissue = character(), 
                      Ret.time = numeric(), 
                      AuC = numeric(), 
                      stringsAsFactors = FALSE)



# Loop through all rows in dat
for (i in 1:nrow(dat)) {
  # Add first row
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = dat$`Ret time`[i], 
                                       AuC = dat$AuC[i]))
  
  # Add rows for X.1 and X.2 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$...5[i]), dat$...5[i], NA), 
                                       AuC = ifelse(!is.na(dat$...6[i]), dat$...6[i], NA)))
  
  # Add rows for X.4 and X.5 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$...8[i]), dat$...8[i], NA), 
                                       AuC = ifelse(!is.na(dat$...9[i]), dat$...9[i], NA)))
  
  # Add rows for X.4 and X.5 and extract those values into a new dataframe and bind it
  new_dat <- rbind(new_dat, data.frame(Tissue = dat$Tissue[i], 
                                       Ret.time = ifelse(!is.na(dat$...11[i]), dat$...11[i], NA), 
                                       AuC = ifelse(!is.na(dat$...12[i]), dat$...12[i], NA)))
}
