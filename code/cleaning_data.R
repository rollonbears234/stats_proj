#add library
library(stringr)

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


##Time
gop_tweets$tweet_created <- gsub(" -0700$", "", gop_tweets$tweet_created)

time <- gop_tweets$tweet_created
time <- gsub("^2015-08-0[67] ", "", time)
gop_tweets$time <- time


##Date
date <- gop_tweets$tweet_created
date <- gsub(" -0700$", "", date)
date <- gsub(" ([0123456789]{2}:){2}[0123456789]{2}$", "", date)
date <- gsub("-", "/", date)
gop_tweets$date <- date


##Debate Time

debate_time <- function(time) {
  position <- rep(" ", times = length(gop_tweets$time))
  for (i in 1:length(gop_tweets$time)) {
    if (as.POSIXct(time[i], format = "%Y-%m-%d %H:%M:%S") - 
        as.POSIXct("2015-08-06 17:00:00", format = "%Y-%m-%d %H:%M:%S") > 0 & 
        as.POSIXct(time[i], format = "%Y-%m-%d %H:%M:%S") - 
        as.POSIXct("2015-08-06 23:00:00", format = "%Y-%m-%d %H:%M:%S") < 0) {
      position[i] <- "During"
    }
    if (as.POSIXct(time[i], format = "%Y-%m-%d %H:%M:%S") - 
        as.POSIXct("2015-08-06 17:00:00", format = "%Y-%m-%d %H:%M:%S") < 0) {
      position[i] <- "Before"
    } 
    else {
      position[i] <-  "After"
    }
  }
  return(position)
}

relative_time <- debate_time(time = gop_tweets$tweet_created)
gop_tweets$relative_time <- relative_time

##Hashtags
library(stringr)
hashtags <- str_extract(gop_tweets$text, "#.*")
hashtags <- gsub(" [[:alpha:]].*", "", hashtags)
hashtags <- gsub("@.* ", "", hashtags)
hashtags <- gsub("[.:?,@(-].*", "", hashtags)
gop_tweets$hashtags <- hashtags

#Hashtags_2
hashtags_2 <- gsub("#GOPDebate", "", gop_tweets$hashtags, ignore.case = TRUE)
hashtags_2 <- str_extract(hashtags_2, "#.*")
gop_tweets$hashtags_2 <- hashtags_2

#Campaign Contribution Cleaning 

expenditure <- read.csv("rawdata/ind_expenditure.csv")
summary(expenditure)
head(expenditure)

expenditure$can_nam <- gsub(",.*", "", expenditure$can_nam)
expenditure$can_nam <- toupper(expenditure$can_nam)
expenditure$agg_amo <- gsub("\\$", "", expenditure$agg_amo)
expenditure$agg_amo <- gsub(",", "", expenditure$agg_amo)
expenditure$agg_amo <- as.numeric(expenditure$agg_amo)

expenditure$rec_dat <- gsub("\\/", "-", expenditure$rec_dat)
newdate <- strptime(as.character(expenditure$rec_dat), "%m-%d-%Y")
newdate <- format(newdate, "%Y-%m-%d") 
as.POSIXct(newdate)
expenditure$rec_dat <- gsub(" PDT", "", newdate)

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

##Date and Time
date_time <- gsub("2000-01-01 ", "", polling$Entry.Date.Time..ET.)
date_time <- gsub(" UTC", "", date_time)
polling$date_time <- date_time


new_time <- c("")
for (i in 1:length(polling$Entry.Date.Time..ET.)) {
  new_time[i] <- as.POSIXct(polling$date_time[i], format = "%Y-%m-%d %H:%M:%S")
}
polling$compare_date <- new_time

##Date
date <- gsub(" .*$", "", polling$date_time)
polling$date <- date

#Combining Cleaned data
write.csv(file = "data/republican_race_polling.csv", polling)
write.csv(file = "data/republican_race_campaign.csv", expenditure)
write.csv(file = "data/republican_race_tweets.csv", gop_tweets)
