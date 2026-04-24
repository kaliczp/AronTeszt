library(lidR)

## Import catalog
ctg <- readLAScatalog("Test_laz")
las_check(ctg)

## Process normalised cloud in the current folder
dtm <- rasterize_terrain(ctg, res = 1, algorithm = tin())
opt_output_files(ctg) <-  "./{*}_norm"
ctg_norm <- normalize_height(ctg, dtm)

## Reset file mask
opt_output_files(ctg_norm) <- ""

## Get treetops
ttops <- locate_trees(ctg_norm, lmf(5))

## Clip a sample
Slocation <- c(608550, 5280500, 15) # x, y, radius
Sclip <- clip_circle(ctg_norm, Slocation[1], Slocation[2], Slocation[3])
# Buffer circles by 40m
dat_circles <- sf::st_buffer(sf::st_as_sfc(paste("POINT(",Slocation[1], Slocation[2],")"), crs = 32633), dist = Slocation[3])
ttops_in_circles <- sf::st_intersection(ttops, dat_circles)
offsets <- plot(Sclip, size = 3)
add_treetops3d(offsets, ttops_in_circles)

