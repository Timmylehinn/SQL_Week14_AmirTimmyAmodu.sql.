USE SqlTutorial;

/* Creating PatientDemographics_Table */
CREATE TABLE SqlTutorial.dbo.PatientDemographics
(PatientID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
);

/* Creating PatientClinicDetails_Table */
CREATE TABLE SqlTutorial.dbo.PatientClinicDetails 
(PatientID int, 
Diagnosis varchar(50), 
Last_Visit varchar(50),
Num_Visit int,
Next_Appointment varchar(50)
);

/* Inserting PatientDemographics Details */
INSERT INTO SqlTutorial.dbo.PatientDemographics VALUES
(1110, 'Charles', 'Qoyum', 45, 'Male'),
(1111, 'Stella', 'Bassy', 30, 'Female'),
(1112, 'Emmanuel', 'Owen', 19, 'Male'),
(1113, 'Hadiza', 'Malik', 25, 'Female'),
(1114, 'Tochukwu', 'Chukwuma', 12, 'Male'),
(1115, 'Usman', 'Abiola', 28, 'Male'),
(1116, 'Glory', 'Ekene', 52, 'Female'),
(1117, 'Sodiq', 'Adewale', 47, 'Male'),
(1118, 'Nolan', 'Lawrence', 5, 'Male'),
(1119, 'Blessing', NULL, NULL, 'Female');

/* Inserting PatientClinicDetails */
INSERT INTO SqlTutorial.dbo.PatientClinicDetails VALUES
(1110, 'Presbyopia', 'Jan', 5, 'Dec'),
(1111, 'High Myopia', 'Feb', 9, 'Sept'),
(1112, 'Ocular Allergy', 'Jan', 1, 'Feb'),
(1113, 'Hyperopia', 'Apr', 2, 'Dec'),
(1114, 'Myopia', 'May', 3, 'Aug'),
(1115, 'Myopia', 'Jun', 12, 'Jul'),
(1116, 'Presbyopia', 'Feb', 6, 'Apr'),
(1117, 'Myopia/Presbyopia','Oct', 7, 'Nov'),
(1118, 'Astigmatism', 'Jan', 2, 'Mar'),
(1119, NULL, 'Jul', 1, NULL);


/* UPDATING RECORDS */
/* QUERY 1:*/
UPDATE PatientDemographics
SET LastName = 'Ajayi'
WHERE PatientID = 1119;

/* QUERY 2:*/
UPDATE PatientDemographics
SET Age = 33
WHERE PatientID = 1119;

/* QUERY 3:*/
UPDATE PatientClinicDetails
SET Diagnosis = 'Astigmatism' 
WHERE PatientID = 1119;

/* QUERY 4:*/
UPDATE PatientClinicDetails
SET Next_Appointment = 'Oct'
WHERE PatientID = 1119;

/* ADDING MORE VALUES TO PatientDemographics TABLE */
/* QUERY */
INSERT INTO SqlTutorial.dbo.PatientDemographics VALUES
(1025, 'Adebayo', NULL, NULL,  NULL),
(1120, 'Omolara', 'Adekunbi', 21, 'Female');


/*DELETING RECORDS IN PatientDemographics TABLE*/
DELETE FROM SqlTutorial.dbo.PatientDemographics
WHERE PatientID = 1025


/* JOIN QUERIES */
/* QUERY 1:*/
SELECT PD.FirstName, PD.LastName, PD.Age, PC.Num_Visit 
	FROM SqlTutorial.dbo.PatientDemographics AS PD
	JOIN SqlTutorial.dbo.PatientClinicDetails AS PC
	ON PD.PatientID = PC.PatientID
ORDER BY PD.Age DESC;


/* QUERY 2:*/
SELECT PD.FirstName, PD.LastName,
CASE 
	WHEN PC.Num_Visit > 10 THEN 'VIP Patient'
	WHEN PC.Num_Visit >= 5 THEN 'Regular Patient'
	WHEN PC.Num_Visit <= 3 THEN 'Returning Patient'
	ELSE 'New Patient'
END AS Patient_Category
FROM SqlTutorial.dbo.PatientDemographics AS PD 
LEFT JOIN SqlTutorial.dbo.PatientClinicDetails AS PC
ON PD.PatientID = PC.PatientID
ORDER BY Patient_Category DESC;


/* QUERY 3:*/
SELECT PC.Diagnosis, COUNT(PC.Diagnosis) AS Num_Diagnosis
FROM SqlTutorial.dbo.PatientClinicDetails AS PC
RIGHT JOIN SqlTutorial.dbo.PatientDemographics AS PD
ON PC.PatientID = PD.PatientID
WHERE PC.Diagnosis IS NOT NULL
GROUP BY PC.Diagnosis
ORDER BY Num_Diagnosis DESC;




/* QUERY 4:*/
SELECT PD.FirstName, PD.LastName, PC.Diagnosis, PD.Age, AVG(PC.Num_Visit) AS Avg_Visit,
CASE 
	WHEN PD.Age >= 40 THEN 'Adult'
	WHEN PD.Age >= 18 THEN 'Young'
	WHEN PD.Age >= 13 THEN 'Teenage'
	ELSE 'Kid' END AS Age_Group
FROM SqlTutorial.dbo.PatientDemographics AS PD
FULL OUTER JOIN SqlTutorial.dbo.PatientClinicDetails AS PC
ON PD.PatientID = PC.PatientID
WHERE PC.Diagnosis IS NOT NULL AND PC.Num_Visit IS NOT NULL
GROUP BY PD.FirstName, PD.LastName, PD.Age, PC.Diagnosis
ORDER BY Avg_Visit Desc


SELECT *
FROM SqlTutorial.dbo.PatientDemographics