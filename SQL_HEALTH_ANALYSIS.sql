USE Health;

SELECT * FROM [dbo].['Obesity Classification (1)$'];

--Extract BMI Values from MALE
SELECT Gender, Label ,Count(Gender) as AVAGender
FROM [dbo].['Obesity Classification (1)$']
WHERE  Gender = 'Male' AND Label = 'Normal Weight'
GROUP BY Gender,Label;


--Extract BMI Values from Female
SELECT Gender, Label ,Count(Gender) as AVAGender
FROM [dbo].['Obesity Classification (1)$']
WHERE  Gender = 'Female' AND Label = 'Normal Weight'
GROUP BY Gender,Label;

-- Calculate summary statistics for BMI in both groups (mean, median, standard deviation, etc.).
SELECT Age,Gender,Label 
FROM [dbo].['Obesity Classification (1)$']
WHERE Label IN ('Normal Weight')
;

SELECT Age,Gender,Label 
FROM [dbo].['Obesity Classification (1)$']
WHERE Label IN ('Underweight')

SELECT Age,Gender,Label 
FROM [dbo].['Obesity Classification (1)$']
WHERE Label IN ('Overweight')

SELECT Age,Gender,Label 
FROM [dbo].['Obesity Classification (1)$']
WHERE Label IN ('Obese')
-- Extracting BMI resultbase on 40 down
SELECT Age, Gender, Label
FROM [dbo].['Obesity Classification (1)$']
WHERE Age < 40 
ORDER BY Age DESC;

SELECT Age, Gender, Label
FROM [dbo].['Obesity Classification (1)$']
WHERE Age < 40 AND Gender = 'male'
ORDER BY Age DESC;
