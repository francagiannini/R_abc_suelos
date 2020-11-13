# abrir un objeto espacial vectorial

library(sf)

limites_cba <- read_sf("data/lim cba.kml")

ugh <- read_sf("data/Unidades_de_Gestión_Hidrica/Unidades_de_Gestión_Hidrica.shp")

dib_sf <- st_as_sf(dib, coords = c("X.UTM20", "Y.UTM20"), crs = 32720)

perfiles_sf <-
  st_as_sf(
    perfiles_mortero,
    coords = c( "Long_Dec","Lat_Dec"),
    crs = 4326,
    na.fail = FALSE
  )



#visualización de datos espaciales

library(tmap)

tmap_mode("view")

tm_shape(perfiles_sf)+
  tm_dots()

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

# extraer info

st_intersection(ugh, dib_sf)

st_crs(dib_sf)==st_crs(ugh)

st_crs(dib_sf)

st_crs(ugh)

ugh <- st_transform(ugh, crs = st_crs(dib_sf))

st_crs(dib_sf)==st_crs(ugh)

dib_ugh <- st_join(dib_sf,ugh)

dib_ugh %>% group_by(CUENCA) %>% 
  summarise(mediaSOC=mean(SOC, na.rm = T),
            sdSOC=sd(SOC, na.rm = T))

