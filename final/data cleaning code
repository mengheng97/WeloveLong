# import libraries
library(dplyr)
library(tibble)
library(lubridate)

# import datasets
raw_movies <- read.csv("tmdb_5000_movies.csv")
raw_credits <- read.csv("tmdb_5000_credits.csv")

# clean movies dataset
movies <- raw_movies %>% 
  select(-c(homepage, keywords, original_title, overview, spoken_languages, tagline)) %>%
  filter(budget!=0 & revenue!=0 & status=="Released" & runtime!=0 & original_language=="en")
movies <- add_column(movies, month=month(movies$release_date), .before="revenue")

# clean credits dataset
credits <- raw_credits %>% select(-crew)
colnames(credits)[1] <- "id"

# merge both datasets
df <- inner_join(movies, credits, by=c("id", "title"))
