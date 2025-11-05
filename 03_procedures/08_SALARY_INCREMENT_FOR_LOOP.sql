create or replace PROCEDURE sp_salary_increment_for_loop AS
    -- Variable declarations using %TYPE (no datatype needed!)
    v_emp_id Employees.Employee_ID%TYPE;
    v_first_name Employees.First_Name%TYPE;
    v_last_name Employees.Last_Name%TYPE;
    v_current_salary Employees.Salary%TYPE;
    v_new_salary Employees.Salary%TYPE;
    v_increment Employees.Salary%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('SALARY INCREMENT - FOR LOOP');
    DBMS_OUTPUT.PUT_LINE('========================================');

    -- FOR LOOP: Iterate from 1 to 10
    FOR v_counter IN 1..10 LOOP
        BEGIN
            -- Fetch employee details
            SELECT 
                Employee_ID,
                First_Name,
                Last_Name,
                Salary
            INTO 
                v_emp_id,
                v_first_name,
                v_last_name,
                v_current_salary
            FROM Employees
            WHERE Employee_ID = v_counter;

            -- Calculate new salary and increment
            v_new_salary := v_current_salary * 1.05;
            v_increment := v_new_salary - v_current_salary;

            -- Display results
            DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ': ' || 
                                v_first_name || ' ' || v_last_name || 
                                ' | Current: ' || v_current_salary || 
                                ' | New: ' || ROUND(v_new_salary, 2) || 
                                ' | Increment: ' || ROUND(v_increment, 2));

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Employee ' || v_counter || ': NOT FOUND');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error for Employee ' || v_counter || 
                                    ': ' || SQLERRM);
        END;

    END LOOP; -- End of FOR LOOP

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Process Completed');
    DBMS_OUTPUT.PUT_LINE('========================================');

END sp_salary_increment_for_loop;
