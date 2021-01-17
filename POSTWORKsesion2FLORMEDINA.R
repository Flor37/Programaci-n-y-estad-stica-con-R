library(dplyr)

# 1.Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división 
#   de la liga española a R, los datos los puedes encontrar en el siguiente enlace:https://www.football-data.co.uk/spainm.php

pd1718 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
pd1819 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
pd1920 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")


# 2.Obten una mejor idea de las características de los data frames al usar las funciones: str, head, 
#   View y summary

str(pd1718); str(pd1819); str(pd1920)
head(pd1718); head(pd1819); head(pd1920)
View(pd1718); View(pd1819); View(pd1920)
summary(pd1718); summary(pd1819); summary(pd1920)

# 3.Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam, AwayTeam, 
#   FTHG, FTAG y FTR; esto para cada uno de los data frames. (Hint: también puedes usar lapply).

setwd("C:/Users/52722/Desktop/BEDU/II. PROGRAMACION Y ESTADISTICA CON R/filesPostw1")

download.file(url = pd1718, destfile = "SP1-1718.csv", mode = "wb")
download.file(url = pd1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = pd1920, destfile = "SP1-1920.csv", mode = "wb")

dir()

lista <- lapply(dir(), read.csv)

lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)


# 4. Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del 
#   mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas). Con ayuda de la función rbind 
#   forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función 
#   do.call podría ser utilizada).

str(lista)

data <- do.call(rbind, lista)
data <- mutate(data, Date = as.Date(Date, "%d/%m/%y"))

str(data)
