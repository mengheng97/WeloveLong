# import libraries
library(XML)
library(RCurl)

# get production companies table
url <- "https://www.the-numbers.com/movies/production-companies/#production_companies_overview=l50:od1"
url_data <- getURL(url)
tables <- readHTMLTable(url_data, stringsAsFactors=FALSE)
companies <- as.data.frame(tables[[1]])[1:50,]

write.csv(companies, file="top50_companies.csv")