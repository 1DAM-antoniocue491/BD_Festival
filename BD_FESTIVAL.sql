--Ejercicio 5 (Procedimientos):
/*
    Completa con:
    1. Control de capacidad (no superar 90% del escenario)
    2. Cálculo de precio según tipo de entrada (GENERAL/VIP/PREMIUM)
    3. Inserción en tabla ENTRADA con estado 'VALIDA'
    4. Confirmación con ID de entrada generada
*/
CREATE OR REPLACE PROCEDURE vender_entrada(
    p_asistente_id NUMBER,
    p_concierto_id NUMBER,
    p_tipo_entrada VARCHAR2
) IS
    NUM_ENTRADAS NUMERIC(5);
    CAPACIDAD_ESCENARIO NUMERIC (5);
BEGIN
    SELECT COUNT(*) INTO CAPACIDAD_ACTUAL FROM ENTRADA WHERE CONCIERTO_ID = P_CONCIERTO_ID;
    SELECT DISTINCT CAPACIDAD INTO CAPACIDAD_ESCENARIO FROM ESCENARIO E JOIN CONCIERTO C ON E.ID = C.ESCENARIO_ID WHERE C.ESCENARIO_ID = P_CONCIERTO_ID;
    
END;