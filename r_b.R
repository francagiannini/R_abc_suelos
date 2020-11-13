# abrir un objeto espacial vectorial

library(sf)

limites_cba <- read_sf("data/lim cba.kml")

ugh <- read_sf("data/Unidades_de_Gestión_Hidrica/Unidades_de_Gestión_Hidrica.shp")

dib_sf <- st_as_sf(dib, coords=c("X.UTM20","Y.UTM20"), crs=32720)


#visualización de datos espaciales

library(tmap)

tmap_mode("view")

kda <- tm_shape(dib_sf,
                name = "kda") +
  tm_dots(
    col = "Kda",
    title = "Kd atrazina",
    palette = "-viridis",
    popup.format = list(
      digits = 1,
      decimal.mark = ",",
      big.mark = ".",
      suffix = " L/Kg"
    )
  )
kda
# tmaptools::palette_explorer()

cartas <- tm_shape(ugh,
         name = "ugh") +
  tm_polygons(
    col = "CUENCA",
    title = "Cuencas CBA",
    palette = "Set2",
    border.col = "white",
    border.alpha = 0.7,
    popup.vars = c(
      "SISTEMA " = "SISTEMA",
      "ZONA" = "ZONA",
      "Poblacion"="Poblacion"
    ),
    popup.format = list(
      digits = 1,
      decimal.mark = ",",
      big.mark = ".",
      suffix = " %"
    )
  ) 
cartas

cartas + kda  

