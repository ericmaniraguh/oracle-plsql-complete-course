-- ============================================================================
-- ORACLE EMPLOYEE MANAGEMENT SYSTEM - INSERT 500+ EMPLOYEES
-- Large-scale bulk data insertion for comprehensive testing
-- ============================================================================

-- ============================================================================
-- GENERATE 500+ EMPLOYEES USING PL/SQL BLOCK
-- This is more efficient than 500 individual INSERT statements
-- ============================================================================

BEGIN
  -- Initialize counter
  DECLARE
    v_emp_id NUMBER := 111; -- Starting from Employee ID 111 (after 110)
    v_dept_id NUMBER;
    v_role_id NUMBER;
    v_salary NUMBER;
    v_first_name VARCHAR2(50);
    v_last_name VARCHAR2(50);
    v_email VARCHAR2(100);
    v_phone VARCHAR2(15);
    v_address VARCHAR2(255);
    v_hire_date DATE;
    v_status VARCHAR2(20) := 'Active';
    
    -- Array of first names
    TYPE first_names_type IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    v_first_names first_names_type;
    
    -- Array of last names
    TYPE last_names_type IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    v_last_names last_names_type;
    
    -- Counter variables
    v_first_count PLS_INTEGER := 0;
    v_last_count PLS_INTEGER := 0;
    v_loop_count PLS_INTEGER := 0;
    v_max_employees CONSTANT PLS_INTEGER := 500;
    
  BEGIN
    -- Populate first names array
    v_first_names(1) := 'Alex';
    v_first_names(2) := 'Benjamin';
    v_first_names(3) := 'Catherine';
    v_first_names(4) := 'David';
    v_first_names(5) := 'Emma';
    v_first_names(6) := 'Frank';
    v_first_names(7) := 'Grace';
    v_first_names(8) := 'Henry';
    v_first_names(9) := 'Iris';
    v_first_names(10) := 'James';
    v_first_names(11) := 'Karen';
    v_first_names(12) := 'Leo';
    v_first_names(13) := 'Michelle';
    v_first_names(14) := 'Nathan';
    v_first_names(15) := 'Olivia';
    v_first_names(16) := 'Peter';
    v_first_names(17) := 'Quinn';
    v_first_names(18) := 'Rachel';
    v_first_names(19) := 'Samuel';
    v_first_names(20) := 'Tina';
    
    -- Populate last names array
    v_last_names(1) := 'Nkusi';
    v_last_names(2) := 'Nyaruhoza';
    v_last_names(3) := 'Karekezi';
    v_last_names(4) := 'Mukakarangwa';
    v_last_names(5) := 'Kamali';
    v_last_names(6) := 'Rutayisire';
    v_last_names(7) := 'Imanuel';
    v_last_names(8) := 'Nkurunziza';
    v_last_names(9) := 'Mutoni';
    v_last_names(10) := 'Ingabire';
    v_last_names(11) := 'Uwimana';
    v_last_names(12) := 'Kayitare';
    v_last_names(13) := 'Kwiriyavuma';
    v_last_names(14) := 'Twagirimana';
    v_last_names(15) := 'Nsabimana';
    v_last_names(16) := 'Mbarushimana';
    v_last_names(17) := 'Habiyaremye';
    v_last_names(18) := 'Kagaba';
    v_last_names(19) := 'Nyirahabimana';
    v_last_names(20) := 'Sebarenzi';
    
    v_first_count := v_first_names.COUNT;
    v_last_count := v_last_names.COUNT;
    
    -- Main loop to insert 500 employees
    FOR i IN 1..v_max_employees LOOP
      -- Distribute across departments
      v_dept_id := MOD(i, 6) + 1;  -- Departments 1-6
      
      -- Assign roles based on department
      CASE v_dept_id
        WHEN 1 THEN v_role_id := 6; v_salary := 40000 + (MOD(i, 15000)/100);  -- HR
        WHEN 2 THEN v_role_id := 7; v_salary := 48000 + (MOD(i, 8000)/100);   -- Finance
        WHEN 3 THEN v_role_id := MOD(i, 3) + 3; v_salary := 32000 + (MOD(i, 14000)/100); -- IT (3,4,5)
        WHEN 4 THEN v_role_id := 8; v_salary := 39000 + (MOD(i, 17000)/100);  -- Sales
        WHEN 5 THEN v_role_id := 8; v_salary := 31000 + (MOD(i, 14000)/100);  -- Marketing
        WHEN 6 THEN v_role_id := 8; v_salary := 29000 + (MOD(i, 14000)/100);  -- Operations
      END CASE;
      
      -- Select random first and last names
      v_first_name := v_first_names(MOD(i-1, v_first_count) + 1);
      v_last_name := v_last_names(MOD(i-1, v_last_count) + 1);
      
      -- Generate unique email
      v_email := LOWER(v_first_name || '.' || v_last_name || i || '@company.com');
      
      -- Generate phone number
      v_phone := '+250788' || LPAD(TO_CHAR(MOD(i, 999999)), 6, '0');
      
      -- Generate address based on department location
      CASE v_dept_id
        WHEN 1 THEN v_address := 'Kigali, Rwanda - District ' || MOD(i, 30);
        WHEN 2 THEN v_address := 'Kigali, Rwanda - Zone ' || MOD(i, 25);
        WHEN 3 THEN v_address := 'Kigali, Rwanda - Area ' || MOD(i, 20);
        WHEN 4 THEN v_address := 'Kampala, Uganda - Zone ' || MOD(i, 20);
        WHEN 5 THEN v_address := 'Kigali, Rwanda - Sector ' || MOD(i, 15);
        WHEN 6 THEN v_address := 'Nairobi, Kenya - District ' || MOD(i, 25);
      END CASE;
      
      -- Generate hire date (spread across 2020-2024)
      v_hire_date := TO_DATE('2020-01-01', 'YYYY-MM-DD') + MOD(i, 1460);
      
      -- Insert employee
      INSERT INTO Employees (First_Name, Last_Name, Email, Phone_Number, Address, 
                            Hire_Date, Department_ID, Role_ID, Salary, Status)
      VALUES (v_first_name, v_last_name, v_email, v_phone, v_address,
              v_hire_date, v_dept_id, v_role_id, v_salary, v_status);
      
      -- Commit every 100 records for better performance
      IF MOD(i, 100) = 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Inserted ' || i || ' employees...');
      END IF;
    END LOOP;
    
    -- Final commit
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully inserted ' || v_max_employees || ' employees!');
    
  END;
END;
/

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Total count
SELECT COUNT(*) as Total_Employees FROM Employees;

-- Count by department
SELECT d.Department_Name, COUNT(e.Employee_ID) as Employee_Count
FROM Departments d
LEFT JOIN Employees e ON d.Department_ID = d.Department_ID
GROUP BY d.Department_ID, d.Department_Name
ORDER BY Employee_Count DESC;

-- Salary statistics by department
SELECT d.Department_Name, 
       COUNT(e.Employee_ID) as Count,
       ROUND(AVG(e.Salary), 2) as Avg_Salary,
       MAX(e.Salary) as Max_Salary,
       MIN(e.Salary) as Min_Salary,
       SUM(e.Salary) as Total_Payroll
FROM Departments d
LEFT JOIN Employees e ON d.Department_ID = e.Department_ID
GROUP BY d.Department_ID, d.Department_Name
ORDER BY Count DESC;

-- Sample of newly added employees
SELECT Employee_ID, First_Name, Last_Name, Email, Salary, Hire_Date
FROM Employees
WHERE Employee_ID > 110
ORDER BY Employee_ID
FETCH FIRST 20 ROWS ONLY;

-- Salary range distribution
SELECT 
    CASE 
        WHEN Salary < 35000 THEN 'Entry Level (< 35K)'
        WHEN Salary BETWEEN 35000 AND 45000 THEN 'Mid Level (35K-45K)'
        WHEN Salary > 45000 THEN 'Senior Level (> 45K)'
    END as Salary_Range,
    COUNT(*) as Employee_Count,
    ROUND(AVG(Salary), 2) as Avg_Salary
FROM Employees
GROUP BY CASE 
        WHEN Salary < 35000 THEN 'Entry Level (< 35K)'
        WHEN Salary BETWEEN 35000 AND 45000 THEN 'Mid Level (35K-45K)'
        WHEN Salary > 45000 THEN 'Senior Level (> 45K)'
    END
ORDER BY Salary_Range;

-- Hire date distribution
SELECT 
    EXTRACT(YEAR FROM Hire_Date) as Year,
    COUNT(*) as Hired_Count
FROM Employees
WHERE Employee_ID > 110
GROUP BY EXTRACT(YEAR FROM Hire_Date)
ORDER BY Year;

-- ============================================================================
-- END OF 500+ EMPLOYEE INSERTION
-- ============================================================================