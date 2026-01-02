
.LOGON 192.168.3.128/dbc,dbc;
DATABASE DP_stage2;

--HR Module

-- Department table
--------------------------
-- Department table
--------------------------
CREATE TABLE DP_stage2.Department
(
    DepartmentID INTEGER GENERATED ALWAYS AS IDENTITY
    (
        START WITH 1 
        INCREMENT BY 1
        MINVALUE 1
        NO CYCLE
    ),
    DepartmentName VARCHAR(50),
    GroupName      VARCHAR(50)
)
UNIQUE PRIMARY INDEX (DepartmentID);

--------------------------
-- Shift table
--------------------------
CREATE TABLE DP_stage2.Shift
(
    ShiftID INTEGER GENERATED ALWAYS AS IDENTITY
    (
        START WITH 1
        INCREMENT BY 1
        MINVALUE 1
        NO CYCLE 
    ),
    Name VARCHAR(50),
    StartTime TIME(6),
    EndTime TIME(6)
)
UNIQUE PRIMARY INDEX (ShiftID);

--------------------------
-- Employee table
--------------------------
CREATE TABLE DP_stage2.Employee
(
    BusinessEntityID INTEGER,
    NationalIDNumber INTEGER,
    LoginID VARCHAR(50),
    JobTitle VARCHAR(50),
    BirthDate DATE FORMAT 'DD-MM-YYYY',   -- Better format
    Gender CHAR(1),
    HireDate DATE FORMAT 'DD-MM-YYYY',
    VacationHours INTEGER,
    SickLeaveHours INTEGER
)
UNIQUE PRIMARY INDEX (BusinessEntityID);

--------------------------
-- Employee Department History table
--------------------------
CREATE TABLE DP_stage2.EmployeeDepartmentHistory
(
    EmployeeID INTEGER,
    DepartmentID INTEGER,
    ShiftID INTEGER,
    StartDate DATE FORMAT 'DD-MM-YYYY',
    EndDate DATE FORMAT 'DD-MM-YYYY'
    
)
UNIQUE PRIMARY INDEX (EmployeeID, DepartmentID, ShiftID);
.LOGOFF