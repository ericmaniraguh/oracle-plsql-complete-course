-- ============================================================================
-- ORACLE EMPLOYEE MANAGEMENT SYSTEM - INSERT SAMPLE DATA
-- Complete data insertion for all 9 tables
-- ============================================================================

-- ============================================================================
-- 1. INSERT INTO COUNTRIES TABLE
-- ============================================================================
INSERT INTO Countries (Country_Name, Country_Code) VALUES ('Rwanda', 'RW');
INSERT INTO Countries (Country_Name, Country_Code) VALUES ('Uganda', 'UG');
INSERT INTO Countries (Country_Name, Country_Code) VALUES ('Kenya', 'KE');
INSERT INTO Countries (Country_Name, Country_Code) VALUES ('Tanzania', 'TZ');
INSERT INTO Countries (Country_Name, Country_Code) VALUES ('Burundi', 'BI');

COMMIT;

-- ============================================================================
-- 2. INSERT INTO DEPARTMENTS TABLE
-- ============================================================================
INSERT INTO Departments (Department_Name, Location, Country_ID, Budget) 
    VALUES ('Human Resources', 'Kigali', 1, 500000);

INSERT INTO Departments (Department_Name, Location, Country_ID, Budget) 
    VALUES ('Finance', 'Kigali', 1, 750000);

INSERT INTO Departments (Department_Name, Location, Country_ID, Budget) 
    VALUES ('Information Technology', 'Kigali', 1, 1200000);

INSERT INTO Departments (Department_Name, Location, Country_ID, Budget) 
    VALUES ('Sales', 'Kampala', 2, 600000);

INSERT INTO Departments (Department_Name, Location, Country_ID, Budget) 
    VALUES ('Marketing', 'Kigali', 1, 400000);

INSERT INTO Departments (Department_Name, Location, Country_ID, Budget) 
    VALUES ('Operations', 'Nairobi', 3, 800000);

COMMIT;

-- ============================================================================
-- 3. INSERT INTO ROLES TABLE
-- ============================================================================
INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Senior Manager', 'Manages a department with full authority and budget control');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Manager', 'Manages a team of employees with supervisory responsibilities');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Senior Developer', 'Develops and maintains software with senior-level expertise');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Developer', 'Develops and maintains software code');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Junior Developer', 'Develops software with guidance from senior developers');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('HR Specialist', 'Handles recruitment, training, and employee relations');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Finance Analyst', 'Analyzes financial data and prepares reports');

INSERT INTO Roles (Role_Name, Description) 
    VALUES ('Sales Representative', 'Manages customer relationships and sales targets');

COMMIT;

-- ============================================================================
-- 4. INSERT INTO EMPLOYEES TABLE
-- ============================================================================
-- Employee 1: Alice Kanayana - HR Senior Manager
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Alice', 'Kanayana', 'alice.kanayana@company.com', '+250788123456', 'Kigali, Rwanda', 
            TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1, 1, 85000, 'Active');

-- Employee 2: Bob Muhire - Finance Senior Manager
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Bob', 'Muhire', 'bob.muhire@company.com', '+250788234567', 'Kigali, Rwanda', 
            TO_DATE('2020-06-01', 'YYYY-MM-DD'), 2, 1, 80000, 'Active');

-- Employee 3: Christine Imanuel - IT Manager
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Christine', 'Imanuel', 'christine.imanuel@company.com', '+250788345678', 'Kigali, Rwanda', 
            TO_DATE('2021-03-10', 'YYYY-MM-DD'), 3, 2, 75000, 'Active');

-- Employee 4: David Karamba - Senior Developer
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('David', 'Karamba', 'david.karamba@company.com', '+250788456789', 'Kigali, Rwanda', 
            TO_DATE('2021-07-20', 'YYYY-MM-DD'), 3, 3, 65000, 'Active');

-- Employee 5: Emma Murumbi - Developer
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Emma', 'Murumbi', 'emma.murumbi@company.com', '+250788567890', 'Kigali, Rwanda', 
            TO_DATE('2022-01-12', 'YYYY-MM-DD'), 3, 4, 45000, 'Active');

-- Employee 6: Frank Nyaruaba - Junior Developer
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Frank', 'Nyaruaba', 'frank.nyaruaba@company.com', '+250788678901', 'Kigali, Rwanda', 
            TO_DATE('2022-09-05', 'YYYY-MM-DD'), 3, 5, 35000, 'Active');

-- Employee 7: Grace Nshimiyimana - HR Specialist
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Grace', 'Nshimiyimana', 'grace.nshimiyimana@company.com', '+250788789012', 'Kigali, Rwanda', 
            TO_DATE('2020-05-14', 'YYYY-MM-DD'), 1, 6, 50000, 'Active');

-- Employee 8: Henry Uwayezu - Finance Analyst
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Henry', 'Uwayezu', 'henry.uwayezu@company.com', '+250788890123', 'Kigali, Rwanda', 
            TO_DATE('2021-02-08', 'YYYY-MM-DD'), 2, 7, 55000, 'Active');

-- Employee 9: Iris Kimani - Sales Representative
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('Iris', 'Kimani', 'iris.kimani@company.com', '+250788901234', 'Kampala, Uganda', 
            TO_DATE('2021-11-22', 'YYYY-MM-DD'), 4, 8, 48000, 'Active');

-- Employee 10: John Okafor - Operations Manager
INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, Hire_Date, Department_ID, Role_ID, Salary, Status)
    VALUES ('John', 'Okafor', 'john.okafor@company.com', '+250789012345', 'Nairobi, Kenya', 
            TO_DATE('2022-04-18', 'YYYY-MM-DD'), 6, 2, 70000, 'Active');

COMMIT;

-- ============================================================================
-- 5. INSERT INTO MANAGERS TABLE
-- ============================================================================
-- Alice is manager of HR Department
INSERT INTO Managers (Employee_ID, Department_ID, Manager_Since) 
    VALUES (1, 1, TO_DATE('2020-01-15', 'YYYY-MM-DD'));

-- Bob is manager of Finance Department
INSERT INTO Managers (Employee_ID, Department_ID, Manager_Since) 
    VALUES (2, 2, TO_DATE('2020-06-01', 'YYYY-MM-DD'));

-- Christine is manager of IT Department
INSERT INTO Managers (Employee_ID, Department_ID, Manager_Since) 
    VALUES (3, 3, TO_DATE('2021-03-10', 'YYYY-MM-DD'));

-- John is manager of Operations Department
INSERT INTO Managers (Employee_ID, Department_ID, Manager_Since) 
    VALUES (10, 6, TO_DATE('2022-04-18', 'YYYY-MM-DD'));

COMMIT;

-- ============================================================================
-- 6. INSERT INTO ALLOWANCES TABLE
-- ============================================================================
-- Senior Manager allowances
INSERT INTO Allowances (Role_ID, Allowance_Name, Allowance_Amount, Effective_Date, Is_Applicable, Comments) 
    VALUES (1, 'Housing Allowance', 15000, TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Y', 'For senior management level');

INSERT INTO Allowances (Role_ID, Allowance_Name, Allowance_Amount, Effective_Date, Is_Applicable, Comments) 
    VALUES (1, 'Transportation Allowance', 8000, TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Y', 'Monthly transportation');

-- Manager allowances
INSERT INTO Allowances (Role_ID, Allowance_Name, Allowance_Amount, Effective_Date, Is_Applicable, Comments) 
    VALUES (2, 'Transportation Allowance', 5000, TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Y', 'Monthly transportation');

-- Developer allowances
INSERT INTO Allowances (Role_ID, Allowance_Name, Allowance_Amount, Effective_Date, Is_Applicable, Comments) 
    VALUES (3, 'Technical Allowance', 10000, TO_DATE('2021-01-01', 'YYYY-MM-DD'), 'Y', 'Technical skills allowance');

INSERT INTO Allowances (Role_ID, Allowance_Name, Allowance_Amount, Effective_Date, Is_Applicable, Comments) 
    VALUES (4, 'Technical Allowance', 5000, TO_DATE('2021-01-01', 'YYYY-MM-DD'), 'Y', 'Technical skills allowance');

COMMIT;

-- ============================================================================
-- 7. INSERT INTO ATTENDANCE TABLE
-- ============================================================================
-- Today's attendance
INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Check_Out_Time, Status, Notes) 
    VALUES (1, TRUNC(SYSDATE), TO_TIMESTAMP('2025-11-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_TIMESTAMP('2025-11-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Present', 'Regular working hours');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Check_Out_Time, Status, Notes) 
    VALUES (2, TRUNC(SYSDATE), TO_TIMESTAMP('2025-11-02 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_TIMESTAMP('2025-11-02 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Present', 'Regular working hours');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Status, Notes) 
    VALUES (3, TRUNC(SYSDATE), 'Leave', 'Annual leave approved');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Status, Notes) 
    VALUES (4, TRUNC(SYSDATE), TO_TIMESTAMP('2025-11-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Late', 'Traffic delay');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Check_Out_Time, Status, Notes) 
    VALUES (5, TRUNC(SYSDATE), TO_TIMESTAMP('2025-11-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_TIMESTAMP('2025-11-02 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Present', 'Regular working hours');

-- Previous day attendance
INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Check_Out_Time, Status, Notes) 
    VALUES (6, TRUNC(SYSDATE) - 1, TO_TIMESTAMP('2025-11-01 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_TIMESTAMP('2025-11-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Present', 'Regular working hours');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Check_Out_Time, Status, Notes) 
    VALUES (7, TRUNC(SYSDATE) - 1, TO_TIMESTAMP('2025-11-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
            TO_TIMESTAMP('2025-11-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Present', 'Regular working hours');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Status, Notes) 
    VALUES (8, TRUNC(SYSDATE) - 1, 'Absent', 'Medical leave');

INSERT INTO Attendance (Employee_ID, Attendance_Date, Check_In_Time, Status, Notes) 
    VALUES (9, TRUNC(SYSDATE) - 1, TO_TIMESTAMP('2025-11-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Late', 'Personal reasons');

COMMIT;

-- ============================================================================
-- 8. INSERT INTO PERFORMANCE_EVALUATIONS TABLE
-- ============================================================================
-- Q3 Performance Evaluations
INSERT INTO Performance_Evaluations (Employee_ID, Evaluator_ID, Evaluation_Date, Performance_Score, Comments) 
    VALUES (4, 3, TRUNC(SYSDATE) - 30, 4.5, 'Excellent performance, very productive, good team player');

INSERT INTO Performance_Evaluations (Employee_ID, Evaluator_ID, Evaluation_Date, Performance_Score, Comments) 
    VALUES (5, 3, TRUNC(SYSDATE) - 30, 4.0, 'Good performance, needs improvement in communication skills');

INSERT INTO Performance_Evaluations (Employee_ID, Evaluator_ID, Evaluation_Date, Performance_Score, Comments) 
    VALUES (6, 3, TRUNC(SYSDATE) - 30, 3.5, 'Average performance, more focus needed on code quality');

INSERT INTO Performance_Evaluations (Employee_ID, Evaluator_ID, Evaluation_Date, Performance_Score, Comments) 
    VALUES (9, 10, TRUNC(SYSDATE) - 15, 4.2, 'Strong sales performance this quarter, exceeded targets');

-- Additional evaluations
INSERT INTO Performance_Evaluations (Employee_ID, Evaluator_ID, Evaluation_Date, Performance_Score, Comments) 
    VALUES (8, 2, TRUNC(SYSDATE) - 20, 4.3, 'Excellent financial analysis and reporting');

INSERT INTO Performance_Evaluations (Employee_ID, Evaluator_ID, Evaluation_Date, Performance_Score, Comments) 
    VALUES (7, 1, TRUNC(SYSDATE) - 25, 4.7, 'Outstanding HR management and employee relations');

COMMIT;

-- ============================================================================
-- 9. INSERT INTO SALARY_HISTORY TABLE
-- ============================================================================
-- Alice's salary increase
INSERT INTO Salary_History (Employee_ID, Previous_Salary, New_Salary, Change_Date, Reason) 
    VALUES (1, 80000, 85000, TRUNC(SYSDATE) - 365, 'Annual salary increment for performance');

-- David's salary increase (Promotion)
INSERT INTO Salary_History (Employee_ID, Previous_Salary, New_Salary, Change_Date, Reason) 
    VALUES (4, 60000, 65000, TRUNC(SYSDATE) - 180, 'Promotion to Senior Developer');

-- Emma's salary increase
INSERT INTO Salary_History (Employee_ID, Previous_Salary, New_Salary, Change_Date, Reason) 
    VALUES (5, 40000, 45000, TRUNC(SYSDATE) - 90, 'Annual salary increment');

-- Bob's salary increase
INSERT INTO Salary_History (Employee_ID, Previous_Salary, New_Salary, Change_Date, Reason) 
    VALUES (2, 75000, 80000, TRUNC(SYSDATE) - 150, 'Annual merit increase');

-- Henry's salary increase
INSERT INTO Salary_History (Employee_ID, Previous_Salary, New_Salary, Change_Date, Reason) 
    VALUES (8, 50000, 55000, TRUNC(SYSDATE) - 120, 'Performance bonus and increment');

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Count records in each table
SELECT 'COUNTRIES' as Table_Name, COUNT(*) as Records FROM Countries
UNION ALL
SELECT 'DEPARTMENTS', COUNT(*) FROM Departments
UNION ALL
SELECT 'ROLES', COUNT(*) FROM Roles
UNION ALL
SELECT 'EMPLOYEES', COUNT(*) FROM Employees
UNION ALL
SELECT 'MANAGERS', COUNT(*) FROM Managers
UNION ALL
SELECT 'ALLOWANCES', COUNT(*) FROM Allowances
UNION ALL
SELECT 'ATTENDANCE', COUNT(*) FROM Attendance
UNION ALL
SELECT 'PERFORMANCE_EVALUATIONS', COUNT(*) FROM Performance_Evaluations
UNION ALL
SELECT 'SALARY_HISTORY', COUNT(*) FROM Salary_History
ORDER BY Table_Name;

-- ============================================================================
-- END OF INSERT DATA SCRIPT
-- ============================================================================