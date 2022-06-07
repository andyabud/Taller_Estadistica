# Taller_Estadistica
Código de la actividad realizada el 06/06 para repasar antes de la evaluación de inferencia estadística

Contiene un archivo xlsx que se debe leer

A continuación, el enunciado de la actividad

Reservaciones de hotel

El archivo Hotel Bookings contiene reservas en dos hoteles (un hotel resort y otro hotel en la ciudad). Las variables son las siguientes:

Nombre variable 	Descripción

hotel 	Indica tipo de hotel

is_canceled 	Indica con 1 si la reserva fue cancelada o 0 si no

lead_time 	Indica la cantidad de días de anticipación de la reserva, es decir, días desde que reservó hasta la fecha de llegada al hotel

arrival_date_year 	Año de la reserva

arrival_date_month 	Mes de la reserva

arrival_date_day_of_month 	Día del mes de la reserva

stays_in_weekend_nights 	Cantidad de días de la reserva que son días de fin de semana (Sábado o Domingo)

stays_in_week_nights 	Cantidad de días de la reserva que son días de semana (Lunes a Viernes)

adults 	Cantidad de adultos a hospedarse en la reserva

children 	Cantidad de niños a hospedarse en la reserva

Paquetes necesarios

library(readxl)

library(dplyr)

library(ggplot2)

#install.packages("remotes")

#remotes::install_github("DFJL/SamplingUtil")

library(SamplingUtil)


Análisis descriptivo
a) Realice una revisión de la base de datos cargada, formato de columnas, cantidad de datos faltantes por columna, histograma de cada variable y 
estadísticas descriptivas como promedios, percentiles, mediana, entre otras. ¿Cómo se interpreta el promedio de la variable is_canceled.?

b) Cree una variable que contenga el año y mes de la reserva y añádala a la base de datos. ¿En qué período temporal se mueven las reservas de 
la base de datos? Realice un gráfico que muestre la cantidad de reservas por año y mes. ¿Por qué la fecha pudiera ser importante 
al analizar reservas de hoteles? Comente.

Hint: La función paste() puede serle de utilidad para concatenar las variables año y mes. 
Para realizar el gráfico la función ggplot() y geom_bar() son de utilidad.

Muestreo

c) Como ya se habrá dado cuenta, la base de datos se encuentra ordenada por mes y año de reserva. Suponga que necesita realizar un muestreo 
y por la razón anterior es evidente un muestreo sistemático no es la mejor idea. Explique por qué.

d) Usted sabe que una forma de solucionar este detalle del muestreo sistemático es aleatorizar las filas de la base de datos antes de hacer el muestreo. 
Realice esta aleatorización fijando la semilla 2021 y obtenga una muestra de tamaño 450. Estime la probabilidad de que la reserva sea cancelada 
(tasa de cancelación) ¿qué tanto difiere del valor real?

Hint: La función slice() sirve para extraer registros y la función sys.sample() del paquete SamplingUtil entrega el vector de valores a muestrear.
Inferencia estadística de la población a través de la muestra

A partir de aquí imaginemos que solo poseemos la muestra obtenida en el apartado anterior. El fin de una muestra es ser un puente hacia 
la población de interés, de modo que podamos inferir sobre la población de interés pero considerando que los valores que obtengamos 
pueden no ser exactamente los valores reales (es por esto que calculamos intervalos de confianza, admitimos cierto grado de variabilidad 
en nuestros resultados).

e) En base a lo anterior, determine un intervalo de confianza para la tasa de cancelación. Utilice una confianza del 95%. 
¿El valor real del parámetro se encuentra en este intervalo calculado a través de la muestra?

Hint: Recuerde que la función prop.test() es útil para realizar un test de proporciones.

f) Se cree que la tasa de cancelación suele ser mayor en los hoteles de ciudad, pues en los hoteles de ciudad hay muchas más opciones 
(competencia) de hoteles que en los hoteles resort. Obtenga estimación e intervalos de confianza al 99% para la tasa de cancelación 
para cada tipo de hotel, ¿observa diferencias? Comente.

g) Se cree que las reservas que han sido canceladas no suelen ser reservas hechas con varios días de anticipación,
ya que las reservas hechas con muchos días de anticipación suelen corresponder a viajes planificados. 
Calcule intervalos de confianza para la media de días de anticipación para las reservas canceladas y no canceladas. 
Finalmente, evalúe al 95% la hipótesis de que la media de los días de anticipación para reservas canceladas es menor 
que la media de los días de anticipación para reservas no canceladas. ¿Qué concluye?

Hint: La función t.test() es útil para realizar intervalos de confianza para medias y test de diferencias de medias.
