# Prediction-for-Loan-Defaultor
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
|1| acceptD | The date which the borrower accepted the offer | Number|
|2|accNowDelinq | The number of accounts on which the borrower is now delinquent| Number|
|3| accOpenPast24Mths | Number of trades opened in past 24 months | Number|
|4| acaddrState | The state provided by the borrower in the loan application | String|
|5|  all_util | Balance to credit limit on all trades | Number|
|6| annual_inc_joint | The combined self-reported annual income provided by the co-borrowers during registration | Number|
|7| annualInc | The self-reported annual income provided by the borrower during registration | Number|
|8| aapplication_type | Indicates whether the loan is an individual application or a joint application with two co-borrowers | String|
|8| avg_cur_bal | Indicates whether the loan is an individual application or a joint application with two co-borrowers | Number|
|9| application_type |Average current balance of all accounts| String|
|10| abcOpenToBuy | Indicates whether the loan is an individual application or a joint application with two co-borrowers | Number|
|11| aapplication_type | Total open to buy on revolving bankcards | Number|
|12| bcUtil | Ratio of total current balance to high credit/credit limit for all bankcard accounts | Number|
|13| chargeoff_within_12_mths | Number of charge-offs within 12 months | Number|
|14| acollections_12_mths_ex_med | Number of collections in 12 months excluding medical collections| Number|
|15| creditPullD | The date LC pulled credit for this loan | String|
|16| delinq2Yrs | The number of 30+ days past-due incidences of delinquency in the borrower's credit file for the past 2 years | Number|
|17| delinqAmnt | Loan description provided by the borrower | Number|
|18| desc | Indicates whether the loan is an individual application or a joint application with two co-borrowers | String|
|19| dti | A ratio calculated using the borrower’s total monthly debt payments on the total debt obligations, excluding mortgage and the requested LC loan, divided by the borrower’s self-reported monthly income | Number|
|20|dti_joint |A ratio calculated using the co-borrowers' total monthly payments on the total debt obligations, excluding mortgages and the requested LC loan, divided by the co-borrowers' combined self-reported monthly income| Number|
|21| earliestCrLine | The date the borrower's earliest reported credit line was opened | String|
|22| effective_int_rate | The effective interest rate is equal to the interest rate on a Note reduced by Lending Club's estimate of the impact of uncollected interest prior to charge off| Number|
|23| emp_title | The job title supplied by the Borrower when applying for the loan | String|
|24|empLength | Employment length in years. Possible values are between 0 and 10 where 0 means less than one year and 10 means ten or more years | Number|
|25| expD | The date the listing will expire | String|
|26| expDefaultRate | The expected default rate of the loan | Number|
|27| ficoRangeHigh | The upper boundary range the borrower’s FICO at loan origination belongs to | Number|
|28| ficoRangeLow | The lower boundary range the borrower’s FICO at loan origination belongs to| Number|
|29| fundedAmnt | The total amount committed to that loan at that point in time| Number|
|30| grade | LC assigned loan grade |String |
|31| homeOwnership |The home ownership status provided by the borrower during registration. Our values are: RENT, OWN, MORTGAGE, OTHER|String|
|32| id | A unique LC assigned ID for the loan listing| Number|
|33| il_util | Ratio of total current balance to high credit/credit limit on all install acct| Number|
|34| ils_exp_d | wholeloan platform expiration date| String |
|35| initialListStatus |The initial listing status of the loan. Possible values are – W, F | String|
|36| inq_fi| Number of personal finance inquiries | Number|
|37| inq_last_12m | Number of credit inquiries in past 12 months| Number|
|38| inqLast6Mths | The number of inquiries in past 6 months (excluding auto and mortgage inquiries) | Number|
|39| installment |The monthly payment owed by the borrower if the loan originates | Number|
|40| intRate | Interest Rate on the loan | Number|
|41| isIncV | Indicates if income was verified by LC, not verified, or if the income source was verified | String|
|42| listD|The date which the borrower's application was listed on the platform | String |
|43| loanAmnt | The listed amount of the loan applied for by the borrower. If at some point in time, the credit department reduces the loan amount, then it will be reflected in this value | Number|
|44| max_bal_bc|  Maximum current balance owed on all revolving accounts| Number|
|45| memberId |A unique LC assigned Id for the borrower member | Number|
|46| mo_sin_old_rev_tl_op |Months since oldest revolving account opened | Number|
|47| mortAcc | Number of mortgage accounts| Number|
|48| msa| Metropolitan Statistical Area of the borrower | String |
|49| mths_since_last_major_derog | Months since most recent 90-day or worse rating| Number|
|50| mths_since_oldest_il_open | Months since oldest bank installment account opened| Number|
|51|  mths_since_rcnt_il| Months since most recent installment accounts opened | Number|
|52| mthsSinceLastDelinq | The number of months since the borrower's last delinquency | Number|
|53| mthsSinceLastRecord |The number of months since the last public record | Number|
|54| mthsSinceMostRecentInq |Months since most recent inquiry| Number|
|55| mthsSinceRecentBc | Months since most recent bankcard account opened| Number|
|56| mthsSinceRecentLoanDelinq |Months since most recent personal finance delinquency | Number|
|57| mthsSinceRecentRevolDelinq | Months since most recent revolving delinquency| Number|
|58| num_accts_ever_120_pd | Number of accounts ever 120 or more days past due| Number|
|59| num_actv_bc_tl | Number of currently active bankcard accounts | Number|
|60| num_actv_rev_tl | Number of currently active revolving trades | Number|
|61| num_bc_sats | Months since most recent revolving account opened | Number|
|62| num_bc_tl | Number of bankcard accounts | Number|
|63| num_il_tl | Number of installment accounts | Number|
|64| num_op_rev_tl | Number of open revolving accounts | Number|
|65| num_rev_accts | Number of revolving accounts | Number|
|66| num_rev_tl_bal_gt_0 | Number of revolving trades with balance >0 | Number|
|67| num_sats | Number of satisfactory accounts | Number|
|68| num_tl_120dpd_2m | Number of accounts currently 120 days past due (updated in past 2 months) | Number|
|69| num_tl_30dpd | Number of accounts currently 30 days past due (updated in past 2 months) | Number|
|70| num_tl_90g_dpd_24m | Number of accounts 90 or more days past due in last 24 months | Number|
|71| num_tl_op_past_12m | Number of accounts opened in past 12 months| Number|
|72| open_acc_6m | Number of open trades in last 6 months | Number|
|73| open_il_12m | Number of installment accounts opened in past 12 months| Number|
|74| open_il_24m |Number of installment accounts opened in past 24 months | Number|
|75| open_act_il | Number of currently active installment trades | Number|
|76| open_rv_12m | Number of revolving trades opened in past 12 months | Number|
|77| open_rv_24m | Number of revolving trades opened in past 24 months | Number|
|77| openAcc | The number of open credit lines in the borrower's credit file | Number|
|78| pct_tl_nvr_dlq | Percent of trades never delinquent | Number|
|79| percentBcGt75 | Percentage of all bankcard accounts > 75% of limit | Number|
|80| pubRec | Number of derogatory public records | Number|
|81| purpose |A category provided by the borrower for the loan request| String |
|82| reviewStatus | The status of the loan during the listing period. Values: APPROVED, NOT_APPROVED| String|
|83| reviewStatusD | The date the loan application was reviewed by LC| String|
|84| revolBal | Total credit revolving balance| Number|
|85| revolUtil |Revolving line utilization rate, or the amount of credit the borrower is using relative to all available revolving credit. | Number|
|86| serviceFeeRate | Service fee rate paid by the investor for this loan | Number|
|87|subGrade | LC assigned loan subgrade| String |
|88| tax_liens | Number of tax liens| Number|
|89| term | The number of payments on the loan. Values are in months and can be either 36 or 60 | Number|
|90| title | The loan title provided by the borrower | String |
|91| tot_coll_amt | Total collection amounts ever owed| Number|
|92| tot_cur_bal | Total current balance of all accounts | Number|
|93| tot_hi_cred_lim | Total high credit/credit limit | Number|
|94| total_bal_il | Total current balance of all installment accounts | Number|
|95| total_cu_tl | Number of finance trades | Number|
|96| total_il_high_credit_limit | Total installment high credit/credit limit | Number|
|97| total_rev_hi_lim | Total revolving high credit/credit limit | Number|
|98| totalAcc | The total number of credit lines currently in the borrower's credit file| Number|
|99| totalBalExMort | Total credit balance excluding mortgage | Number|
|100| totalBcLimit | Total bankcard high credit/credit limit | Number|
|101| url | URL for the LC page with listing data | String |
|102| verified_status_joint | Indicates if the co-borrowers' joint income was verified by LC, not verified, or if the income source was verified | String |
|103| zip_code | The first 3 numbers of the zip code provided by the borrower in the loan application | Number|
|104| revol_bal_joint | Sum of revolving credit balance of the co-borrowers, net of duplicate balances | Number|
|105| sec_app_fico_range_low | FICO range (low) for the secondary applicant | Number|
|106| sec_app_fico_range_high | FICO range (high) for the secondary applicant | Number|
|107| sec_app_earliest_cr_line | Earliest credit line at time of application for the secondary applicant| Number|
|108| sec_app_inq_last_6mths | Credit inquiries in the last 6 months at time of application for the secondary applicant | Number|
|109|  sec_app_mort_acc | Number of mortgage accounts at time of application for the secondary applicant | Number|
|110| sec_app_open_acc | Number of open trades at time of application for the secondary applicant | Number|
|111| sec_app_revol_util | Ratio of total current balance to high credit/credit limit for all revolving accounts | Number|
|112| sec_app_open_act_il | Number of currently active installment trades at time of application for the secondary applicant | Number|
|113| sec_app_num_rev_accts | Number of revolving accounts at time of application for the secondary applicant| Number|
|114| sec_app_chargeoff_within_12_mths | Number of charge-offs within last 12 months at time of application for the secondary applicant | Number|
|115| sec_app_collections_12_mths_ex_med | Number of collections within last 12 months excluding medical collections at time of application for the secondary applicant| Number|
|116| sec_app_mths_since_last_major_derog | Months since most recent 90-day or worse rating at time of application for the secondary applicant | Number|
|117| disbursement_method | The method by which the borrower receives their loan. Possible values are: CASH, DIRECT_PAY | Number|
|118| hardship_flag | Flags whether or not the borrower is on a hardship plan | Number|
|119| hardship_type | Describes the hardship plan offering| Number|
|120| hardship_reason | Describes the reason the hardship plan was offered | Number|
|121| hardship_status | Describes if the hardship plan is active, pending, canceled, completed, or broken | Number|
|122| deferral_term | Amount of months that the borrower is expected to pay less than the contractual monthly payment amount due to a hardship plan | Number|
|123| hardship_amount| The interest payment that the borrower has committed to make each month while they are on a hardship plan | Number|
|124| hardship_start_date | The start date of the hardship plan period | Number|
|125| hardship_end_date | The end date of the hardship plan period | Number|
|126| payment_plan_start_date | The day the first hardship plan payment is due. For example, if a borrower has a hardship plan period of 3 months, the start date is the start of the three-month period in which the borrower is allowed to make interest-only payments | Number|
|127| hardship_length | The number of months the borrower will make smaller payments than normally obligated due to a hardship plan | Number|
|128| hardship_dpd | Account days past due as of the hardship plan start date | Number|
|129| hardship_loan_status| Loan Status as of the hardship plan start date | Number|
|130| orig_projected_additional_accrued_interest | The original projected additional interest amount that will accrue for the given hardship payment plan as of the Hardship Start Date. This field will be null if the borrower has broken their hardship payment plan. | Number|
|131| hardship_last_payment_amount| The last payment amount as of the hardship plan start date | Number|
|132| disbursement_method| The method by which the borrower receives their loan. Possible values are: CASH, DIRECT_PAY | Number|
|133| debt_settlement_flag| Flags whether or not the borrower, who has charged-off, is working with a debt-settlement company | Number|
|134| debt_settlement_flag_date| The most recent date that the Debt_Settlement_Flag has been set | Number|
|135| settlement_status| The status of the borrower’s settlement plan. Possible values are: COMPLETE, ACTIVE, BROKEN, CANCELLED, DENIED, DRAFT | Number|
|136| settlement_date| The date that the borrower agrees to the settlement plan | Number|
|137| settlement_amount| The loan amount that the borrower has agreed to settle for | Number|
|138| settlement_percentage| The settlement amount as a percentage of the payoff balance amount on the loan | Number|
|139| settlement_term| The number of months that the borrower will be on the settlement plan | Number|
|140| Amount Requested| The total amount requested by the borrower | Number|
|141| Application Date| The date which the borrower applied | Number|
|142| Loan Title| The loan title provided by the borrower | Number|
|143| Risk_Score| For applications prior to November 5, 2013 the risk score is the borrower's FICO score. For applications after November 5, 2013 the risk score is the borrower's Vantage score | Number|
|144| hardship_payoff_balance_amount| The payoff balance amount as of the hardship plan start date | Number|
|145| Debt-To-Income| Ratio A ratio calculated using the borrower’s total monthly debt payments on the total debt obligations, * excluding mortgage and the requested LC loan, divided by the borrower’s self-reported monthly income | Number|
|146| State| The state provided by the borrower in the loan application| Number|
|147| Employment Length|  Employment length in years. Possible values are between 0 and 10 where 0 means less than one year and 10 means ten or more years| Number|
|148|Policy Code| "publicly available policy_code=1 ;new products not publicly available policy_code=2" |Number|
