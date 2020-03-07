# Prediction-for-Loan-Defaulter
## Team Members:
* Vidhi Chitalia
* Darsh Thakkar
* Ridima Jadhav

## Dataset Used:
We have used the lending club loan dataset. The link for the dataset is shown below:
https://www.kaggle.com/wendykan/lending-club-loan-data#loan.csv 

## Inspiration:
The International Institute of Finance quotes, "The world is in $233 Trillion of debt". 
The first thought that arises in a normal human mind is, "Eh? To whom do we owe?". 
Finance is not everyone's cup of tea and assessment of debt is a thing that eats up time and energy, given that the mind has the ability to even process it. 
When the wound bleeds, we realise that the first thing to do is to close it and stop the bleeding and then clean up the mess. 
In the similar way, the best practice to stop this increasing and never retarding debt is to make sure that the banks lend the money to the right people and look at clear indications if someone is likely to not pay back the borrowed money on time. 
We do not know future and we'll not be knowing the same any soon, but we do know the past- The Data, through which we can assess the risk and predict if someone is likely to pay his debts or not.

## Problem Statement:
Training the dataset with millions of records and 145 columns using Machine Learning Algorithms to answer the following questions:
* Will the person default his loan?
* Will he able to pay back the amount he has borrowed?
* What are the best practices for risk management according to the data exploration?

## Data Dictionary:
|Sr. No | Column Name | Description | Datatype|
|------ | ----------- | ----------- |---------|
|1| loan_status | The status of the loan of the person | String |
|2|loan_amnt | The amount of the loan taken | Integer |
|3| funded_amnt | The total amount committed to that loan at that point in time | Integer |
|4| addr_state | The state provided by the borrower in the loan application | Number |
|5| installment | The monthly payment owed by the borrower if the loan originates | Number |
|6| int_rate | The rate of interest on the loan | Float|
|7| annual_inc | The self-reported annual income provided by the borrower during registration | Integer |
|8| issue_d | The date when loan was issued | String |
|9| grade | LC assigned loan grade | String |
|10| sub_grade | LC assigned loan subgrade | String |
|11| emp_title | The job title supplied by the Borrower when applying for the loan | String |
|12| purpose |A category provided by the borrower for the loan request| String |
|13| dti | A ratio calculated using the borrower’s total monthly debt payments on the total debt obligations, excluding mortgage and the requested LC loan, divided by the borrower’s self-reported monthly income | Float |
|14|emp_length | Employment length in years. Possible values are between 0 and 10 where 0 means less than one year and 10 means ten or more years | String |
|15| home_ownership |The home ownership status provided by the borrower during registration. Our values are: RENT, OWN, MORTGAGE, OTHER| String |
|16| term | The number of payments on the loan. Values are in months and can be either 36 or 60 | Integer |
