create or replace PROCEDURE sp_salary_update_while_loop AS
    -- Variables with %TYPE (automatic datatype from table columns)
    v_counter NUMBER := 1;
    v_emp_id Employees.Employee_ID%TYPE;
    v_first_name Employees.First_Name%TYPE;
    v_last_name Employees.Last_Name%TYPE;
    v_old_salary Employees.Salary%TYPE;
    v_new_salary Employees.Salary%TYPE;
    v_increment Employees.Salary%TYPE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('SALARY UPDATE - WHILE LOOP');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    -- WHILE LOOP: Continue while counter <= 5
    WHILE v_counter <= 5 LOOP
        BEGIN
            -- Fetch employee data
            SELECT 
                Employee_ID,
                First_Name,
                Last_Name,
                Salary
            INTO 
                v_emp_id,
                v_first_name,
                v_last_name,
                v_old_salary
            FROM Employees
            WHERE Employee_ID = v_counter;

            -- Calculate new salary (10% increase)
            v_new_salary := v_old_salary * 1.10;
            v_increment := v_new_salary - v_old_salary;

            -- Display before update
            DBMS_OUTPUT.PUT_LINE('Processing Employee ' || v_counter || ': ' ||
                                v_first_name || ' ' || v_last_name);
            DBMS_OUTPUT.PUT_LINE('Previous Salary: ' || v_old_salary || 
                                ', New Salary: ' || ROUND(v_new_salary, 2) || 
                                ', Increase: ' || ROUND(v_increment, 2));

            -- Update salary in Employees table
            UPDATE Employees
            SET Salary = v_new_salary,
                Updated_At = CURRENT_TIMESTAMP
            WHERE Employee_ID = v_counter;

            DBMS_OUTPUT.PUT_LINE('Updated Successfully!');
            DBMS_OUTPUT.PUT_LINE('---');

            -- COMMIT after each update
            COMMIT;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Employee ' || v_counter || 
                                    ': NOT FOUND - Skipping');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error updating Employee ' || v_counter || 
                                    ': ' || SQLERRM);
                ROLLBACK;
        END;

        -- IMPORTANT: Increment counter to avoid infinite loop!
        v_counter := v_counter + 1;

    END LOOP; -- End of WHILE LOOP

    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('All Updates Completed');
    DBMS_OUTPUT.PUT_LINE('==========================================');

END sp_salary_update_while_loop;
