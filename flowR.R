#Code inspired by Michael Freeman at http://mfviz.com/r-image-art/




library(imager)    # image loading and processing
library(dplyr)     # data manipulation
library(ggplot2)   # data visualization
library(tidyr)     # data wrangling
library(ggvoronoi) # visualization

img <- load.image(file = "./data/flower_image.jpeg")
