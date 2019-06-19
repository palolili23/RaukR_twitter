twitter_words <- function(data, rank) {

text <- timeline %>% 
  mutate(text2 = gsub("^RT:?\\s{0,}|#|@\\S+|https?[[:graph:]]+", "", text),
         text2 = tolower(text2),
         text2 = gsub("^\\s{1,}|\\s{1,}$", "", text2),
         text2 = gsub("\\s{2,}", " ", text2)) %>% 
  pull(text2)

words <- get_tokens(text, pattern = "\\W")
stopwords <- rcorpora::corpora("words/stopwords/en")$stopWords

words <- as_tibble(words)

words_count <- words %>% 
  filter(!value %in% stopwords) %>% 
  count(value, sort = TRUE) %>% 
  slice(1:rank)

return(words_count)
}

# week_top100 <- twitter_words(data_week_bioinf, rank = 100)
