/*
Ejercicio 2: Tipos de datos

Declara variables para almacenar:
- Día con más entradas vendidas (basado en conciertos)  (
                                                            ESTA PARTE HACERLA CON CURSOR PORQUE HAY 5 ENTRADAS VENDIDAS
                                                            EN 5 DÍAS DISTINTOS.
                                                        )
- Franja horaria con más conciertos programados         (
                                                            SE DEBE HACER CON UN CURSOR YA QUE DEVUELVE MÁS DE UN VALOR
                                                        )
- Porcentaje de ocupación promedio de los escenarios    (PREGUNTAR)
- Artista con más conciertos programados (registro con nombre y género)    (PREGUNTAR PORQUE TODOS HACEN SOLO 1 CONCIERTO)
- Precio máximo y mínimo de entradas vendidas
*/

SET SERVEROUTPUT ON;
DECLARE
    CURSOR FRANJAS_HORARIAS IS  SELECT TO_CHAR(HORA_INICIO, 'HH24'), TO_CHAR(HORA_INICIO, 'DD-MM-YYYY'), COUNT(*)
                                FROM CONCIERTO
                                GROUP BY TO_CHAR(HORA_INICIO, 'HH24'), TO_CHAR(HORA_INICIO, 'DD-MM-YYYY')
                                HAVING COUNT(*) = (
                                    SELECT MAX(COUNT(*))
                                    FROM CONCIERTO
                                    GROUP BY TO_CHAR(HORA_INICIO, 'HH24'), TO_CHAR(HORA_INICIO, 'DD-MM-YYYY')
                                ) ORDER BY COUNT(*) DESC;
    NOM_CONCIERTO VARCHAR(20) := 'PURO LATINO';
    FECHA_MAS_COMPRA DATE;
    NUM_ENTRADAS NUMBER;
    FRANJA_HORARIA NUMERIC(2);
    FECHA_MUCHOS_CONCIERTOS DATE;
    CANTIDAD_TOTAL_CONCIERTOS NUMERIC(2);
    PRECIO_MAX NUMERIC(5);
    PRECIO_MIN NUMERIC(5);
BEGIN
    DBMS_OUTPUT.PUT_LINE (NOM_CONCIERTO || ':');
    
    SELECT TO_CHAR(FECHA_COMPRA, 'DD-MM-YYYY') INTO FECHA_MAS_COMPRA FROM ENTRADA GROUP BY FECHA_COMPRA ORDER BY COUNT(*) DESC FETCH FIRST 1 ROWS ONLY;
    SELECT COUNT(*) INTO NUM_ENTRADAS FROM ENTRADA GROUP BY FECHA_COMPRA ORDER BY COUNT(*) DESC FETCH FIRST 1 ROWS ONLY;
    
    DBMS_OUTPUT.PUT_LINE ('Días con más entradas vendidas:');
    DBMS_OUTPUT.PUT_LINE('  El ' || FECHA_MAS_COMPRA || ' se vende/n ' || NUM_ENTRADAS || ' entrada/s.');
    
    DBMS_OUTPUT.PUT_LINE (' ');
    
    DBMS_OUTPUT.PUT_LINE ('Franja horaria con más conciertos realizados:');
    OPEN FRANJAS_HORARIAS;
    LOOP
        FETCH FRANJAS_HORARIAS INTO FRANJA_HORARIA, FECHA_MUCHOS_CONCIERTOS, CANTIDAD_TOTAL_CONCIERTOS;
        EXIT WHEN FRANJAS_HORARIAS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('  De ' || FRANJA_HORARIA || 'h a ' || (FRANJA_HORARIA+1) || 'h el ' || FECHA_MUCHOS_CONCIERTOS || ' hay ' || CANTIDAD_TOTAL_CONCIERTOS || ' conciertos.');
    END LOOP;
    CLOSE FRANJAS_HORARIAS;
    
    DBMS_OUTPUT.PUT_LINE (' ');
    
    SELECT MIN(PRECIO), MAX(PRECIO) INTO PRECIO_MIN, PRECIO_MAX FROM ENTRADA;
    DBMS_OUTPUT.PUT_LINE ('El precio máximo de una entrada es ' || PRECIO_MAX || '€');
    DBMS_OUTPUT.PUT_LINE ('El precio mínimo de una entrada es ' || PRECIO_MIN || '€');
END;
/