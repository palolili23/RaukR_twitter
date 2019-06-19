selects_screen_name <- function(data, number) {
  users <- data %>%
    count(screen_name) %>%
    arrange(desc(n)) %>%
    pull(screen_name)
  return(users)
}

sample_users <- function(data, number) {
  users_sample <- sample(data, number)
  return(users_sample)
}

top_users <- function(data, number) {
  top_users <- data %>%
    count(screen_name) %>%
    arrange(desc(n)) %>%
    top_n(number) %>%
    pull(screen_name)
  return(top_users)
}
