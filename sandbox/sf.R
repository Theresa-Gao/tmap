library(sf)
library(sp)
library(raster)
library(mapview)
library(grid)

devtools::load_all("../tmaptools")
devtools::load_all(".")


data(World, Europe, rivers, metro, land)

W <- as(World, "sf")
r <- as(rivers, "sf")
m <- as(metro, "sf")
landr <- as(land, "RasterBrick")

tm_shape(World) +
	tm_polygons("HPI")

tm_shape(World) +
	tm_bubbles()

tm_shape(World) + tm_polygons() +
	tm_bubbles()

tm_shape(Europe) + tm_polygons("income_grp")

tm_shape(metro) + tm_bubbles()

tm_shape(rivers) + tm_lines("purple")

x <- st_as_grob(W$geometry[[136]])

grid.newpage()
grid.draw(x)

pushViewport(viewport(xscale = st_bbox(W)[c(1,3)], yscale = st_bbox(W)[c(2,4)]))


plot(W[5,])

attr(W, "bbox") <- st_bbox(W)
x <- grid.shape(W, i = 1, k=1, gp=gpar(fill="red"))

grid.newpage()
grid.draw(x)



grb <- sf::st_as_grob(W)



World@proj4string <- sp::CRS()


World <- as(World, "sf")
rivers <- as(rivers, "sf")
metro <- as(metro, "sf")

qtm(World)

sf::st_proj_info(World)

W2 <- st_transform(World, crs=get_proj4("robin"))

W2$geometry

st_crs(World)


st_crs(W2)



# --- preprocess_shapes
# set_projection (set only, and transform)
# approx_areas
# is_projected


# --- process_shapes
# split
# crop

h <- read_osm("Maastricht")

qtm(h)


tm_shape(h, ext=.02, unit = "imperial") + tm_rgb() + tm_scale_bar()



str(land)

land$cover <- as.integer(land$cover) * 12
land$cover_cls <- as.integer(land$cover_cls) * 31
land$elevation <- (land$elevation + 500) / 28

land_europe <- crop_shape(land, Europe)


qtm(land_europe)


# bug in smooth_map output
vol <- raster::raster(t(volcano[, ncol(volcano):1]), xmn=0, xmx=870, ymn=0, ymx=610)
vol_smooth <- smooth_map(vol, smooth.raster = FALSE, nlevels = 10)

x <- vol_smooth$polygons

rgeos::gIsValid(x)

plot(x)
tm_shape(x) + tm_polygons()


xsf <- as(x, "sf")

plot(xsf)
qtm(xsf)



load("test/wkr.rdata")

ttm()
qtm(wkr)


## test feature split in sf
data(World, rivers)
W <- as(World, "sf")
R <- as(rivers, "sf")


tm_shape(W) +
	tm_polygons() +
	tm_dots() +
tm_shape(R) +
	tm_lines()



W
tm_sf



nrow(R)

R2 <- st_cast(R, "LINESTRING")

which(World$name=="Canada")

W$geometry[28] <- st_cast(W$geometry[28], "MULTILINESTRING")

tm_shape(World) +
	tm_fill() +
	tm_dots() +
tm_shape(World) +
	tm_borders("red") + 
tm_shape(R) +
	tm_lines()

########### test geometrycollection
W <- as(World, "sf")
W$geometry[W$continent == "Africa"] <- st_centroid(W$geometry[W$continent == "Africa"])
W$geometry[W$continent == "South America"] <- st_cast(W$geometry[W$continent == "South America"], "MULTILINESTRING", group_or_split = FALSE)

W$geometry[which(W$name == "Canada")]

plot(W[,1])

a <- st_is(W, c("MULTIPOLYGON", "MULTILINESTRING"))
a <- st_is(W, "MULTILINESTRING")
a <- st_is(W, "POLYGON")

tm_shape(W) +
	tm_fill("HPI") +
	tm_dots() +
tm_shape(metro) +
	tm_dots()


tm_shape(W) +
	tm_fill("HPI") +
	tm_dots() +
	tm_lines() +
tm_shape(metro) +
	tm_dots()

lapply(st_geometry(W), class)


shp <- W


W2 <- sf_expand(W)


W2 <- sf_expand(W)


vol <- raster::raster(t(volcano[, ncol(volcano):1]), xmn=0, xmx=870, ymn=0, ymx=610)
vol_smooth <- smooth_map(vol, smooth.raster = FALSE, nlevels = 10)
shp <- as(vol_smooth$iso, "sf")

tm_shape(vol_smooth$iso) +
tm_iso(col = "black", size = .7, fontcolor="black")

tm_shape(vol_smooth$polygons) +
	tm_fill("level", palette=terrain.colors(11), title="Elevation") +
	tm_shape(vol_smooth$iso) +
	tm_iso(col = "black", size = .7, fontcolor="black") +
	tm_layout("Maunga Whau volcano (Auckland)", title.position=c("left", "bottom"),
			  inner.margins=0) +
	tm_legend(width=.13, position=c("right", "top"), bg.color="gray80", frame = TRUE)


s <- shp[1,]
plot(s)

s <- sf_expand(s)
coor <- st_coordinates(s)
coors <- split.data.frame(coor[,1:2], f = coor[,3], drop=FALSE)


qtm(s) + qtm(st_centroid(s))


