#GOP Candidate Information Cleaning 

gop_tweets <- read.csv("rawdata/twitter_debate.csv")
summary(gop_tweets)
head(gop_tweets)

##Text
tweet_text <- gop_tweets$text
tweet_text <- gsub("RT @.+: ", "",tweet_text)
gop_tweets$tweet_text <- tweet_text


##Candidate
Candidate <- gop_tweets$candidate
Candidate <- gsub("No candidate mentioned", "NA", Candidate)
gop_tweets$Candidate <- Candidate


##Time and Date
gop_tweets$tweet_created <- gsub(" -0700$", "", gop_tweets$tweet_created)

time <- gop_tweets$tweet_created
time <- gsub("^2015-08-0[67] ", "", time)
gop_tweets$time <- time

date <- gop_tweets$tweet_created
date <- gsub(" -0700$", "", date)
date <- gsub(" [0123456789]{2}:[0123456789]{2}:[0123456789]{2}$", "", date)
date <- gsub("-", "/", date)
gop_tweets$date <- date

install.packages("chron")
library("chron")

gop_tweets$time <- chron(time = gop_tweets$time)

gop_tweets$date <- chron(date = gop_tweets$date, format = "y/m/d")

##Debate Time
start <- as.POSIXct("21:00:00", format="%H:%M:%S")

debate_time <- function(time, date) {
  for (i in length(gop_tweets$time)) {
    if (as.POSIXct(gop_tweets$tweet_created[1], format = "%Y-%m-%d %H:%M:%S") - as.POSIXct("2015-08-06 21:00:00", format = "%Y-%m-%d %H:%M:%S") > 0)
    {time[i] <- "During"}
  }
}



deb_time <- debate_time(time = gop_tweets$time)
deb_time

##Hashtags
library(stringr)
hashtags <- str_extract(gop_tweets$text, "#.*")
hashtags <- gsub(" [[:alpha:]].*", "", hashtags)
goptweets$hashtags <- hashtags


#Campaign Contribution Cleaning 

campaign_exp <- read.csv("rawdata/ind_expenditure.csv")
summary(campaign_exp)
head(campaign_exp)


#Polling information
polling <- read.csv("rawdata/polling.csv")
summary(polling)
head(polling)

##Polled Party
polled_party <- str_extract(polling$Population, "-.*")
polled_party <- gsub("- ", "", polled_party)
polling$polled_party <- polled_party

##Voters
voter <- str_extract(polling$Population, "^.* ")
voter <- gsub(" - ", "", voter)
polling$voter <- voter



#Combining Cleaned data


#merge all dataframes here and then write it to a csv file
#merge polling, campaign_exp, and gop_twitter, if you can even do that?? idk 
write.csv(file = "data/republican_race.csv", combined_df here)