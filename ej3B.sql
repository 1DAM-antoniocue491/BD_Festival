/*
Ejercicio 3 (Condicionales):

Crea un bloque que:
1. Reciba un ID de concierto (usar &input)
2. Calcule el precio base seg�n:
   - 50� si el d�a es fin de semana (s�bado o domingo)
   - 35� si es d�a laborable
   - +20% si el escenario es principal (campo es_principal = 1)
3. Muestre el precio calculado con el desglose
4. Maneje adecuadamente posibles errores
*/
SET SERVEROUTPUT ON;
DECLARE
    ID_CONCIERTO INTEGER := '&INPUT';
    DIA_SEMANA VARCHAR(10);
    PRECIO NUMERIC(3);
    ID_ESCENARIO INTEGER;
    ID_MAX INTEGER;
BEGIN
    SELECT MAX(ID) INTO ID_MAX FROM CONCIERTO;
    IF ID_CONCIERTO <= ID_MAX AND ID_CONCIERTO >= 1 THEN
        SELECT UPPER(TO_CHAR(HORA_INICIO, 'day')) INTO DIA_SEMANA FROM CONCIERTO WHERE ID = ID_CONCIERTO;
        SELECT ESCENARIO_ID INTO ID_ESCENARIO FROM CONCIERTO WHERE ID = ID_CONCIERTO;
        IF DIA_SEMANA = 'S�BADO' OR DIA_SEMANA = 'DOMINGO' THEN
            PRECIO := 50;
            DBMS_OUTPUT.PUT_LINE ('Como es fin de semana, el precio es ' || PRECIO || ' euros.');
        ELSE
            PRECIO := 35;
            DBMS_OUTPUT.PUT_LINE ('Como es un d�a entre semana, el precio es ' || PRECIO || ' euros.');
        END IF;
        IF ID_ESCENARIO = 1 THEN
            PRECIO := PRECIO * 1.2;
            DBMS_OUTPUT.PUT_LINE ('Como el ID del escenario es 1, se le a�ade un 20% al precio');
        END IF;
        DBMS_OUTPUT.PUT_LINE ('El total ser�a ' || PRECIO || ' euros.');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('El ID indicado no es correcto');
    END IF;
END;