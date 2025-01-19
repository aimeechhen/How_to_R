

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