#DESARROLLO

library(dplyr)
install.packages("fbRanks")
library(fbRanks)

# 1.A partir del conjunto de datos de soccer de la liga espa�ola de las temporadas 2017/2018, 2018/2019 y 
#2019/2020, crea el data frame SmallData, que contenga las columnas date, home.team, home.score, away.team y
#away.score; esto lo puede hacer con ayuda de la funci�n select del paquete dplyr. Luego establece un directorio 
#de trabajo y con ayuda de la funci�n write.csv guarda el data frame como un archivo csv con nombre soccer.csv.
#Puedes colocar como argumento row.names = FALSE en write.csv.

PD1718 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
PD1819 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
PD1920 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

s1718 <- select(PD1718, date = Date, home.team = HomeTeam, home.score = HS, away.team = AwayTeam, away.score = AS)
s1718 <- mutate(s1718, date = as.Date(date, "%d/%m/%y"))
s1819 <- select(PD1819, date = Date, home.team = HomeTeam, home.score = HS, away.team = AwayTeam, away.score = AS)
s1819 <- mutate(s1819, date = as.Date(date, "%d/%m/%Y"))
s1920 <- select(PD1920, date = Date, home.team = HomeTeam, home.score = HS, away.team = AwayTeam, away.score = AS)
s1920 <- mutate(s1920, date = as.Date(date, "%d/%m/%Y"))

SmallData <- rbind(s1718, s1819, s1920)
str(SmallData)
SmallData

setwd("C:/Users/52722/Desktop/BEDU/II. PROGRAMACION Y ESTADISTICA CON R")
write.csv(x = SmallData, file = "soccer.csv", row.names = FALSE)

# 2.Con la funci�n create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al mismo
#tiempo asignelo a una variable llamada listasoccer. Se crear� una lista con los elementos scores y teams 
#que son data frames listos para la funci�n rank.teams. Asigna estos data frames a variables llamadas 
#anotaciones y equipos.

pkgpath = find.package("fbRanks")
file.loc = paste(pkgpath, "soccer.csv")

listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv")
str(listasoccer)

anotaciones <- listasoccer$scores
equipos <- listasoccer$teams


# 3.Con ayuda de la funci�n unique crea un vector de fechas (fecha) que no se repitan y que correspondan a 
#las fechas en las que se jugaron partidos. Crea una variable llamada n que contenga el n�mero de fechas 
#diferentes. Posteriormente, con la funci�n rank.teams y usando como argumentos los data frames anotaciones 
#y equipos, crea un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la pen�ltima 
#fecha en la que se jugaron partidos, estas fechas las deber� especificar en max.date y min.date. Guarda los
#resultados con el nombre ranking.

fecha <- unique(as.Date(anotaciones$date))
fecha

n <- length(fecha)
n

ranking <- rank.teams(scores = anotaciones, teams = equipos, max.date = "2020-07-16", min.date = "2017-08-18")


# 4.Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o 
#el resultado es un empate para los partidos que se jugaron en la �ltima fecha del vector de fechas fecha. 
#Esto lo puedes hacer con ayuda de la funci�n predict y usando como argumentos ranking y fecha[n] que deber�
#especificar en date.

predict(ranking, date = as.Date("2020-07-19")) 
