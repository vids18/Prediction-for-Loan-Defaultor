install.packages("dplyr")
library(dplyr)

install.packages('ggplot2')
library(ggplot2)

install.packages('corrplot')
library(corrplot)

install.packages('factoextra')
library(factoextra)

install.packages("fpp2")
library(fpp2)

library(stringr)

install.packages("knitr")
library(knitr)

install.packages("tidyverse")
install.packages("choroplethr")
install.packages("choroplethrMaps")

library(choroplethr)
library(choroplethrMaps)
library(tidyverse)

install.packages('tm')
library(tm)

install.packages('RColorBrewer')
library(RColorBrewer)

install.packages('wordcloud')
library(wordcloud)

install.packages("caret")
library(caret)

install.packages("GGally")
library(GGally)

install.packages("rmarkdown")
library(rmarkdown)

install.packages("MASS")
library(MASS)

loan <- read.csv('sub1.csv')


attach(loan)
# check the NA's in the columns
hm_na <- data.frame(sapply(loan, function(y) sum(length(which(is.na(y))))))
hm_na

## Remove all observations with at least one NA in a row
loan <- loan[, colSums(is.na(loan))<= 0.6*nrow(loan)]
View(loan)

## Remove all observations with at least one NA in a row
loan <- na.omit(loan)
View(loan)

#to check the kind of data remaining
str(loan)

## Filter database to observations where loan was 'Fully_paid', or 'Charged_off'
unique(loan$loan_status)
loan <- loan %>% dplyr::select(everything()) %>% 
  filter(loan$loan_status %in% c("Fully Paid", "Charged Off"))
View(loan)

## Filter database to individual applicants
unique(loan$application_type)
loan <- loan %>% dplyr::select(everything()) %>%
  filter(application_type %in% c("Individual"))
View(loan)

###################################yaha se aage eda daal de


#Horizontal stacked bar graph for Total Number for loan_status
loan %>%
  count(loan_status) %>%
  ggplot(aes(x = reorder(loan_status , desc(n)) , y = n , fill = n)) + 
  geom_col() + 
  coord_flip() + 
  labs(x = 'Loan Status' , y = 'Count')


#BoxPlot for Interest Rate vs Grade 
ggplot(loan , aes(x = grade , y = int_rate , fill = grade)) + 
  geom_boxplot() + 
  theme_grey() + 
  labs(y = 'Interest Rate' , x = 'Grade')

#Word-Cloud for Loan-Purpose
text <- Corpus(VectorSource(purpose))
text <- tm_map(text, tolower) # might simplify the vector
text <- tm_map(text, removePunctuation)
tdm <- TermDocumentMatrix(text) # turn it into a term document matrix
m <- as.matrix(tdm)  
freq <- sort(rowSums(m), decreasing = TRUE)
wordcloud(words = names(freq), freq = freq, min.freq = 1, random.order = FALSE, 
          col=brewer.pal(8, "Paired"), max.words=10000000, rot.per=.30)

#---Output not visible properly----#
#Date Issued vs Amount, with hues for grades # no proper output
amnt_df_grade <- loan%>%select(issue_d, loan_amnt, grade) %>% 
  group_by(issue_d, grade) %>% 
  summarise(Amount = sum(loan_amnt))

ts_amnt_grade <- ggplot(amnt_df_grade, aes(x = issue_d, y = Amount))
ts_amnt_grade + 
  geom_area(aes(fill=grade)) +
  geom_line()+
  xlab("Date issued") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#Box-Plot for Loan Amount vs Loan Status 
box_status <- ggplot(loan, aes(loan_status, loan_amnt))
box_status + geom_boxplot(aes(fill = loan_status)) +
  theme(axis.text.x = element_blank()) +
  labs(list(
    title = "Loan amount by status",
    x = "Status",
    y = "Amount")) + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#Graph: Amount vs Date issued #no proper output
loan$issue_d <- as.Date(gsub("^", "01-", loan$issue_d), format="%d-%b-%Y")
amnt_df = loan%>% 
  select(loan$issue_d, loan$loan_amnt) %>% 
  group_by(loan$issue_d) %>% 
  summarise(Amount = sum(loan$loan_amnt))

ts_amnt <- ggplot(amnt_df, 
                  aes(x = issue_d, y = Amount))
ts_amnt + geom_line() + xlab("Date issued") + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
suppressPackageStartupMessages(library(maps))

#Heat Map for states
loan$region <- loan$addr_state
loan$region <- as.factor(loan$region)
levels(loan$region)<- c("alaska", "alabama","arkansas", "arizona", "california","colorado","connecticut","district of columbia","delaware","florida","georgia","hawaii","iowa","idaho","illinois","indiana","kansas","kentucky","louisiana","massachusetts","maryland","maine","michigan","minnesota","missouri","mississippi","montana","north carolina","north dakota","nebraska","new hampshire","new jersey","new mexico","nevada","new york","ohio","oklahoma","oregon","pennsylvania","rhode island","south carolina","south dakota","tennessee","texas","utah","virginia","vermont","washington","wisconsin","west virginia","wyoming")
state_by_volume <-
  loan%>% group_by(region) %>%
  summarise(value = n())
state_choropleth(state_by_volume, title = "Volume by State")

#scatterplot
plot(loan_amnt,int_rate, main="Scatterplot", xlab="loan amount ", ylab="interest rate", pch=19)

#Ans: The graph isn't a straight line so you cannot differentiate between these two variables


#Scatterplot: Interest Rate vs Grade 
plot(int_rate, grade, main="Scatterplot",xlab="Interest Rate ", ylab="Grade ", pch=19)

#Scatterplot: dti vs Grade #not working
plot(dti,grade, main="Scatterplot",xlab= "dti", ylab="grade",pch=19)

#Scatterplot: Loan Amount vs installment

plot(loan_amnt,installment, main="Scatterplot", xlab=" Loan Amount ", ylab="Installment ", pch=19)

#the scatterplot shows a linear relationship between the loan amount and installment so we can discard one variable.

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
stateCA = loan[addr_state== 'CA',]
stateCA
stateNY = loan[addr_state== 'NY',]
stateNY
stateTX = loan[addr_state== 'TX',]
stateTX
stateFL = loan[addr_state== 'FL',]
stateFL


#calculating the covariance between variables
measure <-structure(list(v1 = 1:25, v2 = c(2500L, 30000L, 5000L, 4000L, 30000L, 5550L,
                                           2000L, 6000L, 5000L, 6000L, 5500L, 28000L, 11200L, 6500L, 22000L, 3500L, 7000L, 25000L, 16000L,
                                           13000L,10000L,13000L,9600L,3500L,16000L), 
                         v3 = c(13.56, 18.94, 17.97, 18.94, 16.14, 15.02, 17.97, 13.56, 17.97, 14.47, 22.35, 11.31, 8.19, 17.97, 12.98, 16.14, 12.98, 16.91, 20.89, 14.47,13.56,14.47,23.4,20.89,26.31), 
                         v4 = c(18.24,326.52, 10.51, 16.74, 26.35, 37.94, 2.4, 30.1, 21.16, 17.43, 15.94, 22.01, 23.6, 28.78, 11.19, 13.63,15.2, 6.26, 27.57, 26.16,10.62,10.58,23.01,9.09,33.62),
                         v5=c(55000L, 90000L, 59280L, 92000L, 57250L,152500L,51000L,65000L,53580L,300000L,50000L,70000L,65000L,154000L,65000L,80000L,102500L,23878L,120000L,75000L,65000L,55000L,65000L,40000L,33000L)), .Names = c("V1", "V2", "V3","V4","V5"), class = "data.frame", row.names = c(NA, -25L))
measure <- measure[,-1]
names(measure) <- c("loan_amnt", "int_rate", "annual_inc")
x <- dist(scale(measure[, c("loan_amnt", "int_rate", "annual_inc")],
                center = FALSE))
as.dist(round(as.matrix(x), 2)[1:12, 1:12])

cm <- colMeans(x) #calculating the means of the columns
S <- cov(x)
S
corel <- cor(x)
corel

# 

d <- apply(x, MARGIN = 1, function(x)t(x - cm) %% solve(S) %% (x - cm))
d

str(loan)
#Performing T-test on our dataset

with(data=loan,t.test(loan_amnt[loan_status=="Fully Paid"],loan_amnt[loan_status=="Charged Off"],var.equal=TRUE))
#the p-value = 0.0000019 which is extremely small so the variable loan_amt plays a significant role in the prediction of loan_status i.e whether the person will default or not 


with(data=loan,t.test(int_rate[loan_status=="Fully Paid"],int_rate[loan_status=="Charged Off"],var.equal=TRUE))

# the p-value is extremely small so the variable int_rate plays a significant role in determining the loan_status i.e whether the person will default or not

with(data=loan,t.test(home_ownership[loan_status=="Fully Paid"],home_ownership[loan_status=="Charged Off"],var.equal=TRUE))
#this is an error: where  home_ownership is a categorical variable and loan_status is a categorical variable too

with(data=loan,t.test(annual_inc[loan_status=="Fully Paid"],annual_inc[loan_status=="Charged Off"],var.equal=TRUE))

#the p-value is extremely small and it depicts annual_inc and loan_status to be significantly related to each other

with(data=loan,t.test(term[loan_status=="Fully Paid"],term[loan_status=="Charged Off"],var.equal=TRUE))
#both the variables here are categorical here so we cannot perform t-test

with(data=loan,t.test(addr_state[loan_status=="Fully Paid"],addr_state[loan_status=="Charged Off"],var.equal=TRUE))
#both the variables here are categorical here so we cannot perform t-test

#Testing using chi square
# Chi square test is applied when we have categorical variables in our dataset.
#loan_status and home_ownership
tbl <- table(loan_status, home_ownership)
tbl
chisq.test(tbl)
#the p-value is <0.05 i.e the two variables contribute in predicting the loan defaultor


#term and loan_status
tbl <- table(loan_status, term)
tbl
chisq.test(tbl)
#the p-value is <0.05 i.e the two variables contribute in predicting the loan defaultor

#addr_state and loan_status
tbl <- table(loan_status, addr_state)
tbl
chisq.test(tbl)
#the p values is greater than 0.056, ie we reject the null hypothesis and addr_state doesnt' contribute in determining the loan defaultor.

view(loan)









####################################### yaha categorization start horay
names(loan)
loan = loan %>% select(loan_status , loan_amnt , funded_amnt, installment, int_rate, issue_d , grade , purpose, dti, 
                       emp_length , home_ownership ,annual_inc , term)
View(loan)

## Binarization of Term  36 <- 1 and 60 <- 0
unique(loan$term)
loan$term <- as.integer(gsub("months", "", loan$term))
loan$term[loan$term == 36] <-  1
loan$term[loan$term != 1] <- 0

## Categorization of grade
unique(loan$grade)
loan$grade <- as.character(loan$grade)
loan$grade[loan$grade == "A"] <- 7 
loan$grade[loan$grade == "B"] <- 6
loan$grade[loan$grade == "C"] <- 5
loan$grade[loan$grade == "D"] <- 4
loan$grade[loan$grade == "E"] <- 3
loan$grade[loan$grade == "F"] <- 2
loan$grade[loan$grade == "G"] <- 1
loan$grade <- as.integer(loan$grade)

## Clearance of emp_length variable
unique(loan$emp_length)
loan$emp_length <- gsub("<", "", loan$emp_length)
loan$emp_length <- gsub("years", "", loan$emp_length)
loan$emp_length <- gsub("year", "", loan$emp_length)
loan$emp_length <- gsub("n/a", "", loan$emp_length)
loan$emp_length <- gsub(" ", "", loan$emp_length)
loan$emp_length <- gsub("\\+", "", loan$emp_length)
loan$emp_length <- ifelse(loan$emp_length =="", 10, loan$emp_length)
loan$emp_length <- as.integer(loan$emp_length)
unique(loan$emp_length)

## Binarization of home_ownership
unique(loan$home_ownership)
loan$home_ownership <- as.character(loan$home_ownership)
loan$home_ownership[loan$home_ownership=="OWN" | loan$home_ownership=="MORTGAGE"  ] <- 1       
loan$home_ownership[loan$home_ownership!=1] <- 0
loan$home_ownership <- as.numeric(loan$home_ownership)

##Purpose variable was binarize based on Lending Club offer and intuition. As one of these values reffers to personal needs and the other parts to financial issues. I decided to binarize this variable as shown in the below code.
## Binarization of purpose
unique(loan$purpose)
loan$purpose <- as.character(loan$purpose)
loan$purpose[loan$purpose == "home_improvement" | loan$purpose == "other" | loan$purpose == "moving" | loan$purpose == "vacation" | 
               loan$purpose == "major_purchase"| loan$purpose == "small_business"| loan$purpose == "car" | loan$purpose == "medical"|
               loan$purpose == "house" | loan$purpose == "renewable_energy" | loan$purpose == "wedding"] <- 1
loan$purpose[loan$purpose != 1] <- 0
loan$purpose <- as.numeric(loan$purpose)


## issue_d
head(loan$issue_d)
loan$issue_d <- as.character(loan$issue_d)
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
loan$issue_d <- substrRight(loan$issue_d, 4)
loan$issue_d <- as.numeric(loan$issue_d)

## Binarization of dependent variable loan_status
loan$loan_status <- as.character(loan$loan_status)
loan$loan_status[loan$loan_status == "Fully Paid"] <- 1
loan$loan_status[loan$loan_status != 1] <- 0
loan$loan_status <- as.numeric(loan$loan_status)

View(loan)
str(loan)


## Looking for correlation
Corr_ <- cor(loan)
corrplot(Corr_, method = "square", type = "upper")

##conclusion - We can see that loan_amnt, funded_amnt and installment are highly positively correlated. Also int_rate and grade are highly negatively correlated therefore we remove funded_amnt, installment and grade.

#PCA
ABC<- loan[,c("loan_amnt" , "int_rate", "issue_d" , "purpose", "dti", 
              "emp_length" , "home_ownership" ,"annual_inc" , "term")]
cor(ABC[,-1])

ABC.pca = prcomp(ABC[,-1], scale. = TRUE)
summary(ABC.pca)

fviz_eig(ABC.pca)
##########################################################################################################