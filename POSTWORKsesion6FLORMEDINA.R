library(dplyr)
library(lubridate)
library(TSA)
library(tidyr)

#Importe el conjunto de datos match.data.csv a R y realice lo siguiente: 

setwd("C:/Users/52722/Desktop/BEDU/II. PROGRAMACION Y ESTADISTICA CON R/6. Series de tiempo")
matchd <- read.csv("match.data.csv")
str(matchd)
matchd <- mutate(matchd, date = as.Date(date, "%Y-%m-%d"))
matchd

# 1.Agrega una nueva columna sumagoles que contenga la suma de goles por partido. 

sumagoles <- (matchd$home.score + matchd$away.score) 
str(sumagoles)
mds <- cbind(matchd, sumagoles)
mds

# 2.Obtén el promedio por mes de la suma de goles. 

grupo <- group_by(mds, year(date), month(date))
p <- summarise(grupo, promedio = mean(sumagoles))
p
str(p)

# 3.Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019. 

p <- as.data.frame(p)
names(p) <- c("Año", "Mes", "Promedio")
p

ppm <- ts(p$Promedio, frequency = 10, start = c(2010, 8), end = c(2019, 12))
ppm

# 4.Grafica la serie de tiempo.

plot(ppm, type = "o", ylab = "Promedio de goles", xlab = "Años",
     main = "Promedio por mes de la suma de goles",
     sub = "Agosto del 2010 a Diciembre de 2019")
