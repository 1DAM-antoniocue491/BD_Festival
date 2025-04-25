/*
Ejercicio 1:  Generar un informe resumen del festival.

Crea un bloque anónimo que muestre:
- Nombre del festival (variable constante)
- Fechas de celebración (primero y último día de la tabla dia_festival)
- Número total de artistas con conciertos programados
- Número de escenarios utilizados
- Precio medio de todas las entradas vendidas
- Recaudación total estimada
*/

SET SERVEROUTPUT ON;
DECLARE
    NOM_CONCIERTO VARCHAR(20) := 'PURO LATINO';
    FECHA_INICIO DATE;
    FECHA_FIN DATE;
    NUM_ARTISTAS NUMERIC(2);
    NUM_ESCENARIOS NUMERIC(2);
    MEDIA_ENTRADA NUMERIC(5,1);
    TOTAL_REC NUMERIC(6);
BEGIN
    BEGIN
        SELECT MIN(FECHA), MAX(FECHA) INTO FECHA_INICIO, FECHA_FIN FROM DIA_FESTIVAL;
        SELECT COUNT(DISTINCT ARTISTA_ID), COUNT(DISTINCT ESCENARIO_ID) INTO NUM_ARTISTAS, NUM_ESCENARIOS FROM CONCIERTO;
        SELECT AVG(PRECIO), SUM(PRECIO) INTO MEDIA_ENTRADA, TOTAL_REC FROM ENTRADA;
    END;
    DBMS_OUTPUT.PUT_LINE (NOM_CONCIERTO || ':');
    DBMS_OUTPUT.PUT_LINE ('Fecha de inicio: ' || FECHA_INICIO);
    DBMS_OUTPUT.PUT_LINE ('Fecha fin: ' || FECHA_FIN);
    DBMS_OUTPUT.PUT_LINE ('Número de artistas: ' || NUM_ARTISTAS);
    DBMS_OUTPUT.PUT_LINE ('Cantidad de escenarios: ' || NUM_ESCENARIOS);
    DBMS_OUTPUT.PUT_LINE ('Precio medio de la entrada: ' || MEDIA_ENTRADA || ' euros');
    DBMS_OUTPUT.PUT_LINE ('Total recaudado: ' || TOTAL_REC || ' euros');
END;
/