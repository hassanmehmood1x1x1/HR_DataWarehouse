
.LOGON 192.168.3.128/dbc,dbc;
DATABASE HR_RDM;

--HR Module


-- Employee table RDM
--------------------------
CREATE MULTISET TABLE HR_RDM.Employee
(
    Employee_ID        INTEGER NOT NULL,
    National_ID        INTEGER,
    Login_ID           VARCHAR(50),
    Job_Title          VARCHAR(50),
    Birth_Date         DATE,
    Gender             CHAR(1),
    Hire_Date          DATE,
    Vacation_Hours     INTEGER,
    Sick_Leave_Hours   INTEGER
)
PRIMARY INDEX (Employee_ID);


--------------------------
-- Shift table RDM
--------------------------
CREATE MULTISET TABLE HR_RDM.Shift
(
    Shift_ID    INTEGER NOT NULL,
    Shift_Name  VARCHAR(50),
    Start_Time  TIME(6),
    End_Time    TIME(6)
)
PRIMARY INDEX (Shift_ID);


--------------------------
-- Department table RDM
--------------------------
CREATE MULTISET TABLE HR_RDM.Department
(
    Department_ID   INTEGER NOT NULL,
    Department_Name VARCHAR(50),
    Group_Name      VARCHAR(50)
)
PRIMARY INDEX (Department_ID);


--------------------------
-- Employee Department History table RDM
--------------------------
CREATE MULTISET TABLE HR_RDM.Employee_Department_History
(
    Employee_ID   INTEGER NOT NULL,
    Department_ID INTEGER NOT NULL,
    Shift_ID      INTEGER NOT NULL,
    Start_Date    DATE,
    End_Date      DATE
)
PRIMARY INDEX (Employee_ID, Department_ID, Shift_ID);

.LOGOFF