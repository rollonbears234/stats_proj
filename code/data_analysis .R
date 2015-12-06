#Data Analysis 

# install devtools
install.packages("devtools")

# load devtools
library(devtools)

# install arcdiagram
install_github('arcdiagram', username = 'gastonstat')

# load arcdiagram
library(arcdiagram)

library(ggplot2)

#Analyza Tweets 

tweets <- read.csv("data/republican_race_tweets.csv")


#Plotting Candidate and thier average confidence 
cand_v_conf <- aggregate(tweets$candidate.confidence,
          by=list(tweets$candidate), FUN=mean)

cand_v_conf <- cand_v_conf[-1,]

colnames(cand_v_conf) <- c("Candidate", "Avg_Confidence")


#why is No candidate mentioned not NA  
ggplot(data = cand_v_conf, aes(x = Candidate, y = Avg_Confidence)) + 
  geom_bar(stat="identity", width = .7) + 
  ylim(0, 1) +
  theme(axis.text.x = element_text(color="#993333", 
                                   size=10, angle=45)) + 
  ggtitle("Candidates' Average Confidence")

#find average candidate confidence. 
#I want to analyze confidence, sentiment, and then some hashtags 

#show that Donald Trump got a majority of targeted Tweets 
ggplot(data = tweets, aes(x = candidate)) + 
         geom_histogram(binwidth = 1)

ggplot(data = tweets, aes(x = sentiment)) + 
  geom_histogram()


#use Arcplot to pair mentions of candidates in tweets!! 


#Analysa Polling information 



#Analysa Expenditure Data 

expenditure <- read.csv("data/republican_race_campaign.csv")




#Putting them all toghether 