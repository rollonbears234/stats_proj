#Data Analysis 

install.packages("devtools")
library(devtools)
install_github('arcdiagram', username = 'gastonstat')
library(arcdiagram)
library(ggplot2)

#Analyza Tweets 
tweets <- read.csv("data/republican_race_tweets.csv")


#Plotting Candidate and thier average confidence 
cand_v_conf <- aggregate(tweets$candidate.confidence,
          by=list(tweets$candidate), FUN=mean)

cand_v_conf <- cand_v_conf[-1,]
cand_v_conf$Avg_Confidence <- round(cand_v_conf$Avg_Confidence, 2)
colnames(cand_v_conf) <- c("Candidate", "Avg_Confidence")


#why is No Candidate Mentioned not NA  
ggplot(data = cand_v_conf, aes(x = Candidate, y = Avg_Confidence)) + 
  geom_bar(stat="identity", width = .7) + 
  ylim(0, 1) +
  theme(axis.text.x = element_text(color="#993333", 
                                   size=10, angle=45)) + 
  ggtitle("Candidates' Average Confidence") + 
  geom_text(aes(label=Avg_Confidence), position=position_dodge(width=0.9), 
            vjust=-0.25)

summary(tweets$candidate.confidence) #notice 3rd Qu. is still 1. 
tweets$candidate[which.min(tweets$candidate.confidence)] #Not useful, a candidate wasn't mentioned 

 
#hashtags, and subject matter by candidate, like the max for each to see what each one talked about , arc diagram 
#maybe we should go back and look at what some of the data categories mean 
#also use the before and after thing, see if sentiments change 
#shows that Donald Trump got a majority of targeted Tweets, this will skew some of the data since he represents such a large portion 
ggplot(data = tweets, aes(x = candidate)) + 
         geom_histogram(binwidth = 1) +
  theme(axis.text.x = element_text(color="#993333", 
                                   size=12, angle=45)) + 
  ggtitle("Candidates Mentioned")


#sendiments, there are more negative than positive sentiments. overwhelmingly 
ggplot(data = tweets, aes(x = sentiment)) + 
  geom_histogram() + 
  ggtitle("Counts of Each Sentiment")


#use Arcplot to pair mentions of candidates in tweets!! 
#Go through the text, if two candidates appear then include them as a pair, then do an arc diagram on that
candidates_paired <- c()
cand_list <- levels(tweets$candidate)
cand_list <- cand_list[c(-1, -9)]
cand_list <- c(cand_list, "Carly Fioriana")
for (i in 1:(length(cand_list) - 1)) {
  for (j in (i + 1):(length(cand_list))) {
    candidates_paired <- rbind(candidates_paired, c(cand_list[i], cand_list[j]))  
  }
}
arcplot(candidates_paired)

#adding weights to the matrix to help color the arc diagram
#I want to have the nodes reflect candidate mentiones and lines to reflect who was mentioned in context 
cand_mention <- rep(0, times = 11)
names(cand_mention) <- cand_list
paired_count <- rep(0, times = 55)
for (tweet in tweets$tweet_text) {
  
}
paired_weight <- (paired_count / max(paired_count)) * 10
mention_weight <- (cand_mention / (max(cand_mention))) * 10

#even out the weight, do like (pairedcount / max(paired_count)) * 10
arcplot(edgelist = candidates_paired[,c(1,2)], lwd.arcs = paired_count, cex.nodes = cand_mention)



#Analysa Polling information 

#it would be cool to make on line graph with at least fice of the top candidates 
#do one for the broad dates and one that is centered around the first debate, compare before and after 
polling <- read.csv("data/republican_race_polling.csv")

#ablines for each candidate 
#average over every source !!
avg_polling_trump <- aggregate(polling$Trump,
                         by=list(polling$Pollster), FUN=mean)
ggplot(data = polling, aes(Entry.Date.Time..ET.)) +
  geom_line(aes(y = Trump, colours = "Trump"))




#Analysa Expenditure Data 

#you should just see who is gettin the most money and look at only the money given around the debate and see if it impacts pollling
expenditure <- read.csv("data/republican_race_campaign.csv")




#the main idea is to see if we can predict who did better by tweets, and then look at polling to see if this is true and
#control for confouding variabkes by looking at expenditure 

#then run a test for significance 


