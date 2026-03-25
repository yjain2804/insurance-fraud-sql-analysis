# Insurance Fraud Detection — SQL Analysis

## Project Overview
Exploratory analysis of an auto insurance claims dataset to identify 
patterns and risk factors associated with fraudulent claims, using 
SQL-based segmentation and aggregation.

## Business Question
Which customer, incident, and behavioral characteristics are most 
strongly associated with fraudulent insurance claims?

## Dataset
- Source: Kaggle — Auto Insurance Claims Data
- Records: 1000
- Fields: 38 columns covering policy details, incident characteristics,
  claimant demographics, and claim amounts

## Tools Used
- DB Browser for SQLite (data exploration and querying)
- VS Code (query documentation)
- GitHub (version control and portfolio publishing)

## Key Findings

1. **Overall Fraud Rate:** ~25% of claims flagged as fraudulent, 
   elevated vs. industry benchmark of 10–15%

2. **Claim Amount Inflation:** Fraudulent claims average 20% higher 
   total value than legitimate claims — a classic fraud signal

3. **Geographic Concentration:** Ohio shows highest absolute fraud 
   claim volume, suggesting regional risk concentration

4. **Education & Occupation Pattern:** PhD/MD education levels and 
   exec-managerial occupations show highest fraud rates — consistent 
   with sophisticated, organized fraud schemes

5. **Incident Severity:** Major damage incidents carry a 60% fraud 
   rate vs. 25% dataset average

6. **Police Report Absence:** Claims with no or unknown police report 
   show 3% higher fraud rate than documented claims

7. **New Customer Risk:** Policyholders under 1 year tenure show 30% 
   fraud rate — highest across all tenure segments

8. **Multi-Factor Risk:** Major damage + absent police report + 
   exec-managerial occupation produces 70% fraud rate — nearly 3x 
   the dataset average

## Business Recommendation
Fraud screening models should prioritize: new customers filing major 
damage claims without police documentation, particularly in 
exec-managerial and professional specialty occupations, with 
geographic weighting toward OH.

## SQL Queries
See `insurance claims analysis queries.sql` for all queries used in this analysis.   
