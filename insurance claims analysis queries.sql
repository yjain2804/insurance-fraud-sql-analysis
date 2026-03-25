--Get the Big Picture
SELECT COUNT(*) AS total_claims
FROM insurance_claims;

--fraud rate
SELECT 
    fraud_reported,
    COUNT(*) AS number_of_claims,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM insurance_claims), 2) AS percentage
FROM insurance_claims
GROUP BY fraud_reported;

--Which Incident Type Has Most Fraud?
SELECT 
    incident_type,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY incident_type
ORDER BY fraud_rate_pct DESC;

--claim amount
SELECT 
    round(AVG(total_claim_amount), 2) AS avg_claim_amount,
    ROUND(MIN(total_claim_amount), 2) AS min_claim,
    ROUND(MAX(total_claim_amount), 2) AS max_claim
FROM insurance_claims;

--Does Claim Amount Differ Between Fraud vs Legit?
SELECT 
    fraud_reported,
    ROUND(AVG(total_claim_amount), 2) AS avg_claim_amount,
    ROUND(MIN(total_claim_amount), 2) AS min_claim,
    ROUND(MAX(total_claim_amount), 2) AS max_claim
FROM insurance_claims
GROUP BY fraud_reported;

--Which States Have Highest Fraud Concentration?
SELECT 
    policy_state,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY policy_state
ORDER BY fraud_count DESC;

--Fraud by Customer Education Level
SELECT 
    insured_education_level,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY insured_education_level
ORDER BY fraud_rate_pct DESC;

-- fraud by incident severity
SELECT 
    incident_severity,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY incident_severity
ORDER BY fraud_rate_pct DESC;


--Fraud When No Police Report Filed
SELECT 
    police_report_available,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY police_report_available
ORDER BY fraud_rate_pct DESC;

--Fraud by Insured Occupation
SELECT 
    insured_occupation,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY insured_occupation
ORDER BY fraud_rate_pct DESC
LIMIT 10;

--Do Long-Term Customers Commit Less Fraud?

SELECT 
    CASE 
        WHEN months_as_customer < 12 THEN '0-1 year'
        WHEN months_as_customer BETWEEN 12 AND 36 THEN '1-3 years'
        WHEN months_as_customer BETWEEN 37 AND 60 THEN '3-5 years'
        ELSE '5+ years'
    END AS customer_tenure,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY customer_tenure
ORDER BY fraud_rate_pct DESC;

--
SELECT DISTINCT _c39 
FROM insurance_claims 
LIMIT 10;


SELECT 
    incident_severity,
    police_report_available,
    CASE 
        WHEN months_as_customer < 12 THEN 'New (<1yr)'
        ELSE 'Established (1yr+)'
    END AS customer_segment,
	insured_occupation,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM insurance_claims
GROUP BY incident_severity, police_report_available, customer_segment, insured_occupation
HAVING total_claims >= 10
ORDER BY fraud_rate_pct DESC
LIMIT 15;