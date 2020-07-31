#Code inspired by Michael Freeman at http://mfviz.com/r-image-art/




library(imager)    # image loading and processing
library(dplyr)     # data manipulation
library(ggplot2)   # data visualization
library(tidyr)     # data wrangling
library(ggvoronoi) # visualization

setwd("~/Documents/GitHub/Art")
img <- load.image(file = "./data/flower_image.jpeg")
img_df <- as.data.frame(img)

img_df %>% 
    arrange(x, y, cc) %>% # sort by columns for viewing
    filter(row_number() < 10) 

# Add more expressive labels to the colors
img_df <- img_df %>% 
    mutate(channel = case_when(
        cc == 1 ~ "Red",
        cc == 2 ~ "Green", 
        cc == 3 ~ "Blue"
    ))

# Reshape the data frame so that each row is a point
img_wide <- img_df %>%
    select(x, y, channel, value) %>%
    spread(key = channel, value = value) %>%
    mutate(
        color = rgb(Red, Green, Blue)
    )

sample_size <- 10000
img_sample <- img_wide[sample(nrow(img_wide), sample_size), ]

ggplot(img_sample) +
    geom_point(mapping = aes(x = x, y = y, color = color)) +
    scale_color_identity() + # use the actual value in the `color` column
    scale_y_reverse() + # Orient the image properly (it's upside down!)
    theme_void()
ggsave("flwR.pdf", height=4, width=3.5)
