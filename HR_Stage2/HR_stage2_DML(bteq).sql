.LOGON 192.168.3.128/dbc,dbc;
DATABASE DP_stage2;

INSERT INTO DP_stage2.Department(DepartmentID,DepartmentName,GroupName)
SELECT DISTINCT
    1,
    Name1,
    GroupName
FROM DP_stage1.HR;


INSERT INTO DP_stage2.Shift(ShiftID,Name,StartTime,EndTime)
SELECT DISTINCT 
    1,
    CASE WHEN Name2='NULL' OR Name2 IS NULL THEN 'N/A' ELSE Name2 END AS Name2,
    CAST (SUBSTR (StartTime,1,5) || ':00' AS TIME),
    CAST (SUBSTR (EndTime,1,5)|| ':00' AS TIME)
FROM DP_stage1.HR;

-- set shift timings manually
UPDATE DP_stage2.Shift 
SET StartTime=CASE Name 
WHEN 'Day' THEN '07:00:00'
WHEN 'Night' THEN '23:00:00'
WHEN 'Evening' THEN '15:00:00' 
END,

EndTime=case Name
WHEN 'Day' THEN '15:00:00'
WHEN 'Night' THEN '07:00:00'
WHEN 'Evening' THEN '23:00:00' 
END; 
;


INSERT INTO DP_stage2.Employee
SELECT DISTINCT 
	CASE WHEN BusinessEntityID='NULL' OR BusinessEntityID IS NULL THEN -1 ELSE BusinessEntityID END AS BusinessEntityID,
	CASE WHEN NationalIDNumber='NULL' OR NationalIDNumber IS NULL THEN -1 ELSE NationalIDNumber END AS NationalIDNumber,
	CASE WHEN LoginID='NULL' OR LoginID IS NULL THEN 'N/A' ELSE  LoginID END AS LoginID,
	CASE WHEN JobTitle='NULL' OR JobTitle IS NULL THEN 'N/A' ELSE  JobTitle END AS JobTitle,
	CAST (BirthDate AS DATE FORMAT 'DD-MM-YYYY'),
	CASE WHEN Gender='NULL' OR Gender IS NULL THEN '-' ELSE  Gender END AS Gender,
	CAST (HireDate AS DATE FORMAT 'DD-MM-YYYY'),
	CASE WHEN VacationHours ='NULL' OR VacationHours IS NULL THEN -1 ELSE VacationHours END AS VacationHours,
	CASE WHEN SickLeaveHours ='NULL' OR SickLeaveHours IS NULL THEN -1 ELSE SickLeaveHours END AS SickLeaveHours
FROM DP_stage1.HR;

INSERT INTO DP_stage2.EmployeeDepartmentHistory
SELECT DISTINCT
CASE WHEN a.BusinessEntityID='NULL' OR a.BusinessEntityID IS NULL THEN -1 ELSE a.BusinessEntityID END AS BusinessEntityID,
CASE WHEN c.ShiftID IS NULL THEN -1 ELSE c.ShiftID END AS ShiftID,
CASE WHEN d.DepartmentID IS NULL THEN -1 ELSE d.DepartmentID END AS DepartmentID,
CASE WHEN a.StartDate='NULL' OR a.StartDate IS NULL THEN  CAST ('01-01-1900' AS DATE FORMAT 'DD-MM-YYYY') ELSE CAST(a.StartDate AS DATE FORMAT 'DD-MM-YYYY') END AS StartDate,
CASE WHEN a.EndDate='NULL' OR a.EndDate IS NULL THEN  CAST ('01-01-1900' AS DATE FORMAT 'DD-MM-YYYY') ELSE CAST(a.EndDate AS DATE FORMAT 'DD-MM-YYYY') END AS EndDate
FROM DP_stage1.HR a
INNER JOIN DP_stage2.Shift c
ON a.Name2=c.Name
INNER JOIN DP_stage2.Department d
ON a.Name1=d.DepartmentName;


.LOGOFF









