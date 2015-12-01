#GOP Candidate Information Cleaning 

gop_data <- read.csv("rawdata/twitter_debate.csv")
summary(gop_data)
head(gop_data)



#Campaign Contribution Cleaning 

campaign_contribution <- read.csv("rawdata/P00000001-ALL.csv")
summary(campaign_contribution)

campaign_something <- read.csv("rawdata/P00000001D-ALL.csv")



#Polling information
polling <- read.csv("rawdata/2016-national-gop-primary.csv")


#Combining Cleaned data 

#merge all dataframes here and then write it to a csv file
write.csv(file = "data/republican_race.csv", combined_df here)