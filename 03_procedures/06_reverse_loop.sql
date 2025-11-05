create or replace PROCEDURE reversed_for_loop 
AS 
BEGIN
    FOR i IN REVERSE 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE('Countdown: ' || i);
        DBMS_OUTPUT.PUT_LINE('Keep Trying');
    END LOOP;
END;
/

SET SERVEROUTPUT ON;
EXEC reversed_for_loop;