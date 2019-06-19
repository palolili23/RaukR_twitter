here()
library(rtweet)
library(tidyverse)
library(ggmap)
library(ggplot2)
#library(maps)
#library(mapdata)


#" load data
load("./03_rawdata/timeline_top20_bioinf.RData")
glimpse(x)
count(x) #N = 153,860

## looking at location and tweet/retweet
x %>% .$location
x %>% .$is_retweet

## tweets sent via different platforms
t <-table(x$source)

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
    location %in% c("Edinburgh","London, England","Norwich, UK","Oxford, England") ~ "UK",
    location %in% c("Boston, MA","Seattle, WA","New Orleans, LA, USA", "United States") ~ "USA",
    location %in% c("The Earth") ~ "Earth",
    TRUE ~ "OTHER",
    ))


n_loc <- loc_count
count(n_loc) #n=17 countries, including The Earth 

## getting total for plotting
total_by_country <- n_loc %>% group_by(Country) %>% summarize(Total=sum(n))

