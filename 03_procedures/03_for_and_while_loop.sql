/*
Write a PL/SQL program to print the multiplication 
table of 19 using a WHILE loop.
*/

/*
| Feature               | FOR Loop    | WHILE Loop                |
| --------------------- | ----------- | ------------------------- |
| Initialization        | Automatic   | Manual                    |
| Increment             | Automatic   | Manual                    |
| Loop variable         | Read-only   | Can be changed            |
| When to use           | Known range | Condition-based           |
| Risk of infinite loop | Very low    | High (if not incremented) |

*/

CREATE OR REPLACE PROCEDURE while_loop 

IS

    i NUMBER := 1;
BEGIN
    WHILE i <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE('19 x ' || i || ' = ' || (19 * i));
        i := i + 1;   -- increment
    END LOOP;
END;
/

EXEC while_loop;
