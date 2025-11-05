create or replace PROCEDURE calc_bonus_emp (v_employee_id IN NUMBER)
AS
    v_salary    NUMBER;
    v_bonus_cat VARCHAR2(20);   -- ? FIXED (should be VARCHAR2)
BEGIN
    -- Fetch employee salary
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = v_employee_id;

    -- Assign bonus category based on salary using CASE
    v_bonus_cat := CASE 
                      WHEN v_salary >= 60000 THEN 'High Bonus'
                      WHEN v_salary >= 40000 THEN 'Medium Bonus'
                      ELSE 'Low Bonus'
                   END;

    -- Display the result
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('Bonus Category: ' || v_bonus_cat);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
