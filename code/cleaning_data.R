#GOP Candidate Information Cleaning 

gop_twitter <- read.csv("rawdata/twitter_debate.csv")
summary(gop_data)
head(gop_data)



#Campaign Contribution Cleaning 

campaign_exp <- read.csv("rawdata/ind_expenditure.csv")
summary(campaign_exp)
head(campaign_exp)


#Polling information
polling <- read.csv("rawdata/polling.csv")
summary(polling)
head(polling)

#Combining Cleaned data 

#merge all dataframes here and then write it to a csv file
#merge polling, campaign_exp, and gop_twitter, if you can even do that?? idk 
write.csv(file = "data/republican_race.csv", combined_df here)