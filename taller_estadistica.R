# Cargar Librerías --------------------------------------------------------

library(devtools)
library(tidyverse)
library(janitor)
library(BSDA)
library(ggplot2)
library(SamplingUtil)

#Ordenar nombres con janitor

janitor::clean_names(data)


# Cargar BBDD ------------------------------------------------------------------

library(readxl)

data <- readxl::read_xlsx("data/hotel_bookings.xlsx")
## Como cambiar los "meses texto" a "meses número"
## cargados los datos en Base
library(dplyr)

#Crear una nueva columna a partir de "arrival_date_month" con los números del mes
# a través de la función de recode (ésta no elimina la columna a diferencia) de
# hacerlo con mutate

data$mes = recode(data$arrival_date_month, 
                  "January" = 1, "February" = 2, "March" = 3, 
                  "April" = 4, "May" = 5, "June" = 6, 
                  "July" = 7, "August" = 8, "September" = 9, 
                  "October" = 10, "November" = 11, "December" = 12)

# construccion de fecha tipo año+mes (asi quedan "ordenados")
data$Fecha = 100*data$arrival_date_year+data$mes

# Análisis Descriptivo ----------------------------------------------------
## A -----------------------------------------------------------------------
# Realice una revisión de la base de datos cargada, formato de columnas, cantidad de datos
# faltantes por columna, histograma de cada variable y estadísticas descriptivas como
# promedios, percentiles, mediana, entre otras. ¿Cómo se interpreta el promedio de la variable
# is_canceled.?

data %>% 
  count()
        
data <- janitor::remove_empty(data, which = c("rows", "cols"))
# No hay columnas vacías

data %>% 
  count()

# Histograma a partir de las variables (columnas) del dataframe
hist(data$hotel)
hist(data$is_canceled)
hist(data$lead_time)
hist(data$arrival_date_year)
hist(data$arrival_date_month)
hist(data$arrival_date_day_of_month)
hist(data$stays_in_weekend_nights)
hist(data$adults)
hist(data$children)

# A través de la función summary se puede ver un resumen de
# Todas las variables (columnas)
summary(data)

# Sacar promedio de "is_canceled"
mean(data$is_canceled)*100
# El promedio de cancelaciones es de 37%

## B ---------------------------------------------------------------------------

# Cree una variable que contenga el año y mes de la reserva y añádala a la 
# base de datos. ¿En qué período temporal se mueven las reservas de 
# la base de datos? Realice un gráfico que muestre la cantidad de reservas 
# por año y mes. ¿Por qué la fecha pudiera ser importante al analizar 
# reservas de hoteles? Comente.

# Ocupar función paste para concatenar 2 columnas, se debe escribir el nombre
# de la nueva variable (columna) y luego poner paste (variables que queramos
# concatenar, en este caso arrival_date_year y arrival_date_month)
data$aniomes = paste(data$arrival_date_year, data$arrival_date_month)
glimpse(data)

# Revisar la columna recién creada con summary
summary(data$aniomes)

# Hacer un glimpse al dataframe para revisar las clases de las variables
glimpse(data)

#Transformar a numerico la columna aniomes
data$aniomes = as.numeric(data$aniomes)

#Hacer un gráfico con ggplot donde en el eje x se representa la nueva variable
# aniomes
ggplot(data = data,
       aes(x = aniomes))+
  geom_bar(color ="darkblue")

# Las reservas están hechas en el período de Junio 2015 a Agosto 2017


# Muestreo ----------------------------------------------------------------

## C -----------------------------------------------------------------------
# Como ya se habrá dado cuenta, la base de datos se encuentra ordenada por mes y 
# año de reserva. Suponga que necesita realizar un muestreo y por la razón 
# anterior es evidente un muestreo sistemático no es la mejor idea. 
# Explique por qué.


# No es una buena idea hacer muestreo sistemático ya que como los meses están
# agrupados y no ordenados de forma aleatoria es posible que la secuencia 
# favorezca más a ciertos meses en desmedro de otros, haciendo que 
# la representatividad de la muestra disminuya


## D -----------------------------------------------------------------------
# Usted sabe que una forma de solucionar este detalle del muestreo sistemático 
# es aleatorizar las filas de la base de datos antes de hacer el muestreo. 
# Realice esta aleatorización fijando la semilla 2021 y obtenga una muestra 
# de tamaño 450. Estime la probabilidad de que la reserva sea cancelada 
# (tasa de cancelación) ¿qué tanto difiere del valor real?

# Generar un nuevo valor llamado muestra a partir de una muestra aleatoria de
# nuestra base de datos, con 450 entradas y reemplazando si sale un repetido
# 1º forma para hacerlo
muestra <- sample(
  x = data$is_canceled,
  size = 450,
  replace = TRUE
)

# Otra forma de realizarlo, pero agregando una semilla (2021) y con slice_sample
# que selecciona 450 filas al azar
set.seed(2021)
muestra2 <- data %>% 
  slice_sample(n=450)

# Sacar 2 medias de la variable is_canceled para determinar el % de cancelación
# primero de la base "muestra2" y luego de la base "data" para poder comparar
# La variación que tiene cada una
mean(muestra2$is_canceled)
mean(data$is_canceled)

# La posibilidad de cancelación es de 34%, 
# Mientras que la media global es de 37%

#Sacar la diferencia de valores entre una media y otra
mean(muestra2$is_canceled)-mean(data$is_canceled)

# La diferencia entre los valores es de 0.028%


# Inferencia Estadistica --------------------------------------------------

## E -----------------------------------------------------------------------

# En base a lo anterior, determine un intervalo de confianza para la tasa de 
# cancelación. Utilice una confianza del 95%. ¿El valor real del parámetro se 
# encuentra en este intervalo calculado a través de la muestra?

# Ocupar esta función para eliminar las anotaciones científicas 
# y que no aparezcan números elevados a algo, si no que un valor integral
options(scipen=999)

# Hacer una tabla de la variable "is_canceled" de la base "muestra2"
table(muestra2$is_canceled)

# Determinar un intervalo de confianza al 95% para la variable
# tasa de cancelación (is_canceled). No es necesario escribir el 95% de 
# confianza ya que si no está, por defecto es 95% en todo 
# el mundo de la estadística
prop.test(table(muestra2$is_canceled))

# Hacer lo mismo pero multiplicarlo por 100 para obtener el porcentaje
prop.test(table(muestra2$is_canceled))$conf.int[1:2]*100

# LECTURA RESULTADOS
# Con un 95% de confianza, el valor medio de cancelación oscila entre 
# 61.16% y 70.11%
# Según los datos estadísticos, se puede rechazar la hipótesis nula


## F ---------------------------------------------------------------------------

# Se cree que la tasa de cancelación suele ser mayor en los hoteles de ciudad, 
# pues en los hoteles de ciudad hay muchas más opciones (competencia) de hoteles 
# que en los hoteles resort. Obtenga estimación e intervalos de confianza al 99% 
# para la tasa de cancelación para cada tipo de hotel, 
# ¿observa diferencias? Comente.

# Crear un nuevo objeto a partir de la muestra2 llamado ciudad, que contiene
# solamente la información de los hoteles de ciudad "City Hotel".
# Esto se hace realizando un filtro sobre la muestra 
# filter(hotel == "City Hotel")

ciudad <- muestra2 %>% 
  filter(hotel == "City Hotel")

# Determinar un intervalo de confianza al 99% de la variable tasa de cancelación
# de la bbdd recién creada "ciudad"
prop.test(table(ciudad$is_canceled), conf.level = 0.99)$conf.int[1:2]*100

# Crear un nuevo objeto a partir de la muestra2 llamado resort, que contiene
# solamente la información de los hoteles resort "Resort Hotel".
# Esto se hace realizando un filtro sobre la muestra 
# filter(hotel == "Resort Hotel")
resort <- muestra2 %>% 
  filter(hotel == "Resort Hotel")

# Determinar un intervalo de confianza al 99% de la variable tasa de cancelación
# de la bbdd recién creada "resort"
prop.test(table(resort$is_canceled), conf.level = 0.99)$conf.int[1:2]*100
