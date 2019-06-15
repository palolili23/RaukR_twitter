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
