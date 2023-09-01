
#........installing for the first time run this chunk
#rstudio themes
#for base16 themes
install.packages("rstudioapi")
install.packages(
  "rsthemes",
  repos = c(gadenbuie = 'https://gadenbuie.r-universe.dev', getOption("repos"))
)
library("rstudioapi")
library("rsthemes")
rsthemes::install_rsthemes(include_base16 = TRUE)

#current theme:
oceanic_theme <- fs::path_temp("Oceanic-Eighties", ext = "rstheme")
download.file("https://git.io/rstudio-theme-oceanic-eighties", oceanic_theme)
rstudioapi::addTheme(oceanic_theme, apply = TRUE)

#to modify highlighted selected word colour
.ace_marker-layer .ace_selected-word {
  background: #0077BB;
}
    
#to modify selected line
.ace_marker-layer .ace_active-line {
  background: #000000;

#when you select a word, this highlights the matching word found through out script
    .ace_marker-layer .ace_selection {
      background: #004488;
    
    
"#007faa"
"#0077BB"
"#eecc66"
"#88ccee"
"#364B9A"
"#77AADD"
"#5385BC"
"#2166AC"
"#004488"

#.................end of chunk


#commands
rsthemes::list_rsthemes()
rsthemes::set_theme_light()


#other themes not part of the base16
rstudioapi::addTheme(
  tfse::github_raw("theme/driven-snow.rstheme", repo = "mkearney/driven-snow"),
  apply = FALSE
)

rstudioapi::applyTheme("a11y-light {rsthemes}")


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