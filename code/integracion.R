
Students <- seq(1:1000)

get_data_assistance <- function(data_r, r1, r2) {
  
  assistance <- vector()
  for(s in 1:1000){
    assistance <- c(assistance, sum(data_r[[s]][1:32, r1:r2])/384)
  }
  assistance
}

get_data_Biblio <- function(data_r, r1, r2) {
  
  biblio <- vector()
  for(s in 1:1000){
    biblio <- c(biblio, mean(round(data_r[[s]][,r1:r2])))
  }
  biblio
}

get_data_plataforma <- function(data_r, r1, r2) {
  
  suma <- 0
  for(i in 1:1000){
    suma <- suma + sum(data_r[[i]][,r1:r2])
  }
  
  factor_plataforma <- (round(suma)/1000)/6
  
  uso_plat <- vector()
  for(i in 1:1000){
    uso_plat <- c(uso_plat,sum(data_r[[i]][,r1:r2]>factor_plataforma))
  }
  
  uso_plat
}

get_data_libros <- function(data_r, r1, r2) {
  
  suma <- 0
  for(i in 1:1000){
    suma <- suma + sum(data_r[[i]][,r1:r2])
  }
  
  factor_apartado <- (round(suma)/1000)/6
  
  apa_Lib <- vector()
  for(i in 1:1000){
    apa_Lib <- c(apa_Lib,sum(data_r[[i]][,r1:r2]>factor_apartado))
  }
  
  apa_Lib
}

get_data_pagos <- function(data_r) {
  
  promedio.pagos.mtx <-matrix(,nrow=0,ncol=1)
  
  for (i in 1:1000) {
    pagos.vct <- vector()
    pagos.vct[1] <- mean(data_r[[i]][,1:2]) 
    promedio.pagos.mtx <- rbind(promedio.pagos.mtx,pagos.vct)
  }
  
  rownames(promedio.pagos.mtx) <- 1:1000
  
  #Si hay mas de un retraso enciendo la alarma con 0
  promedio.pagos.mtx[promedio.pagos.mtx < 1.875] <- 0
  
  #Minimo un retraso y no se considera con status de pago en alarma
  promedio.pagos.mtx[promedio.pagos.mtx >= 1.875] <- 1
  

  promedio.pagos.mtx
  
}

get_data_examenes <- function(data_r){
  
  promedio.examenes.mtx <- matrix(,nrow=0,ncol=1)
  
  for (i in 1:1000) {
    resultados.vct <- vector()
    resultados.vct[1] <- mean(data_r[[i]][,1:12]) 
    promedio.examenes.mtx <- rbind(promedio.examenes.mtx,resultados.vct)
    
  }
  rownames(promedio.examenes.mtx) <- 1:1000
  
  promedio.examenes.mtx  
  
}

get_data_trabajos <- function(data_r){
  
  promedio.trabajos.mtx <- matrix(,nrow=0,ncol=1)
  for (i in 1:1000) {
    resultados.vct <- vector()
    resultados.vct[1] <- mean(data_r[[i]][,1:12]) 
    promedio.trabajos.mtx <- rbind(promedio.trabajos.mtx,resultados.vct)
    
  }
  rownames(promedio.trabajos.mtx) <- 1:1000
  promedio.trabajos.mtx
}


setwd("C:/Users/ramse/Desktop/Data_analytic/Proyecto final")
getwd()



load("AsistenciasTotales.R")
f_as_1 <-  get_data_assistance(asistencias.totales, 1, 6)
f_as_2 <-  get_data_assistance(asistencias.totales, 7, 12)


load("perfilAlumnos.R")
perfil.alumnos$genero <- factor(perfil.alumnos$genero)
perfil.alumnos$evalucion.socioeconomica <- factor(perfil.alumnos$evalucion.socioeconomica)
perfil.alumnos$edad.ingreso <- factor(perfil.alumnos$edad.ingreso)
data_set <- cbind(perfil.alumnos, f_as_1, f_as_2)

load("ResultadosExamenes.R")
f_examenes <- get_data_examenes(resultados.examenes.totales) 
data_set <- cbind(data_set, f_examenes)

load("ResultadoTrabajos.R")
promedio.trabajos.mtx <- matrix(,nrow=0,ncol=1)
for (i in 1:1000) {
  datos.trabajo <- resultados.trabajos.totales[[i]]
  resultados.vct <- vector()
  resultados.vct[1] <- mean(datos.trabajo[,1:12]) 
  promedio.trabajos.mtx <- rbind(promedio.trabajos.mtx,resultados.vct)
  
}
rownames(promedio.trabajos.mtx) <- 1:1000

data_set <- cbind(data_set, promedio.trabajos.mtx)


load("UsoBiblioteca.R")

f_bibl_1 <-  get_data_Biblio(uso.biblioteca.totales, 1, 6)
f_bibl_2 <-  get_data_Biblio(uso.biblioteca.totales, 7, 12)

data_set <- cbind(data_set, f_bibl_1, f_bibl_2)


load("UsoPlataforma.R")
f_plat1 <- get_data_plataforma(uso.plataforma.totales, 1, 6)
f_plat2 <- get_data_plataforma(uso.plataforma.totales, 7, 12)
data_set <- cbind(data_set, f_plat1, f_plat2)

load("ApartadoDeLibros.R")
f_libros_1 <- get_data_libros(separacion.libros.totales, 1, 6)
f_libros_2 <- get_data_libros(separacion.libros.totales, 7, 12)
data_set <- cbind(data_set, apa_Lib)

load("Becas.R")
data_set <- cbind(data_set, distribucion.becas)


load("HistorialPagos.R")
f_pagos_status <-  get_data_pagos(registro.pagos)
data_set <- cbind(data_set, f_pagos_status)

load("CambioCarrera.R")
data_set <- cbind(data_set, cambio.carrera)

