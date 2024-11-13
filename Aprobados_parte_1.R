library(openxlsx)
library(tidyverse)


df_org = read.xlsx("faucet/data/RegistroTotalOBL_org.xlsx")
df_apr = read.xlsx("faucet/data/Finalizados Parte 1.xlsx")

df_apr$Aprobado_Parte_1 = "SI"

df_apr = df_apr %>% 
  select(Email.address, Aprobado_Parte_1) %>% 
  rename(Email.Address=Email.address)

df_org = df_org %>% 
  select("Email.Address", "Nombres", "Apellidos", "Género",
         "Edad", "País")

df_all = full_join(df_org, df_apr)

df_all$Aprobado_Parte_1[is.na(df_all$Aprobado_Parte_1)] = "NO"

write.xlsx(df_all, "faucet/data/Aprobados_parte1.xlsx")

