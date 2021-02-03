#Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el número de goles que anotan 
#en un partido el equipo de casa o el equipo visitante.

# 1.Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas 
#   para estimar las siguientes probabilidades:
library(ggplot2)
library(dplyr)

liga <- read.csv("pw2.csv")

# -La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

FTGH <- liga$FTHG
FTAG <- liga$FTAG

x <- c(FTGH)
totg.c <- table(x)
pm.c <- prop.table(totg.c)

# -La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

y <- c(FTAG)
totg.v <- table(y)
pm.v <- prop.table(totg.v)

# -La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

totg.cv <- table(x, y)
pc <- prop.table(totg.cv)

# 2.Realiza lo siguiente:
# -Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo 
#   de casa

barplot(pm.c, main = "PM de los goles anotados por equipos locales",
        xlab = "Número de goles",
        ylab = "Probabilidad Marginal",
        col = c("blue","royalblue", "lightblue"))

# -Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo 
#   visitante.

barplot(pm.v, main = "PM de los goles anotados por equipos visitantes",
        xlab = "Número de goles",
        ylab = "Probabilidad Marginal",
        col = c("green","lightgreen", "gray"))


# -Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de 
#   casa y el equipo visitante en un partido.

heatmap(pc, main = "Probabilidad conjunta",
        scale = "column", 
        col = rainbow(256),
        xlab = "Goles de equipos visitantes",
        ylab = "Goles de equipos locales"
        )
