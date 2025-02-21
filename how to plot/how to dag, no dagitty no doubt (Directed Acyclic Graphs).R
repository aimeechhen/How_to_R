
# how to dag (Directed Acyclic Graphs)
# no dagitty no doubt

# https://cran.r-project.org/web/packages/ggdag/vignettes/intro-to-dags.html

# for fancy version of dagitty https://www.rdocumentation.org/packages/rethinking/versions/2.13/topics/drawdag
# alternative https://rpubs.com/kaz_yos/dagR
# if you want a tutorial https://lfoswald.github.io/2021-spring-stats2/materials/session-3/03-online-tutorial/



#///////////////////////////////////////////////
# dagitty ----
#///////////////////////////////////////////////

library(dagitty)

dag <- dagitty("dag {
  aerial_surveys -> number_of_moose_seen
  land_use_surveys -> number_of_moose_seen
  pellet_surveys -> number_of_moose_seen
}")

# Plot the DAG
plot(dag)





#///////////////////////////////////////////////
# ggdag ----
#///////////////////////////////////////////////

## example 1 ----

dag <- dagify(
  B ~ A,   # A -> B
  C ~ B,  # B -> C
  D ~ B,  # B -> D
  E ~ B,  # B -> E
  labels = c(
    "A" = "Aerial Surveys",
    "B" = "Land Use Surveys",
    "C" = "Pellet Surveys",
    "D" = "# Moose Seen"
  )
)

# Plot the DAG
ggdag(dag) +
  geom_dag_edges() + 
  geom_dag_point(size = 50) +
  geom_dag_text(label = labels, color = "white", size = 4) +
  theme_dag()





#............................................................
## From Stefano ----
#(refer to 'appendix-C-empirical-modeling (Stefano) for dags.rmd' script for more details)
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







#.............................................................
## example 3 ----

# Define the DAG structure
dag <- dagify(
  B ~ A,   # A -> B
  C ~ B,  # B -> C
  D ~ B,  # B -> D
  E ~ B,  # B -> E
  labels = c(A = "Wildfire", B = "Mountain Goats", C = "Home range", D = "Habitat use", E = "Movement")
)


ggdag(dag) +
  # geom_dag_point(aes(color = "skyblue", size = 5)) +  
  geom_dag_edges(aes(color = "black", width = 1)) +    
  geom_dag_text(aes(label = label), size = 6, color = "black") +
  theme_dag() +                                       
  theme(legend.position = "none")        




#//////////////////////////////////////////////
# igraph ----
#/////////////////////////////////////////////


library(igraph)

# Define the graph edges and nodes
edges <- c("A", "B", "B", "C", "B", "D", "B", "E")
g <- graph(edges, directed = TRUE)

# Define custom positions for the nodes (asymmetrical layout)
node_positions <- data.frame(
  name = c("A", "B", "C", "D", "E"),
  x = c(1, 2, 3, 4, 5),  # X positions (adjust for asymmetry)
  y = c(2, 3, 4, 2, 5)   # Y positions (adjust for asymmetry)
)

# Set the vertex attributes with custom positions
V(g)$x <- node_positions$x
V(g)$y <- node_positions$y

# Update node names to match your custom names
V(g)$label <- c("Wildfire", "Mountain Goats", "Home range", "Habitat use", "Movement")

# Plot the graph with custom positions and labels
plot(g, vertex.size = 30, vertex.label = V(g)$label,
     vertex.label.cex = 1.2, vertex.label.color = "black", 
     edge.arrow.size = 0.5, layout = cbind(V(g)$x, V(g)$y))



#//////////////////////////////////////////////
# DiagrammeR ----
#/////////////////////////////////////////////



library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

# set parameters of dag, colour, text etc

dag_code <- "
digraph DAG {

  # Set background color and font size
  graph [rankdir=LR, bgcolor = transparent, fontsize=14, fontname = 'Arial']   
  
  # Set node appearance
  node [shape = circle, style = filled, fontname = 'Arial', fontsize = 14, fontcolor = black, width = 1.5]   
  
# define the nodes
  A [label = 'Wildfire', fillcolor = '#cc3311', fontcolor = white]      
  B [label = 'Mountain Goats', fillcolor = lightblue] 
  C [label = 'Home range', fillcolor = '#ccddaa', fontcolor = black]   
  D [label = 'Habitat use', fillcolor = '#ccddaa', fontcolor = black]   
  E [label = 'Movement', fillcolor = '#ccddaa', fontcolor = black]   

# define the edges (arrows)
  A -> B [color = white, penwidth = 3] #arrow thickness
  B -> C [color = white, penwidth = 1]
  B -> D [color = white, penwidth = 1]
  B -> E [color = white, penwidth = 1]
  
  # set custom node positions (adjust for asymmetry)
  A [pos='1,2!']
  B [pos='2,3!']
  C [pos='3,4!']
  D [pos='4,2!']
  E [pos='4,5!']
}
"

# plot
grVis(dag_code)

# assign to object to save
dag_plot <-
  grViz(dag_code)

# Convert to SVG, then save as png
dag_plot = DiagrammeRsvg::export_svg(dag_plot)
dag_plot = charToRaw(dag_plot) # flatten
rsvg::rsvg_png(dag_plot, "figures/dag_plot.png") 





#//////////////////////////////////////////////
# networkD3 (interactive) ----
#/////////////////////////////////////////////

library(networkD3) # INTERACTIVE 

# Set node names
nodes <- data.frame(name = c("Wildfire", "Mountain Goats", "Home range", "Habitat use", "Movement"),
                    group = c(1, 1, 1, 1, 1))  # Add a dummy 'group' column

# Define edges (indexing starts from 0)
edges <- data.frame(from = c(0, 1, 1, 1), to = c(1, 2, 3, 4))

# plot force-directed network 
forceNetwork(Links = edges, Nodes = nodes, Source = "from", Target = "to", 
             NodeID = "name", Group = "group", opacity = 0.8, zoom = TRUE, bounded = TRUE,
             fontSize = 16, fontFamily = "Arial") 