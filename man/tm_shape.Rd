% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tm_shape.R
\name{tm_shape}
\alias{tm_shape}
\title{Specify the shape object}
\usage{
tm_shape(shp, name = NULL, is.master = NA, projection = NULL,
  bbox = NULL, unit = getOption("tmap.unit"), simplify = 1,
  line.center.type = c("segment", "midpoint"), ...)
}
\arguments{
\item{shp}{shape object, which is one of
\enumerate{
 \item{\code{\link[sp:SpatialPolygonsDataFrame]{SpatialPolygons(DataFrame)}}}
 \item{\code{\link[sp:SpatialPointsDataFrame]{SpatialPoints(DataFrame)}}}
 \item{\code{\link[sp:SpatialLinesDataFrame]{SpatialLines(DataFrame)}}}
 \item{\code{\link[sp:SpatialGridDataFrame]{SpatialGrid(DataFrame)}}}
 \item{\code{\link[sp:SpatialPixelsDataFrame]{SpatialPixels(DataFrame)}}}
 \item{\code{\link[raster:Raster-class]{RasterLayer, RasterStack, or RasterBrick}}}
}
Simple features (\code{sf} objects) are also supported. For drawing layers \code{\link{tm_fill}} and \code{\link{tm_borders}}, 1 is required. For drawing layer \code{\link{tm_lines}}, 3 is required. Layers \code{\link{tm_symbols}} and \code{\link{tm_text}} accept 1 to 3. For layer \code{\link{tm_raster}}, 4, 5, or 6 is required.}

\item{name}{name of the shape object (character) as it appears in the legend in \code{"view"} mode. Default value is the name of \code{shp}.}

\item{is.master}{logical that determines whether this \code{tm_shape} is the master shape element. The bounding box, projection settings, and the unit specifications of the resulting thematic map are taken from the \code{tm_shape} element of the master shape object. By default, the first master shape element with a raster shape is the master, and if there are no raster shapes used, then the first \code{tm_shape} is the master shape element.}

\item{projection}{Either a \code{\link[sp:CRS]{CRS}} object or a character value. If it is a character, it can either be a \code{PROJ.4} character string or a shortcut. See \code{\link[tmaptools:get_proj4]{get_proj4}} for a list of shortcut values. By default, the projection is used that is defined in the \code{shp} object itself, which can be obtained with \code{\link[tmaptools:get_projection]{get_projection}}.}

\item{bbox}{bounding box. One of the following:
\itemize{
\item A bounding box (either 2 by 2 matrix or an \code{\link[raster:Extent]{Extent}} object). 
\item Open Street Map search query. The bounding is automatically generated by querying \code{q} from Open Street Map Nominatim. See \url{http://wiki.openstreetmap.org/wiki/Nominatim}.}
If unspecified, the current bounding box of \code{shp} is taken. The bounding box is feed to \code{\link[tmaptools:bb]{bb}} (as argument \code{x}. The other arguments of \code{\link[tmaptools:bb]{bb}} can be specified directly as well (see \code{..}).}

\item{unit}{desired units of the map. One of \code{"metric"} (default), \code{"imperial"}, \code{"km"}, \code{"m"}, \code{"mi"} and \code{"ft"}. Used to specify the scale bar (see \code{\link{tm_scale_bar}}) and to calculate densities for choropleths (see argument \code{convert2density} in \code{\link{tm_fill}}).}

\item{simplify}{simplification factor for spatial polygons and spatial lines. A number between 0 and 1 that indicates how many coordinates are kept. See the underlying function \code{\link[tmaptools:simplify_shape]{simplify_shape}}, from which the arguments \code{keep.units} and \code{keep.subunits} can be passed on (see \code{...}).}

\item{line.center.type}{vector of two values specifying how the center of spatial lines is determined Only applicable if \code{shp} is a \code{\link[sp:SpatialLinesDataFrame]{SpatialLines(DataFrame)}}, and symbols, dots, and/or text labels are used for this shape. The two values are:
\describe{
\item{\code{"feature", "single"}}{If \code{"feature"} is specified, a pair of coordinates (used for symbols, dots, and text labels) is chosen for each feature (i.e., a row in the \code{\link[sp:SpatialLinesDataFrame]{SpatialLines(DataFrame)}}). If \code{"segment"} is specified, a pair of coordinates is chosed for each line segment.}
\item{\code{"midpoint"} or \code{"centroid"}}{The midpoint is the middle point on the line, so the coordinates (used for symbols, dots, and text labels) correspond to the midpoints of the line segments. In case the first value is \code{"feature"}, then per feature, the midpoint of the line segment that is closest to the centroid is taken.}
}}

\item{...}{Arguments passed on to \code{\link[tmaptools:bb]{bb}} (e.g. \code{ext} can be used to enlarge or shrinke a bounding box), and \code{\link[tmaptools:simplify_shape]{simplify_shape}} (the arguments \code{keep.units} and \code{keep.subunits})}
}
\value{
\code{\link{tmap-element}}
}
\description{
Creates a \code{\link{tmap-element}} that specifies the shape object. Also the projection and covered area (bounding box) can be set. It is possible to use multiple shape objects within one plot (see \code{\link{tmap-element}}).
}
\examples{
current.mode <- tmap_mode("plot")

data(World, metro, rivers)

tm_shape(World, projection="longlat") + 
    tm_polygons() + 
tm_layout("Long lat coordinates (WGS84)", inner.margins=c(0,0,.1,0), title.size=.8)

World$highlighted <- ifelse(World$iso_a3 \%in\% c("GRL", "AUS"), "gold", "gray75")
tm_shape(World, projection="merc", ylim=c(.1, 1), relative = TRUE) + 
    tm_polygons("highlighted") + 
tm_layout("Web Mercator projection. Although widely used, it is discouraged for
statistical purposes. In reality, Australia is 3 times larger than Greenland!",
    inner.margins=c(0,0,.1,0), title.size=.6)

tm_shape(World, projection="wintri") + 
    tm_polygons() +
tm_layout(
"Winkel-Tripel projection, adapted as default by the National Geographic Society for world maps.",
    inner.margins=c(0,0,.1,0), title.size=.8)

tm_shape(World) +
    tm_polygons() + 
tm_layout("Eckhart IV projection. Recommended in statistical maps for its equal-area property.",
    inner.margins=c(0,0,.1,0), title.size=.8)


# different levels of simplification
\dontrun{
tm1 <- tm_shape(World, simplify = 0.05) + tm_polygons() + tm_layout("Simplification: 0.05")
tm2 <- tm_shape(World, simplify = 0.1) + tm_polygons() + tm_layout("Simplification: 0.1")
tm3 <- tm_shape(World, simplify = 0.25) + tm_polygons() + tm_layout("Simplification: 0.25")
tm4 <- tm_shape(World, simplify = 0.5) + tm_polygons() + tm_layout("Simplification: 0.5")

require(tmaptools)
tmap_arrange(tm1, tm2, tm3, tm4)
}

# three groups of layers, each starting with tm_shape
\dontrun{
tm_shape(World) +
    tm_fill("darkolivegreen3") +
tm_shape(metro) +
    tm_bubbles("pop2010", col = "grey30", scale=.5) +
tm_shape(rivers) +
    tm_lines("lightcyan1") +
tm_layout(bg.color="lightcyan1", inner.margins=c(0,0,.02,0), legend.show = FALSE)
}

# restore current mode
tmap_mode(current.mode)
}
\seealso{
\code{\link[tmaptools:read_shape]{read_shape}} to read ESRI shape files, \code{\link[tmaptools:set_projection]{set_projection}}, \href{../doc/tmap-nutshell.html}{\code{vignette("tmap-nutshell")}}
}
