source("01_functions/00_load_libraries.R")
source("01_functions/01_twitter_token.R")
source("01_functions/02_cleaning_fx.R")
data_week_bioinf <- import(here("03_rawdata", "data_week_bioinf.RData"))
timeline <- import(here("03_rawdata", "timeline_top20_bioinf.RData"))


# Extracting data ---------------------------------------------------------

data_week_bioinf <- search_tweets(
  "bioinformatics", n = 18000, include_rts = TRUE)

data_week_bioinf %>% 
  select(1:10) %>% 
  glimpse

users_top <- top_users(data_week_bioinf, 20)

timeline <- get_timelines(users_top, 
                          n = 20000, 
                          language = 'en',
                          since = '2018-01-01', 
                          until = '2019-06-15',
                          token = token)

timeline %>% 
  select(1:10) %>% 
  glimpse()
users <- selects_screen_name(data_week_bioinf)
users_sample <- sample(users, 20)
users_top <- top_users(data_week_bioinf, 20)


# My barplots -------------------------------------------------------------
bar_chart(timeline, var1 = screen_name)

ts_plot(data_week_bioinf, "days")

ts_plot(timeline, "days")



# Some text analysis --------------------------------------------------------
text_2 <- get_tokens(text, pattern = "\\W")

View(text_2)

text_2 %>% count()
count(text_2)

install.packages("rcorpora")
stopwords <- rcorpora::corpora("words/stopwords/en")$stopWords

tokens <- data_week_bioinf %>%
  dplyr::select(text) %>%
  tidytext::unnest_tokens(token, text,
                          token = "token",
                          drop = FALSE) %>%
  dplyr::filter(!token %in% stopwords) 

# text 1 ------------------------------------------------------------------

text_2
text_2 <- as_tibble(text_2)
class(text_2)
str(text_2)
colnames(text_2)
count <- text_2 %>% count(value, sort = TRUE)

text_2 %>% 
  filter(!value %in% stopwords) %>% 
  count(value, sort = TRUE)
