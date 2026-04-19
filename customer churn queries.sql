CREATE TABLE customer_churn (
    ConsumerID VARCHAR(20),
    Gender VARCHAR(10),
    Age INT,
    TenureMonths INT,
    ContractType VARCHAR(30),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    InternetService VARCHAR(20),
    TechSupport VARCHAR(10),
    OnlineBackup VARCHAR(10),
    PaymentMethod VARCHAR(50),
    City VARCHAR(50),
    SatisfactionScore INT,
    Churn VARCHAR(5),
    AgeGroup VARCHAR(20)
);


select * from customer_churn;


-- OVERALL CHURN RATE
select round(sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate 
from customer_churn;

-- HOW MANY CUSTOMERS CHURNED VS RETAINED
select churn,count(*) as customer_count 
from customer_churn 
group by churn;


-- WHICH CONTRACT TYPE HAS THE HIGHEST CHURN RATE
select contracttype,count(*) as total_customers,
sum(case when churn='Yes'then 1 else 0 end) as total_customers_churned,
sum(case when churn='Yes'then 1 else 0 end)*100.0/count(*) as churn_rate
from customer_churn
group by contracttype
order by churn_rate desc;


-- WHICH PAYMENT METHOD CUSTOMERS CHURN THE MOST
select paymentmethod, count(*) as total_customers, 
sum(case when churn='Yes' then 1 else 0 end) as churned_customers,
sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*) as churn_rate
from customer_churn
group by paymentmethod
order by churn_rate desc;


-- WHICH AGE GROUP CHURNS THE MOST
select agegroup, count(*) as total_customers, 
sum(case when churn='Yes' then 1 else 0 end) as total_customers_churned,
sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*) as churn_rate 
from customer_churn
group by agegroup
order by churn_rate desc;


-- WHAT IS AVERAGE MONTHLY CHARGES FOR CHURNED VS NON CHURNED
select churn , (round(avg(monthlycharges),2)) as avg_monthly_charges 
from customer_churn
group by churn;


-- DOES SATISFACTIOPN SCORE AFFECT CHURN
select satisfactionscore, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as customers_churned,
(sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*),2) as churn_rate
from customer_churn
group by satisfactionscore
order by churn_rate desc;


-- DO CUSTOMERS WITHOUT TECH SUPPORT CHURN MORE
select techsupport, count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as customers_churned,
sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*) as churn_rate
from customer_churn
group by techsupport
order by churn_rate desc;


-- DO CUSTOMERS WITH ONLINE BACKUP CHURN LESS
select onlinebackup , count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as customers_churned,
sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*) as churn_rate
from customer_churn
group by onlinebackup
order by churn_rate desc;


-- DO NEW CUSTOMERS CHURN MORE THAN OLD CUSTOMERS
select case when tenuremonths<=12 then 'New_customers(0-1) years'
            when tenuremonths<=24 then 'Midterm_customers(1-2)years'
			else 'Old_customers(2+years)'
			end as tenure_group,
count(*) as total_customers,
sum(case when churn='Yes' then 1 else 0 end) as customers_churned,
sum(case when churn='Yes' then 1 else 0 end)*100.0/count(*) as churn_rate 
from customer_churn
group by 
       case when tenuremonths<=12 then 'New_customers(0-1) years'
            when tenuremonths<=24 then 'Midterm_customers(1-2)years'
			else 'Old_customers(2+years)' end
order by churn_rate desc;


