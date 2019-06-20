library("here")
set_here()
here()

library(rtweet)
library(tidyverse)
library(ggmap)
library(ggplot2)
library(maps)
library(mapdata)


#" load data
load("./03_rawdata/timeline_top20_bioinf.RData")
glimpse(x)
count(x) #N = 153,860

## looking at location and tweet/retweet
x %>% .$location
x %>% .$is_retweet

## tweets sent via different platforms
t <-table(x$source)

## retweet counts
retw_10 <- x %>% select(retweet_count) %>% 
  filter(retweet_count < "10")
count(retw_10) #n = 30514

retw_gr10 <- x %>% select(retweet_count) %>% 
  filter(retweet_count >= "10")
count(retw_gr10) #n = 23346

## which country
country_loc <- table(x$location) 

## counting the countries/locations
x %>% count(location) 

## renaming and grouping cities into countries
loc_count <- x %>% count(location)

loc_count <- loc_count %>% 
  mutate(Country = case_when(
    location %in% c("Melbourne Victoria ") ~ "Australia",
    location %in% c("Berlin","Leipzig, Germany") ~ "Germany",
    location %in% c("Greater Sudbury/Grand Sudbur","Montréal, Québec") ~ "Canada",
    location %in% c("France") ~ "France",
    location %in% c("Bergen,Norway") ~ "Norway",
    location %in% c("Edinburgh","London, England","Norwich, UK","Oxford, England") ~ "United Kingdom",
    location %in% c("Boston, MA","Seattle, WA","New Orleans, LA, USA", "United States") ~ "United States of America",
    location %in% c("The Earth") ~ "Earth",
    TRUE ~ "OTHER",
    ))

n_loc <- loc_count
count(n_loc) #n=17 countries, including The Earth 

## getting total for plotting
total_by_country <- n_loc %>% group_by(Country) %>% summarize(Total=sum(n))

## getting a world map to map our twitter countries
world_map <- map_data("world")
ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "white")

## joining the map data with twitter data
total_by_country_merged <- total_by_country %>% 
  left_join(world_map, by = c("Country" = "region"))
count(total_by_country_merged)   #12750

## for plotting  
library("rnaturalearth")
library("rnaturalearthdata")
library("sf")
library("rgeos")

theme_set(theme_bw())

## making a sf
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

#total_by_country_merged
world_merged <- total_by_country %>% 
  left_join(world, by = c("Country" = "sovereignt"))
count(world_merged) #n=33

## NorthAmerica  
NAmerica <-ggplot(data = world_merged) +
  geom_sf(aes(fill = Total)) +
  coord_sf(xlim = c(-180.00,-50.00), ylim = c(20.00,80.00), expand = FALSE)
png("NAmerica.png",height=5,width=7,units="cm",res=200)
print(NAmerica)
dev.off()

## Europe
EU <- ggplot(data = world_merged) +
  geom_sf(aes(fill = Total)) +
  coord_sf(xlim = c(-10.00,17.00), ylim = c(40.00,60.00), expand = FALSE)
png("EU.png",height=5,width=7,units="cm",res=200)
print(EU)
dev.off()

retw_10 <- x %>% select(retweet_count) %>% 
  filter(retweet_count < "10")
count(retw_10) #N = 30514

retw_gr10 <- x %>% select(retweet_count) %>% 
  filter(retweet_count >= "10")
count(retw_gr10) #n = 23346


 


