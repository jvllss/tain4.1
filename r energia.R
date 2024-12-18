energia <- c(rep("renovable", 10), rep("no_renovable", 10))
consumo <- c(120, 100, 90, 80, 110, 130, NA, 140, 95, 115,
             125, 105, 85, 75, NA, 150, 135, 145, NA, NA)
costo_kwh <- c(0.12, 0.12, 0.12, 0.12, 0.12, 0.12, 0.12, 0.12, 0.12, 0.12,
               0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20, 0.20)

med_renov <- median(consumo[energia == "renovable"], na.rm = TRUE)
med_no_renov <- median(consumo[energia == "no_renovable"], na.rm = TRUE)

consumo[is.na(consumo) & energia == "renovable"] <- med_renov
consumo[is.na(consumo) & energia == "no_renovable"] <- med_no_renov

df_consumo <- data.frame(
  energia = energia,
  consumo_diario = consumo,
  costo_kwh = costo_kwh
)

df_consumo$costo_total <- df_consumo$consumo_diario * df_consumo$costo_kwh

totales <- aggregate(cbind(consumo_diario, costo_total) ~ energia, data = df_consumo, sum)
media_consumo <- aggregate(consumo_diario ~ energia, data = df_consumo, mean)

df_consumo$ganancia <- df_consumo$costo_total * 1.1

df_consumo_ordenado <- df_consumo[order(-df_consumo$costo_total), ]

total_consumo_por_energia <- aggregate(consumo_diario ~ energia, data = df_consumo, sum)
total_costo_por_energia <- aggregate(costo_total ~ energia, data = df_consumo, sum)

top_3_costos <- head(df_consumo_ordenado, 3)

resumen_energia <- list(
  dataframe_ordenado = df_consumo_ordenado,
  total_consumo_por_energia = total_consumo_por_energia,
  total_costo_por_energia = total_costo_por_energia,
  top_3_costos = top_3_costos
)

print("Resumen de energía:")
print(resumen_energia)