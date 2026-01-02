.LOGON 192.168.3.128/dbc,dbc;
DATABASE HR_RDM;

--------------------------
-- 1️⃣ Employee Table RDM
--------------------------
INSERT INTO HR_RDM.Employee
SELECT *
FROM DP_stage2.Employee;

--------------------------
-- 2️⃣ Department Table RDM
--------------------------
INSERT INTO HR_RDM.Department
SELECT *
FROM DP_stage2.Department;

--------------------------
-- 3️⃣ Shift Table RDM
--------------------------
INSERT INTO HR_RDM.Shift
SELECT *
FROM DP_stage2.Shift;

--------------------------
-- 4️⃣ Employee_Department_History Table RDM
-------------------------- 
INSERT INTO HR_RDM.Employee_Department_History
SELECT *
FROM DP_stage2.EmployeeDepartmentHistory;

.LOGOFF;
