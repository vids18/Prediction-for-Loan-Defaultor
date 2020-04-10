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

install.packages("stringr")
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
# View(loan)
#Since there are 6.9 million rows and about 145 variables we are trying to get rid of some of the redundant variables and observations
hm_na <- data.frame(sapply(loan, function(y) sum(length(which(is.na(y))))))
#View(loan)
hm_na

## Check all observations with at least one NA in a row
loan <- loan[, colSums(is.na(loan))<= 0.6*nrow(loan)]
#View(loan)

#the loan data fram has 697957 observations of 117 variables

## Removing all observations with at least one NA in a row
loan <- na.omit(loan)
#View(loan)

#The loan data frame has 142301 observations of 117 variables
#[(697957-142301)/697957] * 100= 79% of the observations have been removed


#check the kind of data present in your dataset
str(loan)


## Filter database to observations where loan was 'Fully_paid', or 'Charged_off'

#first we need to check various levels present in our variable loan_status
unique(loan_status)

library(dplyr)
loan <- loan %>% dplyr::select(everything()) %>% 
  filter(loan_status %in% c("Fully Paid", "Charged Off"))
#View(loan)

## Filter observations for only individual applicants
unique(application_type)
loan <- loan %>% dplyr::select(everything()) %>%
  filter(application_type %in% c("Individual"))
#View(loan)

#ncol(loan)
#there are 117 variables

#nrow(loan)
#there are 137018 observations currently 

################ Exploratory Data Analysis ##############################

library(ggplot2)
#Horizontal stacked bar graph for Total Number for loan_status
loan %>%
  count(loan_status) %>%
  ggplot(aes(x = reorder(loan_status , desc(n)) , y = n , fill = n)) + 
  geom_col() + 
  coord_flip() + 
  labs(x = 'Loan Status' , y = 'Count')
#Conclusion: 1 denotes the loan which is fully paid while 0 denotes that loan is charged off

#BoxPlot for Interest Rate vs Grade 
ggplot(loan , aes(x = grade , y = int_rate , fill = grade)) + 
  geom_boxplot() + 
  theme_grey() + 
  labs(y = 'Interest Rate' , x = 'Grade')


#Word-Cloud for Loan-Purpose
library(wordcloud)
library(corpcor)
library(tm)
attach(loan)


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
library(dplyr)
library(ggplot2)

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
library(ggplot2)
box_status <- ggplot(loan, aes(loan_status, loan_amnt))

box_status + geom_boxplot(aes(fill = loan_status)) +
  theme(axis.text.x = element_blank()) +
  labs(list(
    title = "Loan amount by status",
    x = "Status",
    y = "Amount")) + scale_y_continuous(labels = function(x) format(x, scientific = FALSE))


#Heat Map for states
library(dplyr)
library(choroplethr)
library(choroplethrMaps)
loan$region <- loan$addr_state

loan$region <- as.factor(loan$region)

levels(loan$region)<- c("alaska", "alabama","arkansas", "arizona", "california","colorado","connecticut","district of columbia","delaware","florida","georgia","hawaii","iowa","idaho","illinois","indiana","kansas","kentucky","louisiana","massachusetts","maryland","maine","michigan","minnesota","missouri","mississippi","montana","north carolina","north dakota","nebraska","new hampshire","new jersey","new mexico","nevada","new york","ohio","oklahoma","oregon","pennsylvania","rhode island","south carolina","south dakota","tennessee","texas","utah","virginia","vermont","washington","wisconsin","west virginia","wyoming")

state_by_volume <-loan%>% group_by(region) %>%
  summarise(value = n())

state_choropleth(state_by_volume, title = "Volume by State")


#scatterplot
plot(loan_amnt,int_rate, main="Scatterplot", xlab="loan amount ", ylab="interest rate", pch=19)

#Ans: The graph isn't a straight line so you cannot differentiate between these two variables


#Scatterplot: Interest Rate vs Grade 
plot(int_rate, grade, main="Scatterplot",xlab="Interest Rate ", ylab="Grade ", pch=19)

#Scatterplot: dti vs Grade 
plot(dti,grade, main="Scatterplot",xlab= "dti", ylab="grade",pch=19)

#Scatterplot: Loan Amount vs installment

plot(loan_amnt,installment, main="Scatterplot", xlab=" Loan Amount ", ylab="Installment ", pch=19)

#the scatterplot shows a linear relationship between the loan amount and installment so we can discard one variable.
# View(loan) #the issue_d is in the date format
# Summary for the Dataset
summary(loan)
#View(loan)




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
#########################################################

############ calculating the covariance between variables##############
#################Code not working properly

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


########### end of code ########################

##################### categorization of our data #######################
#names(loan)
install.packages("dplyr")
library(dplyr)

# View(loan) #130718 obs of 118 variables
#selection of the variables desired 
loan = loan %>% select(loan_status , loan_amnt , funded_amnt, installment, int_rate, issue_d , grade , purpose, dti, 
                       emp_length , home_ownership ,annual_inc , term)
#View(loan) 

#, addr_state, region, title, sub_grade


#Here we have 130718 rows and 13 variables



## Binarization of Term variable to either 1(36months) and 0(60 months)
attach(loan)
unique(term)
loan$term <- as.numeric(gsub("months", "", loan$term))
loan$term[loan$term == 36] <-  1
loan$term[loan$term != 1] <- 0

#View(loan)
str(loan$term)
#the term has now has been converted to numeric values

## Performing Categorization of grade
unique(grade)
loan$grade <- as.character(loan$grade) #setting the grade in terms of alphabets
loan$grade[loan$grade == "A"] <- 7 
loan$grade[loan$grade == "B"] <- 6
loan$grade[loan$grade == "C"] <- 5
loan$grade[loan$grade == "D"] <- 4
loan$grade[loan$grade == "E"] <- 3
loan$grade[loan$grade == "F"] <- 2
loan$grade[loan$grade == "G"] <- 1
loan$grade <- as.numeric(loan$grade) #replacing these grades in terms of these numbers

str(loan$grade)
#the grade levels are now numeric values ranging from 1-7

## Clearance of emp_length variable
unique(emp_length) #there are initially 12 levels
loan$emp_length <- gsub("<", "", loan$emp_length)
loan$emp_length <- gsub("years", "", loan$emp_length)
loan$emp_length <- gsub("year", "", loan$emp_length)
loan$emp_length <- gsub("n/a", "", loan$emp_length)
loan$emp_length <- gsub(" ", "", loan$emp_length)
loan$emp_length <- gsub("\\+", "", loan$emp_length)
loan$emp_length <- ifelse(loan$emp_length =="", 10, loan$emp_length)
loan$emp_length <- as.numeric(loan$emp_length)

str(loan$emp_length)
#Removed all the special characters and the word "years/year" from
# the employee length so that now the employee_length is numeric values from 1-10

## Binarization of home_ownership
unique(loan$home_ownership)
loan$home_ownership <- as.character(loan$home_ownership)
loan$home_ownership[loan$home_ownership=="OWN" | loan$home_ownership=="MORTGAGE"  ] <- 1       
loan$home_ownership[loan$home_ownership!=1] <- 0 #RENT and ANY are considered 0
loan$home_ownership <- as.numeric(loan$home_ownership)

str(loan$home_ownership)
#home_ownersship is converted to numeric values 


##Purpose variable was binarize based on Lending Club offer and intuition. 
#As one of these values reffers to personal needs and the other parts to financial issues,
#we decided to binarize this variable as shown in the below code.
## Binarization of purpose
unique(loan$purpose)
loan$purpose <- as.character(loan$purpose)
loan$purpose[loan$purpose == "home_improvement" | loan$purpose == "other" | loan$purpose == "moving" | loan$purpose == "vacation" | 
               loan$purpose == "major_purchase"| loan$purpose == "small_business"| loan$purpose == "car" | loan$purpose == "medical"|
               loan$purpose == "house" | loan$purpose == "renewable_energy" | loan$purpose == "wedding"] <- 1
loan$purpose[loan$purpose != 1] <- 0
loan$purpose <- as.numeric(loan$purpose)
str(loan$purpose)

## issue_d #this code makes the issue_d column to all NA's
head(loan$issue_d)
loan$issue_d <- as.character(loan$issue_d)
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
loan$issue_d <- substrRight(loan$issue_d, 4)
loan$issue_d <- as.numeric(loan$issue_d)#NA's has been introuced here
View(loan$issue_d)
str(loan$issue_d)
#the issue_d has now been converted to numeric values


## Binarization of dependent variable loan_status
loan$loan_status <- as.character(loan$loan_status)
loan$loan_status[loan$loan_status == "Fully Paid"] <- 1
loan$loan_status[loan$loan_status != 1] <- 0
loan$loan_status <- as.numeric(loan$loan_status)
#View(loan)
str(loan$loan_status)
#loan status has now been converted to numeric values of 1 and 0





## Looking for correlation
install.packages("polycor")
library(polycor)
library(corrplot)
library(GGally)

#View(loan)
corr1 = cor(loan)#trying with all the variables
#Corr1 = cor(loan[-6]) #Used -6 as it points to the issue_d column
#typeof(Corr1)

ggcorr(corr1)
#trying to plot for all variables
#ggcorr(corr1)

#corrplot(Corr1, method = "square", type = "upper")
#tryng for all the variables
corrplot(corr1, method = "square", tytype = "upper")

##conclusion - We can see that loan_amnt, funded_amnt and installment are highly positively correlated. 
#Also int_rate and grade are highly negatively correlated 
#therefore we remove funded_amnt, installment and grade.

############ Performing Tests for similarity on our dataset ##########

#1) T-test on our dataset

with(data=loan,t.test(loan_amnt[loan_status==1],loan_amnt[loan_status==0],var.equal=TRUE))
#the p-value < 2.2e-16 which is extremely small so the variable loan_amt plays a significant role in the prediction of loan_status i.e whether the person will default or not 


with(data=loan,t.test(int_rate[loan_status==1],int_rate[loan_status==0],var.equal=TRUE))
# the p-value is extremely small so the variable int_rate plays a significant role in determining the loan_status i.e whether the person will default or not

with(data=loan,t.test(home_ownership[loan_status==1],home_ownership[loan_status==0],var.equal=TRUE))
# the p-value is extremely small so the variable home ownership plays a significant role in determining the loan_status i.e whether the person will default or not

with(data=loan,t.test(annual_inc[loan_status==1],annual_inc[loan_status==0],var.equal=TRUE))

#the p-value is extremely small and it depicts annual_inc and loan_status to be significantly related to each other

with(data=loan,t.test(term[loan_status==1],term[loan_status==0],var.equal=TRUE))
#the p-value is extremely small and it depicts loan status and term to be significantly related to each other


###################################################################################

#2) Chi square Test
# Chi square test is applied when we have categorical variables in our dataset.
attach(loan)
#View(loan)
#loan_status and home_ownership
tbl <- table(loan_status, home_ownership)
tbl

chisq.test(tbl)
#the p-value is <2.2e-16 i.e the two variables contribute in predicting the loan defaultor


#term and loan_status
tbl <- table(loan_status, term)
tbl
chisq.test(tbl)
#the p-value is <0.05 i.e the two variables contribute in predicting the loan defaultor


#View(loan) #130718 observations of 13 variables

######################################################################

################# Principal Component Analysis #################################
#Performing PCA
library(ggplot2)
library(factoextra)

#View(loan)
#I have removed the variable issue_d from the current consideration as the issue_d has all NA values which will impact
#our calculations in PCA
ABC<- loan[,c("loan_amnt" , "int_rate","issue_d","grade","purpose", "dti", 
              "emp_length" , "home_ownership" ,"annual_inc" , "term")]
#View(ABC)
#taking a subset of the dataset and only the desired variables

cor(ABC)
ABC[,1]

ABC.pca = prcomp(ABC, scale. = TRUE)
summary(ABC.pca)

fviz_eig(ABC.pca) #this will help us better visualize the PCA components
##########################################################################################################


############### Dendogram ###############################################
install.packages("cluster", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(cluster)
#View(loan)
# take a random sample of size 50 from a dataset of loan
# sample without replacement
mysample <- loan[sample(1:nrow(loan), 50,replace=FALSE),]

# Standardizing the data with scale()
matstd.loan<- scale(mysample[,c(1,4,5,8,9,11,12)])
# Creating a (Euclidean) distance matrix of the standardized data
dist.employ <- dist(matstd.loan, method="euclidean")
# Invoking hclust command (cluster analysis by single linkage method)
clusemploy.nn <- hclust(dist.employ, method = "single")

#Plotting

# Create extra margin room in the dendrogram, on the bottom (loan labels)
par(mar=c(8, 4, 4, 2) + 0.1)
# Object "clusemploy.nn" is converted into a object of class "dendrogram"
# in order to allow better flexibility in the (vertical) dendrogram plotting.
plot(as.dendrogram(clusemploy.nn),ylab="Distance",ylim=c(0,6),
     main="Dendrogram.")


# We will use agnes function as it allows us to select option for data standardization, the distance measure and clustering algorithm in one single function

(agn.employ <- agnes(mysample, metric="euclidean", stand=TRUE, method = "single"))
#View(agn.employ)

#  Description of cluster merging
agn.employ$merge

#Dendogram
plot(as.dendrogram(agn.employ), xlab= "Distance",xlim=c(8,0),
     horiz = TRUE,main="Dendrogram")

#Interactive Plots
plot(agn.employ,ask=TRUE)
plot(agn.employ, which.plots=2)

##################################################################################

################## Factor Analysis #########################
#View(ABC)

#calculating the correlation matrix for all the numeric data in our dataset
#so we are using the ABC matrix which has all these values
corrm.emp = cor(ABC)
corrm.emp
plot(corrm.emp)

#calculating the PCA and plotting these variances
euroemp_pca <- prcomp(ABC, scale=TRUE)
summary(euroemp_pca)
plot(euroemp_pca)

# A table containing eigenvalues and %'s accounted, follows. 
# Eigenvalues are the sdev^2
(eigen_euroemp <- round(euroemp_pca$sdev^2,2))
names(eigen_euroemp) <- paste("PC",1:8,sep="")
eigen_euroemp
sumlambdas <- sum(eigen_euroemp)
sumlambdas

propvar <- round(eigen_euroemp/sumlambdas,2)
propvar

cumvar_euroemp <- cumsum(propvar)
cumvar_euroemp
matlambdas <- rbind(eigen_euroemp,propvar,cumvar_euroemp)
matlambdas
rownames(matlambdas) <- c("Eigenvalues","Prop. variance","Cum. prop. variance")
rownames(matlambdas)
eigvec.emp <- euroemp_pca$rotation
print(euroemp_pca)
#Taking the first four PCs to generate linear combinations for all the variables with four factors
pcafactors.emp <- eigvec.emp[,1:4]
pcafactors.emp
# Multiplying each column of the eigenvector's matrix by the square-root of the corresponding eigenvalue in order to get the factor loadings
unrot.fact.emp <- sweep(pcafactors.emp,MARGIN=2,euroemp_pca$sdev[1:4],`*`)
unrot.fact.emp
# Computing communalities
communalities.emp <- rowSums(unrot.fact.emp^2)
communalities.emp
# Performing the varimax rotation. The default in the varimax function is norm=TRUE thus, Kaiser normalization is carried out
rot.fact.emp <- varimax(unrot.fact.emp)
#View(unrot.fact.emp)
rot.fact.emp
#The print method of varimax omits loadings less than abs(0.1). In order to display all the loadings, it is necessary to ask explicitly the contents of the object $loadings
fact.load.emp <- rot.fact.emp$loadings[1:8,1:4]
fact.load.emp
#Computing the rotated factor scores for the 30 European Countries. Notice that signs are reversed for factors F2 (PC2), F3 (PC3) and F4 (PC4)
scale.emp <- scale(ABC)
scale.emp
#this gives you an error
as.matrix(scale.emp)%*%fact.load.emp%*%solve(t(fact.load.emp)%*%fact.load.emp)

library(psych)
install.packages("psych", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(psych)
fit.pc <- principal(ABC, nfactors=4, rotate="varimax")
fit.pc
round(fit.pc$values, 3)
fit.pc$loadings
# Loadings with more digits
for (i in c(1,3,2,4)) { print(fit.pc$loadings[[1,i]])}
# Communalities
fit.pc$communality #we will look at the communalities to decide which 
#the total variance of TC= 0.87.....Its the 87% of the total variance of this variable is captured and RC1 is not able to capture the remaining 13%


# Rotated factor scores, Notice the columns ordering: RC1, RC3, RC2 and RC4
fit.pc$scores
# Play with FA utilities

fa.parallel(ABC) # See factor recommendation
fa.plot(fit.pc) # See Correlations within Factors
fa.diagram(fit.pc) # Visualize the relationship
vss(ABC) # See Factor recommendations for a simple structure

################ end of code ################################################

############ Multinomial Linear Regression ########################
#View(loan)
mysample = ABC
#View(ABC)
mysample = loan[,c("loan_status","loan_amnt" ,"installment", "int_rate","issue_d","grade","purpose", "dti", 
                   "emp_length" , "home_ownership" ,"annual_inc" , "term")]
mysample <- mysample[sample(1:nrow(mysample), 5000,replace=FALSE),]



#Multiple Regression
View(mysample)

# Performing multiple regression on DEF dataset
fit <- lm(loan_status~loan_amnt+installment+int_rate+
            issue_d+grade+purpose+dti+emp_length+home_ownership+
            annual_inc+term, data = mysample)
#show the results
summary(fit)

#ANS- By looking at the output we can figure out that int_rate and emp_length are insignificant

#Summary has three sections. Section1: How well does the model fit the data (before Coefficients). Section2: Is the hypothesis supported? (until sifnif codes). Section3: How well does data fit the model (again).
# Useful Helper Functions
coefficients(fit)
library(ggplot2)
install.packages("GGally")
library(GGally)
install.packages("tidyverse")
library(tidyverse)
# install.packages("rlang")
install.packages("https://cran.r-project.org/src/contrib/Archive/rlang/rlang_0.4.4.tar.gz", repo=NULL, type = "source")
install.packages("caret")
library(caret)
ggpairs(data=mysample, title="Loan Data")
#install.packages("GGally", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(GGally)
# ggpairs(data=mtcars, title="Cars Data")
confint(fit,level=0.95)
# Predicted Values
fitted(fit)
residuals(fit)
#Anova Table
anova(fit)

#Anova fit tells me that installment, purpose, emp_length are non-significant


#dont worry for next two lines
vcov(fit)
cov2cor(vcov(fit))
#acting as outliers for your dataset
temp <- influence.measures(fit)
temp
#View(temp) #there are some values which is starred because they have highest residual compared to their y-value

#diagnostic plots
plot(fit)
# Assessing Outliers
library(car)
outlierTest(fit)
qqPlot(fit, main="QQ Plot")
leveragePlots(fit) # leverage plots
# Influential Observations
# added variable plots
avPlots(fit)
# Cook's D plot
# identify D values > 4/(n-k-1)
cutoff <- 4/((nrow(mtcars)-length(fit$coefficients)-2))
plot(fit, which=4, cook.levels=cutoff)
# Influence Plot
influencePlot(fit, id.method="identify", main="Influence Plot", sub="Circle size is proportial to Cook's Distance" )
# Normality of Residuals
# qq plot for studentized resid
qqPlot(fit, main="QQ Plot")
# distribution of studentized residuals
library(MASS)
sresid <- studres(fit)
hist(sresid, freq=FALSE,
     main="Distribution of Studentized Residuals")
xfit<-seq(min(sresid),max(sresid),length=40)
yfit<-dnorm(xfit)
lines(xfit, yfit)
#Non-constant Error Variance
# Evaluate homoscedasticity
# non-constant error variance test
ncvTest(fit)
# plot studentized residuals vs. fitted values
spreadLevelPlot(fit)
#Multi-collinearity
# Evaluate Collinearity
vif(fit) # variance inflation factors
sqrt(vif(fit)) > 2 # problem?
#Nonlinearity
# component + residual plot
crPlots(fit)
# Ceres plots
ceresPlots(fit)
#Non-independence of Errors
# Test for Autocorrelated Errors
durbinWatsonTest(fit)
# Global test of model assumptions
library(gvlma)
install.packages("gvlma", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(gvlma)
gvmodel <- gvlma(fit)
summary(gvmodel)
fit
summary(fit)
fit1 <- fit
fit2 <- lm(loan_status~loan_amnt+installment+
             issue_d+grade+purpose+dti+emp_length+home_ownership+
             annual_inc+term, data = mysample)
#Removing interest rate from the fit
# compare models
anova(fit1, fit2)

#add this library so your step AIC function will work
library(MASS)
step <- stepAIC(fit, direction="both")
step$anova # display results
install.packages("leaps", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(leaps)
leaps<-regsubsets(loan_status~loan_amnt+installment+
                    issue_d+grade+purpose+dti+emp_length+home_ownership+
                    annual_inc+term, data = mysample,nbest=10)
# view results
summary(leaps) #tells us about the outliers

# plot a table of models showing variables in each model.
# models are ordered by the selection statistic.
plot(leaps)
plot(leaps,scale="r2")
############## this is not working 
subsets(leaps, data=mtcars, statistic="rsq") #rsq is for rsquare adjusted 
####################################
# All Subsets Regression
plot(leaps,scale="bic")
summary(leaps)
?regsubsets
summary(leaps)
#View(leaps)
leaps
coef(leaps,1:5)
# Calculate Relative Importance for Each Predictor
install.packages("relaimpo", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(relaimpo)
calc.relimp(fit,type=c("lmg","last","first","pratt"),
            rela=TRUE)
# Bootstrap Measures of Relative Importance (1000 samples)
boot <- boot.relimp(fit, b = 1000, type = c("lmg",
                                            "last", "first", "pratt"), rank = TRUE,
                    diff = TRUE, rela = TRUE)
booteval.relimp(boot) # print result
plot(booteval.relimp(boot,sort=TRUE)) # plot result
#https://rpubs.com/davoodastaraky/mtRegression
summary(fit)
predict.lm(fit, data.frame(wt =3.2 ,drat=3.9,hp=130,disp=150) )

############### end of code ##########################################

############ Multinomial Logistic Regression #############################


xtabs(~ loan_status + grade, data=loan)
logistic_simple <- glm(loan_status ~ grade, data=loan, family="binomial")
summary(logistic_simple)


xtabs(~ loan_status + purpose, data=loan)
logistic_simple <- glm(loan_status ~ purpose, data=loan, family="binomial")
summary(logistic_simple)


### Now calculate the overall "Pseudo R-squared" and its p-value
## NOTE: Since we are doing logistic regression...
## Null devaiance = 2*(0 - LogLikelihood(null model))
##               = -2*LogLikihood(null model)
## Residual deviance = 2*(0 - LogLikelihood(proposed model))
##                   = -2*LogLikelihood(proposed model)
ll.null <- logistic_simple$null.deviance/-2
ll.proposed <- logistic_simple$deviance/-2
ll.null
ll.proposed

## McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
(ll.null - ll.proposed) / ll.null
## chi-square value = 2*(LL(Proposed) - LL(Null))
## p-value = 1 - pchisq(chi-square value, df = 2-1)
1 - pchisq(2*(ll.proposed - ll.null), df=1)
1 - pchisq((logistic_simple$null.deviance - logistic_simple$deviance), df=1)
## Lastly, let's  see what this logistic regression predicts, given
predicted.data <- data.frame(probability.of.paying.loan=logistic_simple$fitted.values,grade=loan$grade)
predicted.data

## We can plot the data...
xtabs(~ probability.of.paying.loan + grade, data=predicted.data)


logistic <- glm(loan_status ~ ., data=loan, family="binomial")
summary(logistic)

ll.null <- logistic$null.deviance/-2
ll.proposed <- logistic$deviance/-2


## McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
(ll.null - ll.proposed) / ll.null
## The p-value for the R^2
1 - pchisq(2*(ll.proposed - ll.null), df=(length(logistic$coefficients)-1))

## now we can plot the data
predicted.data <- data.frame(probability.of.paying.loan=logistic$fitted.values,loan_status=loan$loan_status)
predicted.data <- predicted.data[order(predicted.data$probability.of.paying.loan, decreasing=FALSE),]
predicted.data$rank <- 1:nrow(predicted.data)


## Lastly, we can plot the predicted probabilities for each sample paying
## loan and color by whether or not they actually pay the loan or not
ggplot(data=predicted.data, aes(x=rank, y=probability.of.paying.loan)) +
  geom_point(aes(color=loan_status), alpha=1, shape=4, stroke=2) +
  xlab("Index") +
  ylab("Predicted probability of loan payment")

# Few packages for confusion matrix. Lets look at them one by one
install.packages("regclass")
library(regclass)
confusion_matrix(logistic)

library(caret)

pdata <- predict(logistic,newdata=loan,type="response")
pdata

loan$loan_status

pdataF <- as.factor(ifelse(test=as.numeric(pdata>0.5) == 1, yes=1, no=0 ))
pdataF
install.packages("e1071")
library(e1071)

confusionMatrix(pdataF,as.factor(loan$loan_status))


library(pROC)


roc(loan$loan_status,logistic$fitted.values,plot=TRUE)

par(pty = "s")
## NOTE: By default, roc() uses specificity on the x-axis and the values range
## from 1 to 0. This makes the graph look like what we would expect, but the
## x-axis itself might induce a headache. To use 1-specificity (i.e. the
## False Positive Rate) on the x-axis, set "legacy.axes" to TRUE.
#roc(loan$grade, glm.fit$fitted.values, plot=TRUE, legacy.axes=TRUE)
roc(loan$loan_status,logistic$fitted.values,plot=TRUE, legacy.axes=TRUE, xlab="False Positive Percentage", ylab="True Postive Percentage", col="#377eb8", lwd=4)
#roc(loan$loan_status,logistic$fitted.values,plot=TRUE, legacy.axes=TRUE, xlab="False Positive Percentage", ylab="True Postive Percentage", col="#377eb8", lwd=4)
## If we want to find out the optimal threshold we can store the
## data used to make the ROC graph in a variable...
roc.info <- roc(loan$loan_status, logistic$fitted.values, legacy.axes=TRUE)
str(roc.info)
roc.df <- data.frame(tpp=roc.info$sensitivities*100, ## tpp = true positive percentage
                     fpp=(1 - roc.info$specificities)*100, ## fpp = false positive precentage
                     thresholds=roc.info$thresholds)
roc.df
head(roc.df) ## head() will show us the values for the upper right-hand corner of the ROC graph, when the threshold is so low
## (negative infinity) that every single sample is called "obese".
## Thus TPP = 100% and FPP = 100%
tail(roc.df) ## tail() will show us the values for the lower left-hand corner
## of the ROC graph, when the threshold is so high (infinity)
## that every single sample is called "not obese".
## Thus, TPP = 0% and FPP = 0%
## now let's look at the thresholds between TPP 60% and 80%
roc.df[roc.df$tpp > 60 & roc.df$tpp < 80,]
roc(loan$loan_status,logistic$fitted.values,plot=TRUE, legacy.axes=TRUE, xlab="False Positive Percentage", ylab="True Postive Percentage", col="#377eb8", lwd=4, percent=TRUE)
roc(loan$loan_status,logistic$fitted.values,plot=TRUE, legacy.axes=TRUE, xlab="False Positive Percentage", ylab="True Postive Percentage", col="#377eb8", lwd=4, percent=TRUE, print.auc=TRUE)
roc(loan$loan_status,logistic$fitted.values,plot=TRUE, legacy.axes=TRUE, xlab="False Positive Percentage", ylab="True Postive Percentage", col="#377eb8", lwd=4, percent=TRUE, print.auc=TRUE, partial.auc=c(100, 90), auc.polygon = TRUE, auc.polygon.col = "#377eb822", print.auc.x=45)
# Lets do two roc plots to understand which model is better
roc(loan$loan_status, logistic_simple$fitted.values, plot=TRUE, legacy.axes=TRUE, percent=TRUE, xlab="False Positive Percentage", ylab="True Postive Percentage", col="#377eb8", lwd=4, print.auc=TRUE)
# Lets add the other graph
plot.roc(loan$loan_status, logistic$fitted.values, percent=TRUE, col="#4daf4a", lwd=4, print.auc=TRUE, add=TRUE, print.auc.y=40)
legend("bottomright", legend=c("Simple", "Non Simple"), col=c("#377eb8", "#4daf4a"), lwd=4) # Make it user friendly

#Conclusion- SO, according to the consfusin matrix, the accuracy of logistic regression
# is 76.63% i.e., the model classifies values correctly 76 times out of 100.











