
	-- Employee Dimension Insert --
	
INSERT INTO HR_SDM.Employee_Dim
SELECT DISTINCT
	1,
    Employee_ID ,
    National_ID ,
    Login_ID ,
    Job_Title,
    Birth_Date,
    Gender,            
    Hire_Date 
FROM HR_RDM.Employee;


	-- Department Dimension Insert --

INSERT INTO HR_SDM.Departmen_Dim
 SELECT DISTINCT
 	1,
    Department_ID,
    Department_Name,
    Group_Name
FROM HR_RDM.Department;


	-- Shift Dimension Insert --

INSERT INTO HR_SDM.Shift_Dim
SELECT DISTINCT 
	1,
	Shift_ID    ,
    Shift_Name  ,
    Start_Time  ,
    End_Time    
 FROM HR_RDM.Shift;
 
 
 	-- Date Dimension Insert --

INSERT INTO HR_SDM.Date_Dim
SELECT DISTINCT 

	(EXTRACT(YEAR FROM d) *10000
	+EXTRACT(MONTH FROM d) *100
	+EXTRACT(DAY FROM d)) AS Date_Key,
	d AS FullDate,
	EXTRACT (DAY FROM d) ,
	EXTRACT (MONTH FROM d) ,
	TRIM(TO_CHAR(d,'Month')),
	EXTRACT(YEAR FROM d)

FROM (
	  SELECT Start_Date AS d FROM HR_RDM.Employee_Department_History
UNION SELECT End_Date AS d FROM HR_RDM.Employee_Department_History
	 )x;
	 
	 
	 	-- Employee_Department_History_Fact Fact Insert --

INSERT INTO HR_SDM.Employee_Department_History_Fact
SELECT DISTINCT 
	ed.Employee_Key    ,
	dd.Department_Key  ,
	sd.Shift_Key       ,
	d1.Date_Key AS Start_Date_Key	,
	d2.Date_Key	AS End_Date_Key,
	e.Vacation_Hours,
	e.Sick_Leave_Hours
FROM HR_RDM.Employee_Department_History edh
JOIN HR_SDM.Employee_Dim ed
ON   edh.Employee_ID=ed.Employee_ID
JOIN HR_SDM.Departmen_Dim dd
ON   edh.Department_ID=dd.Department_ID
JOIN HR_SDM.Shift_Dim sd
ON   edh.Shift_ID = sd.Shift_ID
JOIN HR_SDM.Date_Dim d1
ON   edh.Start_Date=d1.FullDate
JOIN date_Dim d2
ON   edh.End_Date = d2.FullDate
JOIN HR_RDM.Employee e
ON   edh.Employee_ID=e.Employee_ID
;
