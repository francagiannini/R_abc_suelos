#abrir txt

dib <- read.table(
  file = "data/dib2020.txt",
  header = TRUE,
  na.strings = "NA"
)
View(dib)
summary(dib)

limites_nodos <- read.table(
  file = "data/limite_cba.csv",
  header = T,
  sep = ","
)


# abrir xls

library(readxl)

perfiles_mortero <-
  read_excel("data/Perfiles modales morteros color.xls")
View(perfiles_mortero)

summary(perfiles_mortero)

# resumir y manejar una tabla 

library(tidyverse)

#%>% 
# ctrl +shift + M 

dib %>% head()
#head(dib)

dib %>% filter(land_uses_obs == c("NO_Grass_crop" , "Grass_crop"))
# filter(dib, land_uses_obs == c("NO_Grass_crop" ,"Grass_crop"))

dib %>% select(ID_2, X.UTM20, Y.UTM20)

dib %>% mutate(SOCporc = SOC * 0.1)

dib %>% summarize(media_SOC = mean(SOC))

dib %>% group_by(land_uses_obs) %>% 
  summarize(media_SOC = mean(SOC))

dib %>% group_by(land_uses_obs) %>% 
  summarize(media_SOC = mean(SOC, na.rm = T))

# graficos 

dib %>% ggplot() 

dib %>% ggplot(aes(x = SOC, y = Clay))    

dib %>% ggplot(aes(x = SOC, y = Clay)) + geom_point()

dib %>% ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Zone_4))

dib %>% ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Kda))

dib %>% ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Zone_4))+
  geom_smooth() 

dib %>% filter(SOC<40) %>% 
  ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Zone_4))+
  geom_smooth() 

dib %>% filter(SOC<40) %>%
  ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Zone_4))+
  geom_smooth(method='lm') 

dib %>% filter(SOC<40) %>%
  ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Zone_4))+
  geom_smooth(method='lm')  +
  facet_wrap( ~ Zone_4)

disp <- dib %>% filter(SOC<40) %>%
  ggplot(aes(x = SOC, y = Clay)) + 
  geom_point(aes(colour = Zone_4))+
  geom_smooth(method='lm') 

# interactivos

library(plotly)

ggplotly(disp)

histkda <- ggplot(dib, aes(x= Kda)) +
  geom_histogram(aes(y=stat(count) / sum(count)), 
                 binwidth=0.5,
                 colour="grey95", fill="tomato2") +
  geom_rug(aes(x = Kda, y = 0), position = position_jitter(height = 0))+
  ylab("Frecuencia relativa")+
  xlab("Kd atrazina")


ggplotly(histkda)
