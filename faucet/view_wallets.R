library(igraph)
library(tidyverse)
library(lubridate)

options(scipen = 999)

# load_data ---------------------------------------------------------------

df_address =read.csv('faucet/data/txlistaddres.csv', 
                     colClasses=c("character"),
                     stringsAsFactors=FALSE)
df_address$X = NULL

df_internal = read.csv('faucet/data/txlistinternal.csv', 
                       colClasses=c("character"),
                       stringsAsFactors=FALSE)
df_internal$X = NULL

df_graph = data.frame(substr(df_address$address, 1, 10), 
                      substr(df_address$to, 1, 10),
                      df_address$timeStamp)

df_graph$df_address.timeStamp = as.numeric(df_graph$df_address.timeStamp)

df_graph$df_address.timeStamp = dmy(df_graph$df_address.timeStamp)


df_graph_plot = graph_from_data_frame(df_graph, directed=FALSE)

plot.igraph(df_graph_plot,
            vertex.label.dist = 0, # alejar un poco la etqueta del vertice
            vertex.label.cex = 0.4,
            vertex.size = 6,
            edge.arrow.size = 0.1, # tamaño de la flecha
            vertex.color = adjustcolor("SkyBlue2", alpha.f = .5),
            main = "Transacciones desde el Faucet")

write_graph(df_graph_plot,
            file="faucet/data/faucet.graphml",
            format= "graphml")
