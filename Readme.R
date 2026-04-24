library(lidR)
las <- readLAS("Sopron_LiDAR_2/pt000095.las")
crs(las) <- 32633
writeLAS(las, "pt000095.laz", index = TRUE)
