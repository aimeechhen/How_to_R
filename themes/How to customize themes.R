
#folder location
#C:\Users\Pokedex\AppData\Roaming\RStudio\themes

# Apply current theme from github repo (local and websource method)
library("rstudioapi")
rstudioapi::addTheme("C:/Users/windows95/OneDrive - UBC/Github/How_to_R/themes/current_rstheme.rstheme", apply = TRUE)
# rstudioapi::addTheme("https://github.com/aimeechhen/How_to_R/blob/main/themes/current_rstheme.rstheme", apply = TRUE)


# How to customize themes
#https://docs.posit.co/ide/user/ide/guide/ui/appearance.html
#https://github.com/gadenbuie/rsthemes

# How to create a new theme for RStudio (CSS format)
#https://rstudio.github.io/rstudio-extensions/rstudio-theme-creation.html#creating-a-tmtheme
#create a tmTheme and import it to RStudio (When a tmTheme is added to RStudio, it is converted to an rstheme before it is saved locally)

# tmTheme editor
#https://tmtheme-editor.glitch.me/
#can modify the available themes and then save it on your local computer to use and continue modifying it later

# Installation
install.packages("rstudioapi")

#Base 16 themes R package
install.packages("rsthemes",
                 repos = c(gadenbuie = 'https://gadenbuie.r-universe.dev', getOption("repos")))

#Load packages
library("rstudioapi")
library("rsthemes")

#Add themes
rstudioapi::addTheme("https://raw.githubusercontent.com/batpigandme/night-owlish/master/rstheme/night-owlish.rstheme", apply = TRUE)


#Install 109 themes from the Base 16 package
rsthemes::install_rsthemes(include_base16 = TRUE)

#list installed themes
rsthemes::list_rsthemes()

#try all installed themes
rsthemes::try_rsthemes()

#how to apply the theme via code and not via global options within RStudio (very handy when changing single items to test)
#refer to the "rs-theme-name" as the object in the script
rstudioapi::applyTheme("base16 3024 {rsthemes}")
rstudioapi::applyTheme("Oceanic - Eighties")
rstudioapi::applyTheme("Testing_rstheme")

#To cycle through all the themes, enter the following letters
# [n] or [ ] (empty) to try the next theme
# [k] to keep that theme
# [f] to favorite that theme
# [q] to quit and restore your original theme

#switch the theme light/dark setting
rsthemes::set_theme_light()
rsthemes::set_theme_dark()

#Add your favourite themes to your .Rprofile
#Located here "C:/Users/Username/Documents/.Rprofile"

# current favourite themes for font colours (as of 2023-10-23)
#to cycle through your favorite themes
rsthemes::use_theme_favorite()

if (interactive() && requireNamespace("rsthemes", quietly = TRUE)) {
  rsthemes::set_theme_favorite(c(
    "a11y-dark {rsthemes}", 
    "a11y-light {rsthemes}", 
    "base16 3024 {rsthemes}",
    "base16 Brewer {rsthemes}", 
    "base16 Bright {rsthemes}",
    "base16 Chalk {rsthemes}", 
    "base16 Default Dark {rsthemes}",
    "base16 Default Light {rsthemes}", 
    "base16 Eighties {rsthemes}",
    "base16 Flat {rsthemes}", 
    "base16 Google Dark {rsthemes}",
    "base16 Google Light {rsthemes}", 
    "base16 Hopscotch {rsthemes}",
    "base16 IR Black {rsthemes}", 
    "base16 London Tube {rsthemes}",
    "base16 Materia {rsthemes}", 
    "base16 OceanicNext {rsthemes}",
    "base16 OneDark {rsthemes}", 
    "base16 Paraiso {rsthemes}",
    "base16 PhD {rsthemes}", 
    "base16 Pop {rsthemes}",
    "base16 Railscasts {rsthemes}", 
    "base16 Solar Flare {rsthemes}",
    "base16 Tomorrow Night {rsthemes}", 
    "base16 Tomorrow {rsthemes}",
    "Oceanic Plus {rsthemes}"
  ))
}

#how to apply the theme via code and not via global options within RStudio
rstudioapi::applyTheme()

#............................................................

#https://raw.githubusercontent.com/memco/Oceanic-tmTheme/master/Themes/Oceanic%20-%20Eighties.tmTheme

#https://raw.githubusercontent.com/idleberg/3024.tmTheme/master/3024%20Night.tmTheme

# Current rstheme
#using a modified version of:
oceanic_eighties <- fs::path_temp("Oceanic-Eighties", ext = "rstheme")
download.file("https://git.io/rstudio-theme-oceanic-eighties", oceanic_eighties)
rstudioapi::addTheme(oceanic_eighties, apply = TRUE)






#......................................................


# Apply the theme
rstudioapi::applyTheme("path/to/my-light-theme.rstheme")









#............................................................

# Modifications of Selectors

#when you select a word, this highlights the matching word found through out script
.ace_marker-layer .ace_selection {
  background: #0077BB;
}

#to modify selected line
.ace_marker-layer .ace_active-line {
  background: #f0f0f0;
}
#color of the word highlighted/selected
.ace_marker-layer .ace_selected-word {
  background: #004488;
}

#............................................................

# current colour palette
'#0077BB' # .ace_selection
'#f0f0f0' # .ace_active
'#004488' # .ace_selected

# colour blind palette
'#0570B0' # .ace_selection
'#F7FBFF' # .ace_active
'#084081' # .ace_selected


# Colour samples

# colour blind friendly
"#A50026" "#D73027" "#F46D43" "#FDAE61" "#FEE090" "#FFFFBF" "#E0F3F8" "#ABD9E9" "#74ADD1" "#4575B4" "#313695"
"#FFFFD9" "#EDF8B1" "#C7E9B4" "#7FCDBB" "#41B6C4" "#1D91C0" "#225EA8" "#253494" "#081D58"
"#F7FBFF" "#DEEBF7" "#C6DBEF" "#9ECAE1" "#6BAED6" "#4292C6" "#2171B5" "#08519C" "#08306B"
"#FFF7FB" "#ECE2F0" "#D0D1E6" "#A6BDDB" "#67A9CF" "#3690C0" "#02818A" "#016C59" "#014636"
"#FFF7FB" "#ECE7F2" "#D0D1E6" "#A6BDDB" "#74A9CF" "#3690C0" "#0570B0" "#045A8D" "#023858"
"#F7FCF0" "#E0F3DB" "#CCEBC5" "#A8DDB5" "#7BCCC4" "#4EB3D3" "#2B8CBE" "#0868AC" "#084081"





#............................................................

# Additional rsthemes not part of the base16

#other themes 
rstudioapi::addTheme(
  tfse::github_raw("theme/driven-snow.rstheme", repo = "mkearney/driven-snow"),
  apply = FALSE
)

