# Clase 10 - Estructuras de Control ---------------------------------------
# Profesora - Constanza Prado
# La clase pasada quedamos en Tidyverse

## Buenas prácticas --------------------------------------------------------
# Creación de proyectos - establecer directorios en una carpeta autocontenida
#   para que la ruta no se altere
# No ocupar caracteres especiales, "ñ", tildes, espacios
# Siempre partir el código cargando librerías

library(tidyverse)

# Clase 6 -----------------------------------------------------------------
## Estructuras de Control --------------------------------------------------

# Referenciar la librería que estamos ocupando, en este caso se puede llamar
#   la función como filter, pero agregar la librería es bueno para cuando otra
#   persona lo . Hay veces que existe la misma función en 2 librerías

### Ejemplo de referencia de código -----------------------------------------

# En el caso de abajo, se selecciona la base "iris", a través de un pipe se
#   filtra la especie "setosa"
# A través de otro pipe se llama la  función select se seleccionan solo las 
#   columnas "Sepal.Length" y "Petal.Length"
# Luego con otro pipe se llama a la función summarise para crear 
#   2 columnas nuevas que están compuestas de la media de las columnas
#   "Sepal.Length" y "Petal.Length"

iris %>% 
  dplyr::filter(Species == "setosa") %>% 
  dplyr::select(Sepal.Length, Petal.Length) %>% 
  dplyr::summarise(Promedio_Sepal = mean(Sepal.Length),
                   Promedio_Petal = mean(Petal.Length))

## Operadores Lógicos -----------------------------------------------------

# R contiene algunos operadores lógicos, estos objetos entregan un booleano
# True o False de clase "Logical"

5 == 3
5<3
5>3
5!=3

# Filtro por edad
# Edad =>14, Edad =<35

# R es sensible a las mayúsculas

"Gato" == "gato"

# El Operador %in% hace un cruce de lo que está en la base de datos letters
#   que son letras en minúscula, es un buen reemplazo para == en ciertas 
#   situaciones. %in% busca si está contenido

c("a","B","c") %in% letters
c("a","B","c") == letters

# Utilizar %in% como filtro

iris %>% 
  dplyr::filter(Species == "setosa" | Species == "versicolor") %>% 
  dplyr::select(Sepal.Length, Petal.Length) %>% 
  dplyr::summarise(Promedio_Sepal = mean(Sepal.Length),
                   Promedio_Petal = mean(Petal.Length))

# Cuando se ocupa %in% se puede hacer una lista de variables como un vector

iris %>% 
  dplyr::filter(Species %in% c("setosa", "versicolor")) %>% 
  dplyr::select(Sepal.Length, Petal.Length) %>% 
  dplyr::summarise(Promedio_Sepal = mean(Sepal.Length),
                   Promedio_Petal = mean(Petal.Length))

## Comando if --------------------------------------------------------------
# Solo cuando se cumple una condición
# if(condicion){
#   código a ejecutar su la condición es verdadera
# }

# Crear un objeto llamado nota
nota <- 6.5
nota2 <- 3.8

# Si la nota es igual o mayor que 4, se imprime un mensaje de felicitaciones

if(nota >= 4){
  print("Felicidades")
} else {
  print("Sigue esforzándote")
}

# Al agregar la condición else, nos ahorramos líneas porque es "el caso contrario
#   nota menor a 4
# El operador else no necesita abrir paréntesis ya que R lo reconoce 
#   dentro del código

if(nota2 >= 4){
  print("Felicidades")
} else {
  print("Sigue esforzándote")
}

## Comando Else If ---------------------------------------------------------

if((nota < 1) | (nota > 7) | (!is.numeric(nota))){
  print("Error, ingrese un numero entre 1 y 7")
} else if (nota >= 4) {
  print("Felicidades")
} else {
  print("Sigue intentándolo")
}


## Comando ifelse ----------------------------------------------------------
# Vamos a crear un objeto que se llama mensaje
# ifelse (Condición,
#          Código si condición es VERDADERA,
#          Código si la condición es FALSA)

mensaje <- ifelse(nota >= 4,
       "Felicitaciones",
       "Reprobaste")


### ifelse Qué pasa si se agregan más categorías ---------------------------

mensaje <- ifelse((nota < 1) | (nota > 7) | (!is.numeric(nota)),
          "Error, ingrese un número entre 1 y 7",
          ifelse (nota >= "Felicitaciones", "Reprobaste"))


## Comando case_when -------------------------------------------------------

mensaje2 <- case_when (!is.numeric(nota) ~ "Error, ingrese un número entre 1 y 7",
                      nota < 1 ~ "Error, ingrese un número entre 1 y 7",
                      nota > 7 ~ "Error, ingrese un número entre 1 y 7",
                      nota >= 4 ~ "Felicidades",
                      nota < 4 ~ "Reprobaste")

mensaje3 <- case_when ((nota < 1) | (nota > 7) | (!is.numeric(nota)) ~ "Error, ingrese un número entre 1 y 7",
                       nota >= 4 ~ "Felicidades",
                       nota < 4 ~ "Reprobaste")


## Comando for -------------------------------------------------------------
# Supongamos que tenemos un vector de notas

vector_notas <- sample(x =seq(1,7, by = 0.1),
                      size = 63,
                      replace = TRUE)

# El comando for ejecuta el código para todos los elementos indicados

vector_notas
# Ver la nota del tercer alumno
vector_notas[3]
# Ver las notas de algunos alumnos haciendo un vector con los números a observar
vector_notas[c(1,22,13,45)]

# Fijarse en la variable []
for (i in 1:length(vector_notas)) {
  if((vector_notas[i] < 1) | (vector_notas[i] > 7) | (!is.numeric(vector_notas))){
    print("Error, ingrese un numero entre 1 y 7")
  } else if (vector_notas[i] >= 4) {
    print("Felicidades")
  } else {
    print("Sigue intentándolo")
  }
}

# Crear un objeto llamado mensaje que almacene los resultados de

mensaje <- (c)
mensaje <- character(length(vector_notas))

for (i in 1:length(vector_notas)) {
  if((vector_notas[i] < 1) | (vector_notas[i] > 7) | (!is.numeric(vector_notas))){
    print("Error, ingrese un numero entre 1 y 7")
  } else if (vector_notas[i] >= 4) {
    print("Felicidades")
  } else {
    print("Sigue intentándolo")
  }
}
  
length(vector_notas)

## Revisar el video del ejercicio en la clase con x



# Actividad en clases -----------------------------------------------------

# Cargar la base "born"
# Cargar a lo choro con read.csv, no funciona porque sale todo el texto
#   en una columna
Born <- read.csv("data/Born.csv")
# Cargar base, escogiendo el separador ";"
Born <- read.csv("data/Born.csv", sep = ";", dec =",")
## Ver promedio de hijos con dplyr y 
Born %>% 
  dplyr::select(children) %>% 
  dplyr::summarise(promedio_hijos = mean(children))

Born %>% 
  dplyr::select(children) %>% 
  dplyr:: filter(children >= 2) %>% 
  dplyr::summarise(mas_2_hijos = n())

Born %>% 
  dplyr:: filter(children >= 2) %>% 
  dplyr::count()

# Vieja Escuela - Conteo de casos TRUE a través de la función sum
sum(Born$children >= 2)

# Obtener una muestra de tamaño 50 del número de hijos, 
# cuál es el promedio de hijos en la muestra?
# ¿Cómo se podría acercar más al valor real?

promedio_real <- mean (Born$children)
# Hacer la muestra

# Hacer un replace = TRUE para que todas las personas siempre tengan
# La misma posibilidad de ser escogidas, si no la muestra se achica y
# Aumentan las probabilidades de ser escogido entre un n menor
muestra <- sample(x = Born$children,
                  size = 50,
                  replace = TRUE)

# Crear un objeto valor de la media de la muuestra
promedio_estimado <- mean(muestra)

# Ciclos
vector_promedios <- c()
# Crear vectores vacíos, 1:200 es todas las posiciones en el vector
vector_promedios <- numeric(200)
for(i in 1:200){
  muestra <- sample(x = Born$children,
                    size = 50,
                    replace = TRUE)
  vector_promedios[i] <- mean(muestra)
}
 promedio_bootstrap <- mean(vector_promedios)

# Grafico

ggplot(data = NULL,
       aes(x = 1:200, y =vector_promedios))+
  geom_point(color = "darkblue") +
  geom_line(color = "blue") +
  geom_hline(yintercept = promedio_real,
             color = "red",
             lwd = 1, lty = 2) +
  geom_hline(yintercept = promedio_bootstrap,
             color = "green",
             lwd = 1, lty = 2) +
  labs(x = "Muestra", y = "Promedio Muestra")


# Comando While -----------------------------------------------------------

# Realizar ejercicio c de la actividad anterior


vector_promedios <- numeric(200)

contador <- 1
while(contador <= 200){
  muestra <- sample(x = Born$children,
                    size = 50,
                    replace = TRUE)
  
  vector_promedios[contador] <- mean(muestra)
  vector_promedios[contador] <- mean(muestra)
  contador <- contador+1
}



# Comando repeat y break --------------------------------------------------

contador <- 1 %>% 
repeat(contador => 200){
  muestra <- sample(x = Born$children,
                    size = 50,
                    replace = TRUE)
  
  vector_promedios[contador] <- mean(muestra)
  vector_promedios[contador] <- mean(muestra)
  contador <- contador+1
  if(contador >= 201)break
}
