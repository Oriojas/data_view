library(openxlsx)
library(tidyverse)

df1 = read.xlsx("faucet/data/data_arbitrumOne.xlsx")
df2 = read.xlsx("faucet/data/EnvioActividades - ListadoEmails_W.xlsx")

df1 = df1 %>% 
  select("From", "TokenValue") %>% 
  filter(From != "0xd5e86d4599363e1c5bcfbdc54e01bdc46aaf054c") %>% 
  rename(receiver=From)

df1$receiver = tolower(df1$receiver)
df2$receiver = tolower(df2$receiver)

df_all = left_join(df2, df1)


write.xlsx(df_all, "faucet/data/joint_tarea_arbitrum.xlsx")
