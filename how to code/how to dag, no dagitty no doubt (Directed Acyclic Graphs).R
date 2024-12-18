
# how to dag (Directed Acyclic Graphs)
# no dagitty no doubt

# https://cran.r-project.org/web/packages/ggdag/vignettes/intro-to-dags.html

# for fancy version of dagitty https://www.rdocumentation.org/packages/rethinking/versions/2.13/topics/drawdag
# alternative https://rpubs.com/kaz_yos/dagR
# if you want a tutorial https://lfoswald.github.io/2021-spring-stats2/materials/session-3/03-online-tutorial/

library(dagitty)
library(ggdag)





















#___________________________________________________________________________________________________

# From Stefano (refer to 'appendix-C-empirical-modeling (Stefano) for dags.rmd' script for more details)
# causal Directed Acyclical Graph (DAG) 
dagify(NDVI ~ S,
       EN ~ NDVI + E,
       VN ~ NDVI + V,
       E ~ R,
       V ~ R,
       Z ~ E + V,
       S ~ R,
       H ~ E + V + Z,
       outcome = 'H',
       labels = c(H = 'H', R = 'R', E = 'E(R)', V = 'Var(R)', S = 'S',
                  Z = 'Z', NDVI = 'NDVI', EN = 'E(NDVI)', VN = 'Var(NDVI)'),
       coords = list(x = c(R = 0, NDVI = 0, Z = 0, S = 0, H = 0,
                           E = -1, V = 1, EN = -1, VN = 1),
                     y = c(R = 3,
                           Z = 1.5, H = 0, E = 1.5, V = 1.5,
                           S = 4.5, NDVI = 6, EN = 4.5, VN = 4.5))) %>%
  tidy_dagitty() %>%
  mutate(col = case_when(name == 'E' ~ '1',
                         name == 'EN' ~ '1',
                         name == 'V' ~ '2',
                         name == 'VN' ~ '2',
                         name == 'H' ~ '3',
                         TRUE ~ '4')) %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_point(aes(color = col), size = 20, alpha = 0.3) +
  geom_dag_edges() +
  geom_dag_text(aes(label = label), color = 'black', size = 3) +
  scale_color_manual(values = c(pal[1:3], 'black')) +
  theme_dag() +
  theme(legend.position = 'none')
