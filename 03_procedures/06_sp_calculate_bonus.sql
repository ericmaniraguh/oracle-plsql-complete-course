/*
Problem Statement:

The company needs a procedure that calculates an employee’s bonus using 
their salary, department, and an initial bonus percentage provided by the user.
The system must validate the inputs, retrieve employee information from
the database, adjust the bonus percentage based on salary levels and 
department rules, and then compute the final bonus amount. The procedure
should return the updated bonus percentage, the calculated bonus amount, 
and a message indicating whether the operation was successful or if any 
errors occurred, including cases where the employee does not exist.

*/


create or replace PROCEDURE sp_calculate_bonus (
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

-- Test or Run the Procedure with an Anonymous Block

DECLARE
    v_bonus_percent  NUMBER := 10;  -- initial bonus percentage (IN OUT)
    v_final_amount   NUMBER;        -- OUT
    v_message        VARCHAR2(200); -- OUT
BEGIN
    sp_calculate_bonus(
        p_employee_id   => 101,       -- IN
        p_bonus_percent => v_bonus_percent, 
        p_final_amount  => v_final_amount,
        p_message       => v_message
    );

    DBMS_OUTPUT.PUT_LINE('Returned Bonus %: ' || v_bonus_percent);
    DBMS_OUTPUT.PUT_LINE('Final Bonus Amount: ' || v_final_amount);
    DBMS_OUTPUT.PUT_LINE('Message: ' || v_message);
END;
/


