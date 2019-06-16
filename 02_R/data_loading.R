source("01_functions/00_load_libraries.R")
source("01_functions/01_twitter_token.R")

# Get last week data
data_week <- search_tweets(
  "bioinformatics", n = 18000, include_rts = FALSE)

# Get oldest data
tweets <- get_timelines("bioinformatics", 
                        n = 10000, 
                        language = 'en',
                        since = '2018-01-01', 
                        until = '2019-06-15',
                        token = token)

tweets_biocond <- get_timelines("bioconductor", 
                        n = 10000, 
                        language = 'en',
                        since = '2018-01-01', 
                        until = '2019-06-15',
                        token = token)

# Timeline

ts_plot(tweets, "month")

# Extracting a sample of the names from the previous week

#Pulls a list of user names

data_users <- data_week %>% 
  count(screen_name) %>% 
  arrange(desc(n)) %>% 
  pull(screen_name)

length(data_users)

#Samples a number of users from the previous vector
data_users_sample <- sample(data_users, 20)

data_users_sample

# Extracts the timeline of the previous users
test <- get_timelines(data_users_sample, 
                      n = 1000, 
                      language = 'en',
                      since = '2015-01-01', 
                      until = '2019-06-15',
                      token = token)

library(rio)
export(test, "./03_rawdata/test_20users.RData")

#testing again
