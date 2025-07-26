create database tele_churn;
use tele_churn;
CREATE TABLE telco_churn (
  customerID VARCHAR(20),
  gender VARCHAR(10),
  SeniorCitizen INT,
  Partner VARCHAR(5),
  Dependents VARCHAR(5),
  tenure INT,
  PhoneService VARCHAR(20),
  MultipleLines VARCHAR(30),
  InternetService VARCHAR(20),
  OnlineSecurity VARCHAR(25),
  OnlineBackup VARCHAR(25),
  DeviceProtection VARCHAR(20),
  TechSupport VARCHAR(20),
  StreamingTV VARCHAR(25),
  StreamingMovies VARCHAR(25),
  Contract VARCHAR(30),
  PaperlessBilling VARCHAR(5),
  PaymentMethod VARCHAR(50),
  MonthlyCharges FLOAT,
  TotalCharges VARCHAR(20),
  Churn VARCHAR(5)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WA_Fn-UseC_-Telco-Customer-Churn.csv'
INTO TABLE telco_churn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#1. Total Customers

SELECT COUNT(*) AS total_customers FROM telco_churn;

#2. Total Churned vs Not Churned
SELECT Churn, COUNT(*) AS total_count
FROM telco_churn
GROUP BY Churn;
 
#3. Churn by Gender
SELECT gender, Churn, COUNT(*) AS total
FROM telco_churn
GROUP BY gender, Churn;

#4. Churn by Internet Service
SELECT InternetService, Churn, COUNT(*) AS total
FROM telco_churn
GROUP BY InternetService, Churn;

#5. Churn by Contract Type
SELECT Contract, Churn, COUNT(*) AS total
FROM telco_churn
GROUP BY Contract, Churn;

#6. Average Monthly Charges by Contract
SELECT Contract, AVG(MonthlyCharges) AS avg_monthly
FROM telco_churn
GROUP BY Contract;

#7. Revenue (Total Charges) by Payment Method
SELECT PaymentMethod, SUM(CAST(TotalCharges AS DECIMAL(10,2))) AS total_revenue
FROM telco_churn
GROUP BY PaymentMethod;

#8. Tenure Buckets with Churn
SELECT 
  CASE 
    WHEN tenure <= 12 THEN '0-12 months'
    WHEN tenure <= 24 THEN '13-24 months'
    WHEN tenure <= 48 THEN '25-48 months'
    ELSE '49+ months'
  END AS tenure_bucket,
  Churn,
  COUNT(*) AS total
FROM telco_churn
GROUP BY tenure_bucket, Churn;

#9. Average Total Charges by Churn
SELECT Churn, AVG(CAST(TotalCharges AS DECIMAL(10,2))) AS avg_total_charges
FROM telco_churn
GROUP BY Churn;

#10. Top 10 Highest Paying Customers
SELECT customerID, TotalCharges
FROM telco_churn
ORDER BY CAST(TotalCharges AS DECIMAL(10,2)) DESC
LIMIT 10;

#11. Churn Rate by Tech Support
SELECT TechSupport, Churn, COUNT(*) AS total
FROM telco_churn
GROUP BY TechSupport, Churn;
