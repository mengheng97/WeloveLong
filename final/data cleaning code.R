# import libraries
library(dplyr)
library(tibble)
library(lubridate)
library(readr)
library(stringr)

# import datasets
raw_movies <- read.csv("tmdb_5000_movies.csv",stringsAsFactors = FALSE)
raw_credits <- read.csv("tmdb_5000_credits.csv",stringsAsFactors = FALSE)
top50_companies <- read_csv("top50_companies.csv")


# clean movies dataset
movies <- raw_movies %>% 
  select(-c(homepage, keywords, original_title, overview, spoken_languages, tagline)) %>%
  filter(budget!=0 & revenue!=0 & status=="Released" & runtime!=0 & original_language=="en")
movies <- add_column(movies, month=month(movies$release_date), .before="revenue")

# clean credits dataset
credits <- raw_credits %>% select(-crew)
colnames(credits)[1] <- "id"

#Creating the list of names inside each company
values <- top50_companies$`Production Companies`


inTop50<- function(a){
  company <- a$production_companies
  #Extracting companies out and putting them in a list
  names1 <- str_match_all(company, "name\":\\s*(.*?)\\s*\",")[[1]][,2]
  names1 <- gsub("\"", "", names1)
  
  #Checking whether it exists
  return(ifelse(any(names1%in%values), 1, 0))
}

for (row in 1:nrow(movies)) {
  movies$production_companies[row] <- inTop50(movies[row,])
}


#clean productioncrew dataset
index <- df
movies$production_companies <- movies$ 

# merge both datasets
df <- inner_join(movies, credits, by=c("id", "title"))


