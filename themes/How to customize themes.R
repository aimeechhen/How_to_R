
#folder location
#C:\Users\Pokedex\AppData\Roaming\RStudio\themes

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

#Add your favorite themes to your .Rprofile
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

#............................................................

# Modifications of Selectors

#when you select a word, this highlights the matching word found through out script
.ace_marker-layer .ace_selection {
  background: #004488;

#to modify selected line
.ace_marker-layer .ace_active-line {
  background: #000000;

    #color of the word highlighted/selected
    .ace_marker-layer .ace_selected-word {
      background: #0077BB;
    }
    
#............................................................
    
# Colour samples
#Blue       
"#007faa"
"#0077BB"
"#88ccee"
"#364B9A"
"#77AADD"
"#5385BC"
"#2166AC"
"#004488"

#Yellow
"#eecc66"

#............................................................

# Additional rsthemes not part of the base16

#other themes 
rstudioapi::addTheme(
  tfse::github_raw("theme/driven-snow.rstheme", repo = "mkearney/driven-snow"),
  apply = FALSE
)

#............................................................

#zotero plug in
install.packages("citr")
devtools::install_github("crsh/citr", force = TRUE)
install.packages("rbbt")


### need to fix intstructions!!!!
#zotero citation styles using Rmarkdown
download.file("https://www.zotero.org/styles/ecology?source=1", destfile = "C:/Users/achhen/OneDrive - UBC/How to R/zotero citation styles/ecology.csl")

#search styles here
# https://www.zotero.org/styles
#download the csl from the website and put it in the folder for rmarkdown to retrieve
# click on source beside the style type, copy that url
# in YAML section of Rmarkdown put:
# csl: ecology.csl