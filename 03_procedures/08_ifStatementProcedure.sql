/*
================================================================================
MS QUESTION & COMPLETE ANSWER
Employee Management System - Bonus Calculation
================================================================================

THE QUESTION (SHORT VERSION):
==============================

Write a PL/SQL procedure "sp_calculate_bonus" with the following:

PARAMETERS:
-----------
1. p_employee_id (IN)         : Employee ID to process
2. p_bonus_percent (IN OUT)   : Input bonus % ? Output adjusted %
3. p_final_amount (OUT)       : Calculated bonus amount  
4. p_message (OUT)            : Success/Error message

BUSINESS LOGIC (Using IF Statements):
--------------------------------------
1. IF salary >= 60,000:  Add 2% to bonus
2. IF salary 40,000-60,000: Keep bonus unchanged
3. IF salary < 40,000:  Deduct 1% from bonus
4. IF department is 'IT': Add additional 5% bonus
5. Handle exceptions: NO_DATA_FOUND, NULL parameters

EXAMPLE:
--------
Input: Employee 4 (IT Dept, Salary 65,000), Bonus 5%
Process: 65,000 >= 60,000 (+2) = 7%, IT Dept (+5) = 12%
Output: Bonus_Percent=12, Final_Amount=7800, Message="SUCCESS..."

================================================================================
THE COMPLETE ANSWER:
====================
*/
CREATE OR REPLACE PROCEDURE sp_calculate_bonus (
    p_employee_id     IN NUMBER,
    p_bonus_percent   IN OUT NUMBER,
    p_final_amount    OUT NUMBER,
    p_message         OUT VARCHAR2
) AS
    v_salary NUMBER;
    v_dept VARCHAR2(100);
    v_bonus NUMBER;
BEGIN
    -- INPUT VALIDATION (IF Statement 1)
    IF p_employee_id IS NULL OR p_bonus_percent IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid parameters: Employee ID and Bonus % required');
    END IF;
    
    -- FETCH EMPLOYEE DATA (Using IN Parameter)
    BEGIN
        SELECT e.Salary, d.Department_Name
        INTO v_salary, v_dept 
        FROM Employees e
        JOIN Departments d ON e.Department_ID = d.Department_ID
        WHERE e.Employee_ID = p_employee_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_message := 'ERROR: Employee ID ' || p_employee_id || ' not found';
            p_final_amount := 0;
            RETURN;
        WHEN OTHERS THEN
            p_message := 'ERROR: ' || SQLERRM;
            p_final_amount := 0;
            RETURN;
    END;
    
    -- SALARY-BASED BONUS ADJUSTMENT (IF Statement 2: IF-ELSIF-ELSE)
    IF v_salary >= 60000 THEN
        -- High salary: Add 2% to bonus (Reads IN OUT parameter)
        v_bonus := p_bonus_percent + 2;
    ELSIF v_salary >= 40000 THEN
        -- Medium salary: Keep bonus unchanged
        v_bonus := p_bonus_percent;
    ELSE
        -- Low salary: Deduct 1% from bonus
        v_bonus := p_bonus_percent - 1;
    END IF;
    
    -- DEPARTMENT-BASED BONUS ADJUSTMENT (IF Statement 3)
    IF v_dept = 'Information Technology' THEN
        -- IT employees get extra 5% bonus
        v_bonus := v_bonus + 5;
    END IF;
    
    -- UPDATE IN OUT PARAMETER (Modified value returned to caller)
    p_bonus_percent := v_bonus;
    
    -- CALCULATE FINAL AMOUNT (Write to OUT Parameter)
    p_final_amount := ROUND(v_salary * (v_bonus / 100), 2);
    
    -- SET SUCCESS MESSAGE (Write to OUT Parameter)
    p_message := 'SUCCESS: Adjusted bonus=' || v_bonus || 
                 '%, Amount=' || p_final_amount;
    
EXCEPTION
    WHEN OTHERS THEN
        p_message := 'ERROR: Unexpected error - ' || SQLERRM;
        p_final_amount := 0;
END sp_calculate_bonus;
/

--================================================================================
--TEST EXECUTION WITH RESULTS:
--============================

-- TEST 1: Success Case (IT, High Salary)

SET SERVEROUTPUT ON;

DECLARE
    v_bonus NUMBER := 5;
    v_amount NUMBER;
    v_msg VARCHAR2(200);
BEGIN
    sp_calculate_bonus(4, v_bonus, v_amount, v_msg);
    DBMS_OUTPUT.PUT_LINE('Bonus %: ' || v_bonus || ' | Amount: ' || 
                         v_amount || ' | ' || v_msg);
END;
/

/*
OUTPUT: Bonus %: 12 | Amount: 7800 | SUCCESS: Adjusted bonus=12%, Amount=7800
*/

-- TEST 2: Medium Salary (No IT Dept)
DECLARE
    v_bonus NUMBER := 3;
    v_amount NUMBER;
    v_msg VARCHAR2(200);
BEGIN
    sp_calculate_bonus(2, v_bonus, v_amount, v_msg);
    DBMS_OUTPUT.PUT_LINE('Bonus %: ' || v_bonus || ' | Amount: ' || v_amount);
END;
/
/*
OUTPUT: Bonus %: 3 | Amount: 1440
*/
-- TEST 3: Exception - Employee Not Found
DECLARE
    v_bonus NUMBER := 5;
    v_amount NUMBER;
    v_msg VARCHAR2(200);
BEGIN
    sp_calculate_bonus(999, v_bonus, v_amount, v_msg);
    DBMS_OUTPUT.PUT_LINE('Message: ' || v_msg);
END;
/
OUTPUT: Message: ERROR: Employee ID 999 not found

-- TEST 4: Exception - NULL Parameter
DECLARE
    v_bonus NUMBER := NULL;
    v_amount NUMBER;
    v_msg VARCHAR2(200);
BEGIN
    sp_calculate_bonus(5, v_bonus, v_amount, v_msg);
    DBMS_OUTPUT.PUT_LINE('Message: ' || v_msg);
END;
/

/*
OUTPUT: Message: ERROR: Invalid parameters: Employee ID and Bonus % required
*/

/*
================================================================================
PARAMETER TYPES EXPLAINED:
==========================

p_employee_id (IN):
  - Direction: INPUT only
  - Can READ: YES (use in WHERE clause)
  - Can MODIFY: NO (read-only)
  - Can RETURN: NO (not sent back to caller)
  - Usage: WHERE e.Employee_ID = p_employee_id
  - Example: Pass 4 to identify which employee

p_bonus_percent (IN OUT):
  - Direction: INPUT AND OUTPUT
  - Can READ: YES (use input value in calculation)
  - Can MODIFY: YES (adjust based on business logic)
  - Can RETURN: YES (return modified value to caller)
  - Usage: Read as p_bonus_percent, modify, write back as p_bonus_percent
  - Example: Input 5 ? Inside calc ? Output 12

p_final_amount (OUT):
  - Direction: OUTPUT only
  - Can READ: NO (don't use as input)
  - Can MODIFY: YES (assign calculated value)
  - Can RETURN: YES (send back to caller)
  - Usage: p_final_amount := v_salary * (v_bonus / 100)
  - Example: Returns 7800 as the bonus amount

p_message (OUT):
  - Direction: OUTPUT only
  - Can READ: NO (don't use as input)
  - Can MODIFY: YES (assign status message)
  - Can RETURN: YES (send back to caller)
  - Usage: p_message := 'SUCCESS: ...' OR 'ERROR: ...'
  - Example: Returns "SUCCESS: Adjusted bonus=12%, Amount=7800"

================================================================================
*/

/*
IF STATEMENTS USED:
===================

IF Statement 1: Input Validation
---------------------------------
IF p_employee_id IS NULL OR p_bonus_percent IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid parameters...');
END IF;

Purpose: Ensure required parameters are provided
Location: Very beginning of procedure
Action: Raise error if validation fails

IF Statement 2: Salary-Based Adjustment (IF-ELSIF-ELSE)
-------------------------------------------------------
IF v_salary >= 60000 THEN
    v_bonus := p_bonus_percent + 2;        -- High: +2%
ELSIF v_salary >= 40000 THEN
    v_bonus := p_bonus_percent;            -- Medium: No change
ELSE
    v_bonus := p_bonus_percent - 1;        -- Low: -1%
END IF;

Purpose: Apply different bonus adjustments by salary tier
Logic: Three tiers of salary ranges
Action: Modify bonus percentage accordingly

IF Statement 3: Department Bonus
--------------------------------
IF v_dept = 'Information Technology' THEN
    v_bonus := v_bonus + 5;                -- IT: +5% extra
END IF;

Purpose: Apply additional bonus for IT department
Logic: Department-specific incentive
Action: Add 5% to the already-adjusted bonus

================================================================================
EXCEPTION HANDLING USED:
========================

Exception 1: NO_DATA_FOUND
--------------------------
Location: SELECT statement inside BEGIN-EXCEPTION block
Trigger: Employee ID doesn't exist in database
Handler:
    WHEN NO_DATA_FOUND THEN
        p_message := 'ERROR: Employee ID ' || p_employee_id || ' not found';
        p_final_amount := 0;
        RETURN;
Result: Returns error message, amount=0, exits gracefully

Exception 2: OTHERS
-------------------
Location: BEGIN-EXCEPTION block (catch-all)
Trigger: Any other unexpected error
Handler:
    WHEN OTHERS THEN
        p_message := 'ERROR: ' || SQLERRM;
        p_final_amount := 0;
        RETURN;
Result: Captures error message using SQLERRM, returns to caller

Exception 3: Custom Validation Error
------------------------------------
Location: Initial input validation
Trigger: When NULL parameters provided
Handler:
    RAISE_APPLICATION_ERROR(-20001, 'Invalid parameters...');
Result: Immediately raises error with custom message

================================================================================
KEY CONCEPTS SUMMARY:
====================

Parameter Types:
  ? IN:     Read-only input (employee_id)
  ? OUT:    Write-only output (final_amount, message)
  ? IN OUT: Read input, write output (bonus_percent: 5 in, 12 out)

IF Statements:
  ? Validate input parameters (NULL check)
  ? Implement salary tier logic (IF-ELSIF-ELSE)
  ? Apply department bonus (simple IF)

Exception Handling:
  ? Catch NO_DATA_FOUND (employee doesn't exist)
  ? Catch OTHERS (any other error)
  ? Use RAISE_APPLICATION_ERROR for custom errors

Business Logic:
  ? Salary >= 60K: +2% bonus
  ? Salary 40K-60K: No change
  ? Salary < 40K: -1% bonus
  ? IT department: +5% extra

Return Values:
  ? p_bonus_percent: Modified percentage (IN OUT)
  ? p_final_amount: Calculated amount (OUT)
  ? p_message: Success/error status (OUT)

================================================================================
EXAM TIPS:
==========

1. Understand parameter directions:
   - IN = Use in WHERE, cannot modify
   - OUT = Must assign value before returning
   - IN OUT = Can read input and modify output

2. Structure your code:
   - Declare variables
   - Validate input (IF)
   - Fetch data (SELECT-BEGIN-EXCEPTION)
   - Apply business logic (IF statements)
   - Assign OUT parameters
   - Handle exceptions (WHEN clauses)

3. Common mistakes to avoid:
   ? Not declaring parameter type
   ? Trying to read OUT parameter
   ? Trying to write IN parameter
   ? Forgetting END IF for IF statements
   ? Missing WHEN clause in EXCEPTION
   ? Not assigning OUT parameters

4. Test mentally:
   - Walk through with sample data
   - Verify IF conditions trigger correctly
   - Confirm exceptions are caught
   - Check output parameter values

5. Time management:
   - 5 min: Read question carefully
   - 10 min: Plan structure & parameters
   - 20 min: Write code
   - 10 min: Review & fix syntax
   - 5 min: Mental test execution

================================================================================
ALTERNATIVE QUESTION VARIATIONS:
================================

Variation 1: More IF conditions
  Add: IF department = 'Finance' THEN add 3%
       IF department = 'Sales' THEN add 4%

Variation 2: Database update
  Add: UPDATE Employees SET Salary = ... after bonus calculation

Variation 3: More exceptions
  Add: SALARY_TOO_HIGH exception
       SALARY_TOO_LOW exception
       INVALID_BONUS_RANGE exception

Variation 4: Cursor-based
  Change: Iterate through multiple employees using CURSOR

Variation 5: Trigger instead of procedure
  Change: Create trigger instead of procedure
          AUTO-CALCULATE bonus on INSERT/UPDATE

================================================================================
QUICK REFERENCE TABLE:
======================

SCENARIO                    ACTION
?????????????????????????????????????????????????????
Null parameter              IF ... THEN RAISE_APPLICATION_ERROR
Employee not found          EXCEPTION WHEN NO_DATA_FOUND
Salary >= 60000            IF ... THEN bonus + 2
Salary 40000-60000         ELSIF ... THEN bonus (no change)
Salary < 40000             ELSE bonus - 1
IT department              IF ... THEN bonus + 5
Return modified bonus      p_bonus_percent := v_bonus
Return calculated amount   p_final_amount := v_salary * (v_bonus/100)
Return status message      p_message := 'SUCCESS...' OR 'ERROR...'
Any other error            WHEN OTHERS THEN handle

================================================================================
FILES PROVIDED:
================

1. MS_QUESTION_ANSWER_FINAL.txt ? YOU ARE HERE
2. MS_VISUAL_CHEAT_SHEET.txt - Quick visual reference
3. MS_PARAMETER_COMPARISON.txt - Detailed parameter explanation
4. MS_SHORT_QUESTION_BONUS.txt - Full question statement
5. MS_QUICK_REFERENCE.txt - One-page quick ref
6. MS_SUMMARY.txt - Summary overview

================================================================================
CONCLUSION:
===========

This MS question tests:
? Parameter types (IN, OUT, IN OUT)
? IF statements (validation and business logic)
? Exception handling (NO_DATA_FOUND, OTHERS)
? Procedure writing
? Data transformation
? Business logic implementation

Master this, and you can handle:
? Similar procedures
? Function creation
? Trigger implementation
? Complex PL/SQL logic


================================================================================

*/