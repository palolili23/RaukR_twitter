source("01_functions/00_load_libraries.R")
source("01_functions/01_twitter_token.R")
source("01_functions/02_cleaning_fx.R")
source("01_functions/04_wordcount.R")
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

ts_plot(timeline, "days", group = "is_retweet")



# Some text analysis --------------------------------------------------------
# Cleans data
timeline_top100 <- twitter_words(timeline, rank = 100)
week_top100 <- twitter_words(data_week_bioinf, rank = 100)
# Plots data
colorlist <- wes_palette("Cavalcanti1", 80, type = "continuous")

wordcloud2(data = timeline_top100, size = 1,
           color = colorlist)

wordcloud2(data = week_top100, size = 1,
           color = colorlist)

export(timeline_top100, here("03_rawdata", "week_count_top.RData"))




# Barcharts ---------------------------------------------------------------
source <- timeline %>% 
  select(source) %>% 
  count(source, sort = TRUE) %>% 
  slice(1:20) %>% 
  rename(variable = source)

export(location, here("03_rawdata", "location.RData"))
export(screen_name, here("03_rawdata", "screen_name.RData"))
export(source, here("03_rawdata", "source.RData"))

View(location)

source %>% 
  ggplot(aes(x = reorder(variable, -n), y = n, fill = variable)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position="none",
        axis.title.y = element_blank()) +
  scale_fill_manual(
    values = colorRampPalette(
      RColorBrewer::brewer.pal(n = 25, name = "Spectral"))(25),
    guide = guide_legend(reverse = TRUE))

