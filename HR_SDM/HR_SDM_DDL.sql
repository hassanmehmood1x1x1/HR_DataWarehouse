
								------------- DIMENSION TABLES -------------

-- EMPLOYEE DIMENSION TABLE

CREATE MULTISET TABLE HR_SDM.Employee_Dim
(
 Employee_Key       integer generated always as identity , --PK FOR EMPLOYEE DIMENSION 
 Employee_ID  		integer,
 National_ID  		integer, 
 Login_ID           VARCHAR(50),
 Job_Title          VARCHAR(50),
 Birth_Date         DATE,
 Gender             CHAR(1),
 Hire_Date          DATE
 -- SICK AN VACATION HOURS R NOW FACTS
)
PRIMARY INDEX (Employee_Key);

-- DEPARTMENT DIMENSION TABLE

CREATE MULTISET TABLE HR_SDM.Departmen_Dim
(
    Department_Key INTEGER GENERATED ALWAYS AS IDENTITY,
    Department_ID INTEGER,
    Department_Name VARCHAR(100),
    Group_Name VARCHAR(100)

)
PRIMARY INDEX (Department_Key);



-- SHIFT DIMENSION TALE 

CREATE MULTISET TABLE HR_SDM.Shift_Dim
(
    Shift_Key INTEGER GENERATED ALWAYS AS IDENTITY,
    Shift_ID INTEGER,
    Shift_Name VARCHAR(50),
    StartTime TIME,
    EndTime TIME
    
 )
PRIMARY INDEX (Shift_Key);


-- DATE DIMENSION TABLE 

CREATE MULTISET TABLE HR_SDM.DimDate
(
    Date_Key INTEGER,          -- YYYYMMDD itll give smthin like after DML [(year)2025*10000=20250000 || (month)12*100=1200 || (day)04]  =20251204
    FullDate DATE,
    DayNumber INTEGER,
    MonthNumber INTEGER,
    MonthName VARCHAR(20),
    YearNumber INTEGER,
    QuarterNumber INTEGER

)
PRIMARY INDEX (Date_Key);


								------------- FACT TABLES -------------

CREATE MULTISET TABLE HR_SDM.Employee_Department_History_Fact
(
Employee_Key INTEGER,
Department_Key INTEGER,
Shift_Key       INTEGER,
StartDate_key	INTEGER,
EndDate_Key		INTEGER,
Vacation_Hours     INTEGER,
Sick_Leave_Hours   INTEGER
)
PRIMARY INDEX (Employee_Key);

