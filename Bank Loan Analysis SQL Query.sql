USE [Bank Loan DB]

SELECT * FROM bank_loan_data;


---- Total Application

SELECT COUNT(id) AS Total_Loan_Application FROM bank_loan_data;

SELECT COUNT(*) AS Total_Loan_Application FROM bank_loan_data;

---- Month to Date (current month)

SELECT COUNT(id) AS MTD_Total_Loan_Application FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---- Previous Month to Date

SELECT COUNT(id) AS PMTD_Total_Loan_Application FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

---- Total Funded Amount

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

---- Month to Date

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---- Previous Month to Date

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

---- Total Payment Received To Bank

SELECT SUM(total_payment) AS Total_Payment_Received FROM bank_loan_data;

---- Month to Date

SELECT SUM(total_payment) AS MTD_Total_Payment_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---- Previous Month to Date

SELECT SUM(total_payment) AS PMTD_Total_Payment_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;


---- Average Interest Rate

SELECT AVG(int_rate) AS AVG_Interest_Rate FROM bank_loan_data;   --- to covert it into Percent = * 100

SELECT AVG(int_rate) * 100 AS AVG_Interest_Rate FROM bank_loan_data; 

SELECT  ROUND(AVG(int_rate)*100, 2) AS AVG_Interest_Rate FROM bank_loan_data; ---- to round decimal places to 2

SELECT  ROUND(AVG(int_rate), 4)*100 AS AVG_Interest_Rate FROM bank_loan_data;

---- Month to Date

SELECT ROUND(AVG(int_rate), 4)*100 AS MTD_AVG_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---- Previous Month to Date

SELECT ROUND(AVG(int_rate), 4)*100 AS PMTD_AVG_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

---- Average of DTI

SELECT AVG(dti) AS Avg_DTI FROM bank_loan_data;

SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data;

SELECT ROUND(AVG(dti), 4)*100 AS Avg_DTI FROM bank_loan_data;

---- Month to Date

SELECT ROUND(AVG(dti), 4)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

---- Previous Month to Date

SELECT ROUND(AVG(dti), 4)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

----- GOOD Loan /BAD Loan

SELECT loan_status FROM bank_loan_data;

SELECT DISTINCT loan_status FROM bank_loan_data;

SELECT loan_status FROM bank_loan_data GROUP BY loan_status;

---- Total Percentage of Good Loan

SELECT
      (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
	  /
	  COUNT(id) AS Good_loan_Percentage
FROM bank_loan_data;

---- Good Loan Applications

SELECT COUNT(id) AS Good_Loan_Application FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

SELECT COUNT(id) AS Good_Loan_Application FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');


---- Good loan Funded Amount

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

---- Good loan Received Amount

SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

---- Bad Loans

---- Total Percentage of BAD Loan

SELECT
     (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100)
	 /
	 COUNT(id) AS Bad_laon_Percentage
FROM bank_loan_data;

---- Total Application of Bad Loan

SELECT COUNT(id) AS Bad_Loan_Application FROM bank_loan_data
WHERE loan_status = 'Charged Off';

---- Total Amount Funded for bad Loan

SELECT SUM(loan_amount) AS Bad_loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

---- Total Amount Received on bad Loan

SELECT SUM(total_payment) AS Bad_loan_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Charged Off';

---- Loan Status

SELECT
       loan_status,
	   COUNT(id) AS Total_Loan_Applications,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Amount_Funded,
	   AVG(int_rate * 100) AS	Interest_Rate,
	   AVG(dti * 100) AS DTI
	FROM
	    bank_loan_data
	GROUP BY
	    loan_status;

---- Month to Date

SELECT
      loan_status,
	  SUM(total_payment) AS MTD_Total_Amount_Received,
	  SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date)  = 12
GROUP BY loan_status;

---- Overview Chart 
---- Monthly trends by issue Date

SELECT
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

---- Regional Analysis by State

SELECT
    address_state,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

----  Max State

SELECT
    address_state,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;

---- Total Application


SELECT
    address_state,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) DESC;

----- Loan TERM

SELECT
    term,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term;

---- Employee Length

SELECT
    emp_length,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

---- Application

SELECT
    emp_length,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC;

---- Purpose

SELECT
    purpose,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose DESC;

---- Home Ownership

SELECT
    home_ownership,
	COUNT(id) AS Total_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership DESC;

