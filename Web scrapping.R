url <- 'https://www.imdb.com/search/title/?count=100&release_date=2016,2016&title_type=feature'
read_html(url) -> webpage 
#Using CSS selectors to scrape the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')
rank_data <- html_text(rank_data_html)
head(rank_data)
#Data preprocessing
as.numeric(rank_data) -> rank_data
head(rank_data)

#Using CSS selectors to scrape the title section
title_data_html <- html_nodes(webpage,'.lister-item-header a')
title_data <- html_text(title_data_html)
head(title_data)

#Using CSS selectors to scrape the description section
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')
description_data <- html_text(description_data_html)
head(description_data)

#Data-Preprocessing:
description_data<-gsub("\n","",description_data)
head(description_data)

#Using CSS selectors to scrape the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')
runtime_data <- html_text(runtime_data_html)
head(runtime_data)

#Data-Preprocessing:

runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)
head(runtime_data)

#Using CSS selectors to scrape the Movie genre section
genre_data_html <- html_nodes(webpage,'.genre')
genre_data <- html_text(genre_data_html)
head(genre_data)

#Data-Preprocessing:
genre_data<-gsub("\n","",genre_data)

#Data-Preprocessing: 
genre_data<-gsub(" ","",genre_data)

#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)

#Convering each genre from text to factor
genre_data<-as.factor(genre_data)
head(genre_data)

#Using CSS selectors to scrape the IMDB rating section
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')
rating_data <- html_text(rating_data_html)
head(rating_data)

#Data-Preprocessing:
rating_data<-as.numeric(rating_data)
head(rating_data)

#Using CSS selectors to scrape the votes section
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
votes_data <- html_text(votes_data_html)
head(votes_data)

#Data-Preprocessing:
votes_data<-gsub(",","",votes_data)
votes_data<-as.numeric(votes_data)
head(votes_data)

#Using CSS selectors to scrape the directors section
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
directors_data <- html_text(directors_data_html)
head(directors_data)

#Data-Preprocessing:
directors_data<-as.factor(directors_data)

#Using CSS selectors to scrape the actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')
actors_data <- html_text(actors_data_html)
head(actors_data)

#Data-Preprocessing:
actors_data<-as.factor(actors_data)

#Combining all the lists to form a data frame
movies_df<-data.frame(Rank = rank_data, Title = title_data,Description = description_data, Runtime = runtime_data, Genre = genre_data, Rating = rating_data, Votes = votes_data)
                      
#Structure of the data frame

str(movies_df)

#data visualization 
library('ggplot2')

qplot(data = movies_df,Runtime,fill = Genre,bins = 30)

ggplot(movies_df,aes(x=Runtime,y=Rating))+geom_point(aes(size=Votes,col=Genre))
