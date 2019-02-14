


library(tidyverse)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)


theme_set(theme_bw())

df <- read_csv("listings.csv") %>%
  mutate(price = parse_number(price)) %>%
  filter(price < 5000)

write_csv(df,"listings_update.csv")

names(df)

glimpse(df)

df %>% 
  mutate(price = price) %>%
  ggplot(aes(price)) +
  geom_density()


world <- ne_countries(scale = "medium", returnclass = "sf")

ggplot(data = world) +
  geom_sf() +
  geom_point(data = df, aes(x = longitude, y = latitude,colour = df$price+1), size = .3) +
  coord_sf(xlim = c(min(df$longitude)-.01, max(df$longitude)+.01), 
           ylim = c(min(df$latitude)-.01,max(df$latitude)+.01), expand = FALSE) +
  scale_colour_viridis_c()


