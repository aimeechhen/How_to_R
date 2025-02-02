# how to rmarkdown

# how to stop lines from overflow off the page
# https://stackoverflow.com/questions/69327328/r-markdown-to-pdf-causes-lines-to-overflow-off-page/69387188#69387188


# ---
# output: pdf_document
# header-includes:
#   - |
#     ```{=latex}
#     \usepackage{fvextra}
#     \DefineVerbatimEnvironment{Highlighting}{Verbatim}{
#       showspaces = false,
#       showtabs = false,
#       breaklines,
#       commandchars=\\\{\}
#     }
#     ```
# ---






#Rmarkdown themes ----

# Preview: https://rstudio4edu.github.io/rstudio4edu-book/rmd-themes.html#rmd-themes
# "bootstrap", "cerulean", "cosmo", "darkly", "flatly", "journal", "lumen", "paper", "readable", "sandstone", "simplex", "spacelab", "united", "yeti"



# https://fontawesome.com/icons