#Utilizando el manejador de BDD Mongodb Compass (previamente instalado), deberás de realizar las siguientes 
#acciones: 

install.packages("mongolite", dependences = TRUE)
library(mongolite)


#Alojar el fichero data.csv en una base de datos llamada match_games, nombrando al collection como match 

setwd("C:/Users/52722/Desktop/BEDU/II. PROGRAMACION Y ESTADISTICA CON R")
datos <- read.csv("data.csv")

con <- mongo(
  collection = "match", 
  db = "match_games",
  url = "mongodb+srv://Flor:Choco19%23%21%24@cluster0.sjeac.mongodb.net/<dbname>?retryWrites=true&w=majority",
  verbose = FALSE,
  options = ssl_options()
  )

con$insert(datos)

#Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base 

con$count()

#Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles 
#que metió el Real Madrid el 20 de diciembre de 2015 y contra qué equipo jugó, ¿perdió ó fue goleada? 

#La fecha indicada no existe, por lo que hacemos una consulta par ver los resultados de todos los partidos
#donde jugó el Real Madrid

x <- con$find('{"HomeTeam":"Real Madrid"}')  #Partidos en los que ha jugado el Real Madrid como local
y <- con$find('{"AwayTeam":"Real Madrid"}')  #Partidos en los que ha jugado el Real Madrid como visitante

#No olvides cerrar la conexión con la BDD.

rm(con)
