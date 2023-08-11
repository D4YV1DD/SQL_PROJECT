CREATE DATABASE arm_forces;
Use arm_forces;

CREATE TABLE Soldier(
soldier_id INT PRIMARY KEY,
firt_name VARCHAR(50),
last_name VARCHAR(50),
soldier_rank VARCHAR(50),
date_of_birth DATE,
date_of_inlistment DATE
);

CREATE TABLE Unit(
unit_id INT PRIMARY KEY,
unit_type VARCHAR(50),
unit_name VARCHAR(50)
);

CREATE TABLE Training (
training_id INT PRIMARY KEY,
training_name VARCHAR(50),
start_date DATE,
end_date DATE
);


CREATE TABLE Soldier_Training(
soldier_id INT ,
training_id INT,
PRIMARY KEY (soldier_id,training_id),
FOREIGN KEY (soldier_id) REFERENCES Soldier(soldier_id),
FOREIGN KEY (training_id) REFERENCES Training(training_id)
);

/*
THIS IS MY LINK MODEL DESSIGN OF MY DATABASE 
--https://lucid.app/lucidchart/invitations/accept/inv_a9bf8fcf-108f-4d99-abb9-55787b9c9aa7

