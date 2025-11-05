create or replace PROCEDURE for_loop_cursor_all_employees
IS
    v_num NUMBER := 0;   -- counter
BEGIN
    FOR r IN (SELECT employee_id, salary FROM employees) LOOP
        v_num := v_num + 1;   -- increase counter
        DBMS_OUTPUT.PUT_LINE(v_num || '. ' || r.employee_id || ' - ' || r.salary);
    END LOOP;
END;


--Test/call the procedure 
SET SERVEROUTPUT ON;

EXEC for_loop_cursor_all_employees;