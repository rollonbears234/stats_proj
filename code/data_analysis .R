#Data Analysis 

install.packages("devtools")
library(devtools)
install_github('arcdiagram', username = 'gastonstat')
library(arcdiagram)
library(ggplot2)
library(stringr)

#Analyza Tweets 
tweets <- read.csv("data/republican_race_tweets.csv", 
                   na.strings = c("", "NA"))


#Plotting Candidate and thier average confidence 
cand_v_conf <- aggregate(tweets$candidate.confidence,
          by=list(tweets$candidate), FUN=mean)

cand_v_conf <- cand_v_conf[-1,]
colnames(cand_v_conf) <- c("Candidate", "Avg_Confidence")
cand_v_conf$Avg_Confidence <- round(cand_v_conf$Avg_Confidence, 2)



#Not very helpful
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

 

#shows that Donald Trump got a majority of targeted Tweets, this will 
#skew some of the data since he represents such a large portion 
ggplot(data = tweets, aes(x = Candidate)) + 
         geom_histogram(binwidth = 1) +
  theme(axis.text.x = element_text(color="#993333", 
                                   size=12, angle=45)) + 
  ggtitle("Candidates Mentioned")


#sentiments, there are more negative than positive sentiments. Overwhelmingly so.
ggplot(data = tweets, aes(x = sentiment)) + 
  geom_histogram() + 
  ggtitle("Counts of Each Sentiment")

just_trump <- subset(tweets, Candidate == "Donald Trump")

ggplot(data = just_trump, aes(x = sentiment)) + 
  geom_histogram() + 
  ggtitle("Sentiment for Trump")

#Subjects covered in the debate.
ggplot(data = tweets, aes(x = subject_matter)) + 
  geom_histogram() + 
  ggtitle("Subject Matter ") +
  theme(axis.text.x = element_text(color="#993333", 
                                   size=10, angle=30)) 

#Hashtags, list only the most popular ones  
#ggplot(data = tweets, aes(x = hashtags_2)) +
#  geom_histogram() + 
#  ggtitle("All of the Hashtags") +
#  theme(axis.text.x = element_text(color="#993333", 
#                                   size=10, angle=30))

#Arcplot of connections between the candidates 
candidates_paired <- c()
cand_list <- levels(tweets$Candidate)
cand_list <- c(cand_list, "Carly Fiorina")
for (i in 1:(length(cand_list) - 1)) {
  for (j in (i + 1):(length(cand_list))) {
    candidates_paired <- rbind(candidates_paired, c(cand_list[i], 
                                                    cand_list[j]))  
  }
}
arcplot(candidates_paired)

cand_mention <- rep(0, times = 11)
names(cand_mention) <- cand_list
paired_count <- rep(0, times = 55)

all_names <- str_split(cand_list, " ")

for (i in 1:length(names(cand_mention))) {
  nameone <- all_names[[i]][1]
  nametwo <- all_names[[i]][2]
  cand_mention[i] <- length(grep(nameone, tweets$tweet_text)) + 
    length(grep(nametwo, tweets$tweet_text))
}

for (i in 1:length(paired_count)) {
  for (j in 1:2) {
    first_c1 <- str_split(candidates_paired[i,][1], " ")[[1]][1]
    last_c1 <- str_split(candidates_paired[i,][1], " ")[[1]][2]
    cand_2 <- str_split(candidates_paired[i,][2], " ")[[1]][j] 
    paired_count[i] <- length(grep(
      paste(first_c1, ".*",
            cand_2, "|", 
            cand_2, ".*",
            first_c1, sep = "")
      , tweets$tweet_text, ignore.case = TRUE)) +
      length(grep(
        paste(last_c1, ".*",
              cand_2, "|", 
              cand_2, ".*",
              last_c1, sep = "")
        , tweets$tweet_text, ignore.case = TRUE))
  }
}

paired_weight <- (paired_count / max(paired_count)) * 10
mention_weight <- (cand_mention / (max(cand_mention))) * 10

arcplot(edgelist = candidates_paired[,c(1,2)], 
        lwd.arcs = paired_weight, cex.nodes = mention_weight)



#Analysis Polling information 

polling <- read.csv("data/republican_race_polling.csv")

smaller_polling <- subset(polling, 
                          compare_date > as.POSIXct("2015-06-15 21:00:00", 
                                         format = "%Y-%m-%d %H:%M:%S"))

#Candidate polling 
ggplot(data = smaller_polling, aes(compare_date, color = "Candidates")) +
  ylab("Polling Percentage") +
  xlab("Dates after June 2015") +
  geom_line(aes(y = Trump, colour = "Trump")) + 
  geom_line(aes(y = Bush, colour = "Bush")) +  
  geom_line(aes(y = Huckabee, colour = "Huckabee")) + 
  geom_line(aes(y = Walker, colour = "Walker")) + 
  geom_line(aes(y = Cruz, colour = "Cruz")) + 
  geom_line(aes(y = Carson, colour = "Carson")) +
  theme(legend.background = element_rect(fill="gray90", size=.5, 
                                         linetype="dotted"))

polling_around_debate <-  subset(polling, 
          (compare_date > as.POSIXct("2015-08-01 21:00:00", 
            format = "%Y-%m-%d %H:%M:%S")) & 
          (compare_date < as.POSIXct("2015-08-15 21:00:00", 
            format = "%Y-%m-%d %H:%M:%S")))

#Spending around the time of the debate
ggplot(data = polling_around_debate, aes(compare_date, color = "Candidates")) +
  geom_line(aes(y = Trump, colour = "Trump", size = 1)) + 
  geom_line(aes(y = Bush, colour = "Bush", size = 1)) +  
  geom_line(aes(y = Huckabee, colour = "Huckabee", size = 1)) + 
  geom_line(aes(y = Walker, colour = "Walker", size = 1)) + 
  geom_line(aes(y = Cruz, colour = "Cruz", size = 1)) + 
  geom_line(aes(y = Carson, colour = "Carson", size = 1)) +
  geom_line(aes(y = Fiorina, colour = "Fiorina", size = 1)) +
  ylab("Polling Percentage") +
  xlab("Dates between 8/01/2015 - 8/15/15")
  


#Analysis of Expenditure Data 

expenditure <- read.csv("data/republican_race_campaign.csv")


timed <- subset(expenditure, 
              (rec_dat > as.POSIXct("2015-08-01", 
                          format = "%Y-%m-%d")) & 
              (rec_dat < as.POSIXct("2015-08-15", 
                          format = "%Y-%m-%d")))

j = 1
new <- c()
for (i in toupper(word(cand_list, 2))) {
  new[j] <- sum(expenditure[expenditure$can_nam == i,]$agg_amo)
  j = j+1
}

df <- data.frame(word(cand_list, 2), new)
colnames(df) <- c("Candidate", "Expenditure")
df <- df[-7, ]

#pie chart of aggregate funding 
pie_funding <- ggplot(df, aes(x="", y = Expenditure, fill = Candidate)) +
  geom_bar(width = 1, stat = "identity") +
  ggtitle("Aggregate Funding")
pie_funding + coord_polar("y", start=0)

#Funding around the time of the debate
debate_spending <- ggplot(df, aes(y = Expenditure, 
                                  x = Candidate, fill = Candidate)) +
  geom_bar(stat = "identity") +
  ggtitle("Aggregate Funding Around Time of Debate")
debate_spending


#the main idea is to see if we can predict who did better by tweets, and then look at polling to see if this is true and
#control for confouding variabkes by looking at expenditure 



