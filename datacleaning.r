install.packages("choroplethr")
library('choroplethr')
install.packages("choroplethrMaps")
library('choroplethrMaps')
install.packages('tm')
library(tm)
install.packages('RColorBrewer')
library(RColorBrewer)
install.packages('wordcloud')
library(wordcloud)
install.packages('ggplot2')
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("caret")
library(caret)
install.packages("GGally")
library(GGally)
install.packages("rmarkdown")
library(rmarkdown)



#loading the dataset and only the required variables
loan <- read.csv('loan.csv')
loan = loan %>%
  select(loan_status , loan_amnt , funded_amnt, installment, int_rate, issue_d , grade , sub_grade, purpose, addr_state, dti, 
         emp_length , home_ownership ,annual_inc , term)

str(loan)
loan

loan<- na.omit(loan)

#Horizontal stacked bar graph for Total Number for loan_status labels
loan %>%
  count(loan_status) %>%
  ggplot(aes(x = reorder(loan_status , desc(n)) , y = n , fill = n)) + 
  geom_col() + 
  coord_flip() + 
  labs(x = 'Loan Status' , y = 'Count')


#BoxPlot for Interest Rate vs Grade #not working
ggplot(loan , aes(x = grade , y = int_rate , fill = grade)) + 
  geom_boxplot() + 
  theme_igray() + 
  labs(y = 'Interest Rate' , x = 'Grade')


#Word-Cloud for Loan-Purpose
text <- Corpus(VectorSource(loan$purpose))
text <- tm_map(text, tolower) # might simplify the vector
text <- tm_map(text, removePunctuation)
tdm <- TermDocumentMatrix(text) # turn it into a term document matrix
m <- as.matrix(tdm)  
freq <- sort(rowSums(m), decreasing = TRUE)
wordcloud(words = names(freq), freq = freq, min.freq = 1, random.order = FALSE, 
          col=brewer.pal(8, "Paired"), max.words=10000000, rot.per=.30)


#----This code is not working-----#
#Date Issued vs Amount, with hues for grades # no proper output
amnt_df_grade <- loan %>% 
  select(issue_d, loan_amnt, grade) %>% 
  group_by(issue_d, grade) %>% 
  summarise(Amount = sum(loan_amnt))

ts_amnt_grade <- ggplot(amnt_df_grade, aes(x = issue_d, y = Amount))

ts_amnt_grade + 
  geom_area(aes(fill=grade)) +
  geom_line()+
  xlab("Date issued") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
#----this code is not working-----#




#Box-Plot for Loan Amount vs Loan Status 
box_status <- ggplot(loan, aes(loan_status, loan_amnt))
box_status + geom_boxplot(aes(fill = loan_status)) +
  theme(axis.text.x = element_blank()) +
  labs(list(
    title = "Loan amount by status",
    x = "Status",
    y = "Amount")) + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))




#Graph: Amount vs Date issued #not working
loan$issue_d <- as.Date(gsub("^", "01-", loan$issue_d), format="%d-%b-%Y")
amnt_df <- loan %>% 
  select(issue_d, loan_amnt) %>% 
  group_by(issue_d) %>% 
  summarise(Amount = sum(loan_amnt))

ts_amnt <- ggplot(amnt_df, 
                  aes(x = issue_d, y = Amount))
ts_amnt + geom_line() + xlab("Date issued") + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
suppressPackageStartupMessages(library(maps))




#Heat Map for states 
loan$region <- loan$addr_state
loan$region <- as.factor(loan$region)
levels(loan$region)<- c("alaska", "alabama","arkansas", "arizona", "california","colorado","connecticut","district of columbia","delaware","florida","georgia","hawaii","iowa","idaho","illinois","indiana","kansas","kentucky","louisiana","massachusetts","maryland","maine","michigan","minnesota","missouri","mississippi","montana","north carolina","north dakota","nebraska","new hampshire","new jersey","new mexico","nevada","new york","ohio","oklahoma","oregon","pennsylvania","rhode island","south carolina","south dakota","tennessee","texas","utah","virginia","vermont","washington","wisconsin","west virginia","wyoming")
state_by_volume <-
  loan %>% group_by(region) %>%
  summarise(value = n())
state_choropleth(state_by_volume, title = "Volume by State")


#scatterplot
plot(loan$loan_amnt,loan$int_rate, main="Scatterplot Example", xlab="loan amount ", ylab="interest rate", pch=19)

# Summary for the Dataset
summary(loan)

#Number of Rows and Columns 
NROW(loan)
NCOL(loan)

#Column Names
colnames(loan)

#Dimensions of the Dataset
dim(loan)

#First and Last 6 rows of the Dataset
head(loan)
tail(loan)

#Data for the top 4 States
stateCA = loan[loan$addr_state== 'CA',]
stateCA
stateNY = loan[loan$addr_state== 'NY',]
stateNY
stateTX = loan[loan$addr_state== 'TX',]
stateTX
stateFL = loan[loan$addr_state== 'FL',]
stateFL









#Applying tests
#calculating the covariance between variables
measure <-structure(list(v1 = 1:25, v2 = c(2500L, 30000L, 5000L, 4000L, 30000L, 5550L,
                                           2000L, 6000L, 5000L, 6000L, 5500L, 28000L, 11200L, 6500L, 22000L, 3500L, 7000L, 25000L, 16000L,
                                           13000L,10000L,13000L,9600L,3500L,16000L), 
                         v3 = c(13.56, 18.94, 17.97, 18.94, 16.14, 15.02, 17.97, 13.56, 17.97, 14.47, 22.35, 11.31, 8.19, 17.97, 12.98, 16.14, 12.98, 16.91, 20.89, 14.47,13.56,14.47,23.4,20.89,26.31), 
                         v4 = c(18.24,326.52, 10.51, 16.74, 26.35, 37.94, 2.4, 30.1, 21.16, 17.43, 15.94, 22.01, 23.6, 28.78, 11.19, 13.63,15.2, 6.26, 27.57, 26.16,10.62,10.58,23.01,9.09,33.62),
                         v5=c(55000L, 90000L, 59280L, 92000L, 57250L,152500L,51000L,65000L,53580L,300000L,50000L,70000L,65000L,154000L,65000L,80000L,102500L,23878L,120000L,75000L,65000L,55000L,65000L,40000L,33000L)), .Names = c("V1", "V2", "V3","V4","V5"), class = "data.frame", row.names = c(NA, -25L))
measure <- measure[,-1]
names(measure) <- c("loan_amnt", "int_rate", "dti","annual_inc")
x <- dist(scale(measure[, c("loan_amnt", "int_rate", "annual_inc")],
                center = FALSE))
as.dist(round(as.matrix(x), 2)[1:12, 1:12])
x <- measure[, c("loan_amnt", "int_rate", "dti","annual_inc")]
x
cm <- colMeans(x) #calculating the means of the columns
S <- cov(x)
S
d <- apply(x, MARGIN = 1, function(x)t(x - cm) %*% solve(S) %*% (x - cm))
d

#Scatterplot: Interest Rate vs Grade
plot(loan$int_rate, loan$grade, main="Scatterplot",
     xlab="Interest Rate ", ylab="Grade ", pch=19)

#Scatterplot: dti vs Grade
plot(loan$dti, loan$grade, main="Scatterplot",xlab= "dti",ylab= "grade", pch=19)

#Scatterplot: Loan Amount vs installment

plot(loan$loan_amnt, loan$installment, main="Scatterplot", xlab=" Loan Amount ", ylab="Installment ", pch=19)

