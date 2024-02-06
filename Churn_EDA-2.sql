-- 1. How are customers distributed according to their status ?

SELECT 
    Customer_Status,
    COUNT(Customer_Status) AS number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER(), 1) AS percentage
FROM telecom_customer
GROUP BY Customer_Status
ORDER BY percentage DESC;

-- 2. How much revenue was lost due to the customer churn ?

SELECT 
    Customer_Status,
    ROUND(SUM(total_revenue), 2) AS revenue,
    ROUND(SUM(total_revenue) * 100 / SUM(SUM(total_revenue)) OVER (), 1) AS percentage
FROM telecom_customer
GROUP BY Customer_Status
ORDER BY percentage DESC;

-- 3. What are the monthly charges according to the customer's status ?

SELECT
    Customer_Status,
    ROUND(AVG(Monthly_Charge),1) AS Monthly_Charge_Avg
FROM telecom_customer
GROUP BY Customer_Status
ORDER BY Monthly_Charge_Avg DESC;

-- 4. What were the contracts of Churned customers ?

SELECT
    Contract,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Contract
ORDER BY churned_percentage DESC;

-- 5. What was the churn rate according the tenure  ?


--- Churned Customers
SELECT
    Tenure_Categorization,
    COUNT(Customer_Status) AS churn_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churn_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned'
GROUP BY Tenure_Categorization
ORDER BY churn_percentage DESC;

--- Stayed Customers
SELECT
    Tenure_Categorization,
    COUNT(Customer_Status) AS stayed_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS stayed_percentage
FROM telecom_customer
WHERE Customer_Status = 'Stayed'
GROUP BY Tenure_Categorization
ORDER BY stayed_percentage DESC;


-- 6. What were the most impacted cities ?

--Churned Customer
SELECT
    City,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned'
GROUP BY City
ORDER BY churned_percentage DESC
LIMIT 5;




-- 7. What are the reasons for churn ?

---Global Reasons

SELECT
    Churn_Category,
    COUNT(Customer_Status) AS number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS percentage
FROM telecom_customer
WHERE Churn_Category != 'No churn'
GROUP BY Churn_Category
ORDER BY percentage DESC;

--- Specific Reasons

SELECT
    Churn_Reason,
    COUNT(Customer_Status) AS number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS percentage
FROM telecom_customer
WHERE Churn_Reason != 'No churn'
GROUP BY Churn_Reason
ORDER BY percentage DESC
LIMIT 10;


-- 8. What is the churn rate for Maven offers ?

--- Global (No Offer and Offer)

SELECT
    Offer,
    COUNT(Customer_Status) AS churn_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churn_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Offer
ORDER BY churn_percentage DESC;

--- Churned Customers with an Offer

    SELECT
        Tenure_Categorization,
        Offer,
        COUNT(Customer_Status)  AS churn_number,
        ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churn_percentage
    FROM telecom_customer
    WHERE Customer_Status='Churned' AND Offer != 'None'
    GROUP BY Tenure_Categorization, Offer
    ORDER BY churn_percentage DESC
	LIMIT 5; 

--- Stayed Customers with an Offer

    SELECT
        Tenure_Categorization,
        Offer,
        COUNT(Customer_Status) AS stayed_number,
        ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS stayed_percentage
    FROM telecom_customer
    WHERE Customer_Status = 'Stayed' AND Offer != 'None'
    GROUP BY Tenure_Categorization, Offer
    ORDER BY stayed_percentage DESC
	LIMIT 5;


--- Joined Customers with an Offer

    SELECT
        Tenure_Categorization,
        Offer,
        COUNT(Customer_Status) AS joined_number,
        ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS joined_percentage
    FROM telecom_customer
    WHERE Customer_Status = 'Joined' 
    GROUP BY Tenure_Categorization, Offer
    ORDER BY joined_percentage DESC
	LIMIT 5;

-- 9. What were the most recommended offers by Stayed customers ?

SELECT
    Offer,
    SUM(Number_of_Referrals) AS total_referalls,
    COUNT(Customer_Status) AS stayed_number,
    ROUND(COUNT(Customer_Status) * 100 / SUM(COUNT(Customer_Status)) OVER (), 1) AS stayed_percentage
FROM telecom_customer
WHERE Customer_Status = 'Stayed' AND Number_of_Referrals > 0 AND Offer != 'None'
GROUP BY Offer
ORDER BY stayed_percentage DESC;


-- 10. What is the churn rate for Maven services ?

---Internet Service

SELECT
    Internet_Service,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status) * 100 / SUM(COUNT(Customer_Status)) OVER (), 1) AS churn_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned'
GROUP BY Internet_Service
ORDER BY churn_percentage DESC;


--- Internet Type

SELECT
    Internet_Type,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churn_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Internet_Type
ORDER BY churn_percentage DESC;

--- Online Security

SELECT
    Online_Security,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Online_Security
ORDER BY churned_percentage DESC;

--- Phone Service 

SELECT
    Phone_Service,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned'
GROUP BY Phone_Service
ORDER BY churned_percentage DESC;

--- Online Backup 

SELECT
    Online_Backup,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned'
GROUP BY Online_Backup
ORDER BY churned_percentage DESC;

--- Device Protection Plan 

SELECT
    Device_Protection_Plan,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Device_Protection_Plan
ORDER BY churned_percentage DESC;

--- Premium Tech Support

SELECT
    Premium_Tech_Support,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Premium_Tech_Support
ORDER BY churned_percentage DESC;

--- Streaming TV

SELECT
    Streaming_TV,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Streaming_TV
ORDER BY churned_percentage DESC;

--- Streaming Movies 

SELECT
    Streaming_Movies,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Streaming_Movies
ORDER BY churned_percentage DESC;

--- Streaming Music 

SELECT
    Streaming_Music,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Streaming_Music
ORDER BY churned_percentage DESC;

--- Unlimited Data 

SELECT
    Unlimited_Data,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Unlimited_Data
ORDER BY churned_percentage DESC;

--- Paperless Billing 

SELECT
    Paperless_Billing,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Paperless_Billing
ORDER BY churned_percentage DESC;

--- Payment_Method 

SELECT
    Payment_Method,
    COUNT(Customer_Status) AS churned_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status = 'Churned' 
GROUP BY Payment_Method
ORDER BY churned_percentage DESC;

-- 11. What is the profile of churned customers ?
 
--- Gender

SELECT
    Gender,
    COUNT(Customer_Status) AS gender_number,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS gender_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Gender
ORDER BY gender_percentage DESC;

--- Age

SELECT
    Age_Groups,
    COUNT(Customer_Status) AS churned_number,
    SUM(COUNT(Customer_Status)) OVER () AS total,
    ROUND(COUNT(Customer_Status)*100/SUM(COUNT(Customer_Status)) OVER (), 1) AS churn_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Age_Groups
ORDER BY churn_percentage DESC;

--- Average Age for Churned Customer

SELECT
    ROUND(AVG(Age),1) AS age_mean,
    COUNT(Customer_Status) AS number
FROM telecom_customer
WHERE Customer_Status='Churned' AND Age > 60
GROUP BY Customer_Status;

--- Marital status

SELECT
    Married,
    COUNT(Married) AS churned_number,
    ROUND(COUNT(Married)*100/SUM(COUNT(Married)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Married
ORDER BY churned_percentage DESC;

--- Number_of_Dependants

SELECT
    Number_of_Dependents,
    COUNT(Number_of_Dependents) AS churned_number,
    ROUND(COUNT(Number_of_Dependents)*100/SUM(COUNT(Number_of_Dependents)) OVER (), 1) AS churned_percentage
FROM telecom_customer
WHERE Customer_Status='Churned'
GROUP BY Number_of_Dependents
ORDER BY churned_percentage DESC;



-- 12. Defintion of High-Value Customer (hvc)

WITH hvc_table AS (
SELECT customer_status,
      COUNT(CASE
	           WHEN monthly_revenue >93	AND tenure_in_months >= 12 AND number_of_referrals > 0 THEN 1
			   END) AS high_value_customer
FROM telecom_customer
GROUP BY customer_status)

SELECT customer_status,
high_value_customer,
ROUND(high_value_customer*100/SUM(high_value_customer) OVER(),1) AS hvc_percentage
FROM hvc_table
ORDER BY hvc_percentage DESC ;
 
-- 13. In which cities are the high-value customers who have stayed?
WITH hvc_table AS (
SELECT customer_status,city,
      COUNT(CASE
	           WHEN monthly_revenue >93	AND tenure_in_months >= 12 AND number_of_referrals > 0 THEN 1
			   END) AS high_value_customer
FROM telecom_customer
GROUP BY customer_status,city)

SELECT customer_status,city,
high_value_customer,
SUM(high_value_customer) OVER() AS total_hvc,
ROUND(high_value_customer*100/SUM(high_value_customer) OVER(),1) AS hvc_percentage
FROM hvc_table
where customer_status='Stayed'
ORDER BY hvc_percentage DESC ;


-- 14. What is the exposure of high-value customers to the risk of churn ?

WITH hvc_at_risk AS (
    SELECT 
        customer_status,
        number_of_referrals,
        tenure_in_months,
        monthly_revenue,
        CASE 
            WHEN monthly_revenue > 93 AND tenure_in_months >= 12 AND number_of_referrals > 0 THEN 'High Value Customer'
        END AS customer_value,
        SUM(CASE WHEN Age > 60 THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Married='No' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Number_of_Referrals = 0 THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Tenure_in_Months < 12 THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Offer = 'Offer E' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Phone_Service='Yes' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Internet_Type = 'Fiber Optic' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Online_Security = 'No' THEN 1 ELSE 0 END) + 
	    SUM(CASE WHEN Online_Backup = 'No' THEN 1 ELSE 0 END) + 
	    SUM(CASE WHEN Device_Protection_Plan = 'No' THEN 1 ELSE 0 END) +
        SUM(CASE WHEN Premium_Tech_Support = 'No' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Streaming_TV = 'No' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Streaming_Movies = 'No' THEN 1 ELSE 0 END) +
		SUM(CASE WHEN Streaming_Music = 'No' THEN 1 ELSE 0 END) +
        SUM(CASE WHEN Unlimited_Data = 'Yes' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Contract = 'Month-to-Month' THEN 1 ELSE 0 END) + 
	    SUM(CASE WHEN Paperless_Billing = 'Yes' THEN 1 ELSE 0 END) +
	    SUM(CASE WHEN Payment_Method = 'Bank Withdrawal' THEN 1 ELSE 0 END) 
	    AS churn_risk_factor

    FROM telecom_customer
    GROUP BY
          customer_status,
          number_of_referrals,
          tenure_in_months,
          monthly_revenue
)
 
SELECT
 CASE 
     WHEN churn_risk_factor <= 3 THEN 'Low Risk'
	 WHEN churn_risk_factor <= 5 THEN 'Medium Risk'  
	 ELSE 'High Risk' 
	 END AS churn_risk_level,
COUNT(customer_status) AS hvc_number,
ROUND(COUNT(customer_status)*100/SUM(COUNT(customer_status)) OVER(),1) AS hvc_percentage
FROM hvc_at_risk
WHERE customer_value='High Value Customer' AND customer_status='Stayed'
GROUP BY customer_status, churn_risk_level
ORDER BY hvc_percentage DESC;


