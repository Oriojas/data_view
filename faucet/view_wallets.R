library(igraph)
library(ggraph)
library(openxlsx)
library(tidyverse)
library(lubridate)

options(scipen = 999)

# load_data ---------------------------------------------------------------

setwd("~/Github/data_view")

df_address =read.csv('faucet/data/txlistaddres3.csv', 
                     colClasses=c("character"),
                     stringsAsFactors=FALSE)
df_address$X = NULL

df_internal = read.csv('faucet/data/txlistinternal3.csv', 
                       colClasses=c("character"),
                       stringsAsFactors=FALSE)
df_internal$X = NULL

df_graph = data.frame(substr(df_address$address, 1, 10), 
                      substr(df_address$to, 1, 10),
                      df_address$timeStamp)

df_graph$df_address.timeStamp = as.numeric(df_graph$df_address.timeStamp)

df_graph$df_address.timeStamp = as.POSIXct(df_graph$df_address.timeStamp,
                                           origin="1970-01-01")

# df_graph$df_address.timeStamp = ymd(df_graph$df_address.timeStamp)


graph_plot = graph_from_data_frame(df_graph, directed=FALSE)

plot.igraph(graph_plot,
            vertex.label.dist = 0, # alejar un poco la etqueta del vertice
            vertex.label.cex = 0.4,
            vertex.size = 6,
            edge.arrow.size = 0.1, # tamaño de la flecha
            vertex.color = adjustcolor("SkyBlue2", alpha.f = .5),
            main = "Transacciones desde el Faucet")

write_graph(graph_plot,
            file="faucet/data/faucet3.graphml",
            format= "graphml")


df_graph %>% 
  mutate(date=ymd(date(df_graph$df_address.timeStamp))) %>% 
  group_by(date) %>% 
  summarise(cant=n()) %>% 
  ggplot(aes(x=date, y=cant)) +
  ggtitle("Interacciones Fauset") +
  geom_point() +
  geom_line()

write.xlsx(df_graph, 'faucet/data/faucet3.xlsx')

