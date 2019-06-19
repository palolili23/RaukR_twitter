source("01_functions/00_load_libraries.R")
source("01_functions/01_twitter_token.R")
source("01_functions/02_cleaning_fx.R")


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

bar_chart <- function(data, var1 = var1, filter_users, hashtag){
  var1 <- enquo(var1)
  label <- quo_name(var1)
  
  data %>% 
    filter(screen_name %in% filter_users)%>% 
    ggplot(aes(x = !! var1, fill = !! var1)) +
    geom_bar() +
    coord_flip() +
    labs(title = glue("Top twitter {label} in {hashtag}")) +
    theme_minimal() +
    theme(legend.position="none")}


bar_chart(data_week_bioinf, var1 = screen_name, 
          filter_users = users_top,
          hashtag = "#bioinformatics")

py_users <- selects_screen_name(data_week_py)

#Samples a number of users from the previous vector
r_users_sample <- sample(r_users, 20)

data_users_sample

# Extracts the timeline of the previous users
test <- get_timelines(
  data_users_sample,
  n = 1000,
  language = 'en',
  since = '2015-01-01',
  until = '2019-06-15',
  token = token
)

library(rio)
export(data_week_bioinf, "./03_rawdata/data_week_bioinf.Rdata")

#testing again


data_week$text2 <- gsub(
  "^RT:?\\s{0,}|#|@\\S+|https?[[:graph:]]+", "", data_week$text)
View(data_week$text2)

data_week$text2 <- tolower(data_week$text2)
## trim extra white space
data_week$text2 <- gsub("^\\s{1,}|\\s{1,}$", "", data_week$text2)
data_week$text2 <- gsub("\\s{2,}", " ", data_week$text2)

## estimate pos/neg sentiment for each tweet
library(syuzhet)

text <- data_week$text2

sentiment <- get_nrc_sentiment(text)

View(sentiment)

barplot(
  sort(colSums(prop.table(sentiment[, 1:8]))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Emotions in Sample text", xlab="Percentage"
)

#gets words
text_2 <- get_tokens(text, pattern = "\\W")

View(text_2)

text_2 %>% count()
count(text_2)


# text 1 ------------------------------------------------------------------


text_2 <- as_tibble(text_2)
class(text_2)
str(text_2)
colnames(text_2)
count <- text_2 %>% count(value, sort = TRUE)


# wrangling ---------------------------------------------------------------

djaskflhasd


# section 2 ---------------------------------------------------------------

export(tweets_rstats, here("03_rawdata", "timeline_top20_bioinf.RData"))


                 