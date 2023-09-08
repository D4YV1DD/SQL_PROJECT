CREATE DATABASE HR_Employee_Attrition;
USE hr_employee_attrition;

SELECT *
FROM employee;

/* total of all employer hired in company */
SELECT COUNT(*)
FROM employee;

 /* employment attrition and Rentention base on percentage */
 SELECT 
 (SUM(Attrition = 'No') / COUNT(*)) * 100 as Retention_Percentage,
 (SUM(Attrition = 'Yes') / COUNT(*)) * 100 as Attrition_Percentage
 FROM employee;
 

/*  the total number of male and female employees? */
SELECT
    SUM(gender = 'Male') AS Male_count,
    SUM(gender = 'Female') AS Female_count
FROM employee;
SELECT
    (SUM(gender = 'Male') / COUNT(*)) * 100 AS Male_count,
    (SUM(gender = 'Female') / COUNT(*)) * 100 AS Female_count
FROM employee;


/*  total number of status of employee */
SELECT 
SUM(MaritalStatus  = 'Single') AS Single_Count,
SUM(MaritalStatus = 'Married')  AS Married_Count,
SUM(MaritalStatus = 'Divorced') AS Divorced_Count
FROM employee;


/* Which department is the most employee */
SELECT 
    SUM(department = 'Human Resources') AS human_resources_department,
    SUM(department = 'Sales') AS sales_department,
    SUM(department = 'Research & Development') AS research_development_department
FROM employee;

SELECT 
  (SUM(department = 'Human Resources') / COUNT(*)) * 100 AS other,
  (SUM(department = 'Sales') / COUNT(*)) * 100 as Sales,
  (SUM(department = 'Research & Development') / COUNT(*)) * 100 AS Research_Developmen
FROM employee;


/* What are the most highest education field working employee */

SELECT educationfield,COUNT(department)AS total_education_field_employee
FROM employee
GROUP BY educationfield;

/* top highes education field of the employer */
SELECT
(SUM(educationfield = 'life Sciences') / COUNT(*)) * 100 AS life_Science,
(SUM(educationfield = 'Medical') / COUNT(*)) * 100 as Medical,
(SUM(educationfield IN ('other','Marketing','Technical Degree','Human Resources')) / COUNT(*)) * 100 AS other
FROM employee;

/* how frequently an employee travels for business purpose  base on percent */
DESCRIBE employee;
SELECT 
(SUM(BusinessTravel = 'Travel_Frequently') / COUNT(*)) * 100 AS Travel_Frequently,
(SUM(BusinessTravel = 'Travel_Rarely') / COUNT(*)) * 100 as Travel_Rarely,
(SUM(BusinessTravel = 'Non_Travel')/ COUNT(*)) * 100 AS Non_Travel
FROM employee;


/* top job highest salary base on monthly rate */

SELECT jobrole,MAX(MonthlyRate) as Highest_salary 
FROM employee
GROUP BY jobrole
ORDER BY Highest_salary  DESC
LIMIT 10
;

/* Total monthly salary by Department */

SELECT department,SUM(MonthlyRate) as Highest_salary 
FROM employee
GROUP BY department
ORDER BY Highest_salary DESC
;

/* Job Satisfaction base on department */
SELECT department ,SUM(jobsatisfaction) AS Department_Satisfaction,SUM(performanceRating) AS Department_Performance
FROM employee
GROUP BY department
ORDER BY Department_Satisfaction DESC,Department_Performance DESC;

/* Longest employment years in company  */
SELECT jobrole,MAX(YearsAtCompany) AS Longest_employment
FROM employee
GROUP BY jobrole
ORDER BY Longest_employment DESC
LIMIT 10;

/* The farthest employee going to work and thier performance rating */

SELECT EmployeeNumber,MAX(DistanceFromHome) AS farthest_employee_base_on_km,CASE
	WHEN PerformanceRating = 1 THEN 'Unsatisfactory'
    WHEN PerformanceRating = 2 THEN 'Below Average'
	WHEN PerformanceRating = 1 THEN 'Unsatisfactory'
	WHEN PerformanceRating = 2 THEN 'Below Average'
	WHEN PerformanceRating = 3 THEN 'Average'
	WHEN PerformanceRating = 4 THEN 'Good'
	WHEN PerformanceRating = 5 THEN 'Excellent'
	ELSE 'Unknown'
    END AS SatisfactionClassification
FROM employee
GROUP BY  EmployeeNumber,PerformanceRating
ORDER BY farthest_employee_base_on_km  DESC
LIMIT 10;

SELECT JobRole,
	SUM(CASE WHEN attrition = 'yes' THEN 1 ),
    SUM(CASE WHEN attrition = 'NO' THEN 0 )
    END AS attrition_count
FROM employee
GROUP BY jobrole
ORDER BY attrition_count DESC;

SELECT jobrole,
CASE
WHEN attrition = 'no' THEN 0
WHEN attrition = 'yes' THEN 1
END AS total_attrition
FROM employee
GROUP BY jobrole;

SELECT JobRole,
    SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) AS attrition_yes_count,
    SUM(CASE WHEN attrition = 'no' THEN 1 ELSE 0 END) AS attrition_no_count
FROM employee
GROUP BY JobRole
ORDER BY attrition_yes_count DESC;


