# Leer el archivo CSV
datos <- read.csv("C:\\Users\\javie\\Desktop\\datos.csv", header = TRUE, sep = ",")

# Cálculo de la temperatura media diaria
datos$temperatura_media <- (datos$temperatura_maxima + datos$temperatura_minima) / 2

# Agrupar temperaturas medias diarias por ciudad (para listar)
temperaturas_diarias_por_ciudad <- aggregate(temperatura_media ~ ciudad, data = datos, 
                                             FUN = function(x) paste(round(x, 2), collapse = ", "))

# Calcular la media mensual por ciudad
media_ciudad <- aggregate(temperatura_media ~ ciudad, data = datos, FUN = mean)

# Determinar la ciudad con la temperatura media mensual más alta
ciudad_maxima <- media_ciudad[which.max(media_ciudad$temperatura_media), "ciudad"]

# Definir la ruta de salida del archivo
ruta_salida <- "C:\\Users\\javie\\Desktop\\resumen_temperaturas.txt"

# Generar el archivo de resumen
cat("Temperaturas medias diarias por ciudad:\n", file = ruta_salida)

# Añadir las temperaturas diarias por ciudad al archivo
for (i in 1:nrow(temperaturas_diarias_por_ciudad)) {
  linea <- paste0(temperaturas_diarias_por_ciudad$ciudad[i], ": ", 
                  temperaturas_diarias_por_ciudad$temperatura_media[i], "\n")
  cat(linea, file = ruta_salida, append = TRUE)
}

# Añadir la ciudad con la temperatura media mensual más alta
cat("\nCiudad con la temperatura media más alta del mes: ", file = ruta_salida, append = TRUE)
cat(ciudad_maxima, file = ruta_salida, append = TRUE)

# Mensaje de éxito
print(paste("Archivo de resumen generado en:", ruta_salida))
