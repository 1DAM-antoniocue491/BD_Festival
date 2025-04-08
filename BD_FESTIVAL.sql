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
/*
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
/*
DECLARE
    CURSOR MAX_ENTRADAS_VENDIDAS IS SELECT TO_CHAR(FECHA_COMPRA, 'DD-MM-YYYY'), COUNT(*) FROM ENTRADA GROUP BY FECHA_COMPRA;
    CURSOR FRANJAS_HORARIAS IS  SELECT TO_CHAR(HORA_INICIO, 'HH24'), TO_CHAR(HORA_INICIO, 'DD-MM-YYYY'), COUNT(*)
                                FROM CONCIERTO
                                GROUP BY TO_CHAR(HORA_INICIO, 'HH24'), TO_CHAR(HORA_INICIO, 'DD-MM-YYYY')
                                HAVING COUNT(*) = (
                                    SELECT MAX(COUNT(*))
                                    FROM CONCIERTO
                                    GROUP BY TO_CHAR(HORA_INICIO, 'HH24'), TO_CHAR(HORA_INICIO, 'DD-MM-YYYY')
                                ) ORDER BY COUNT(*) DESC;
    NOM_CONCIERTO VARCHAR(20) := 'PURO LATINO';
    FECHA_COMPRA_ENTRADA DATE;
    CANTIDAD_ENTRADAS NUMERIC(2);
    FRANJA_HORARIA NUMERIC(2);
    FECHA_MUCHOS_CONCIERTOS DATE;
    CANTIDAD_TOTAL_CONCIERTOS NUMERIC(2);
    PRECIO_MAX NUMERIC(5);
    PRECIO_MIN NUMERIC(5);
BEGIN
    DBMS_OUTPUT.PUT_LINE (NOM_CONCIERTO || ':');
    
    DBMS_OUTPUT.PUT_LINE ('Días con más entradas vendidas:');
    OPEN MAX_ENTRADAS_VENDIDAS;
    LOOP
        FETCH MAX_ENTRADAS_VENDIDAS INTO FECHA_COMPRA_ENTRADA, CANTIDAD_ENTRADAS;
        EXIT WHEN MAX_ENTRADAS_VENDIDAS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  El ' || FECHA_COMPRA_ENTRADA || ' se vende/n ' || CANTIDAD_ENTRADAS || ' entrada/s.');
    END LOOP;
    CLOSE MAX_ENTRADAS_VENDIDAS;
    
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
*/

/*
Ejercicio 3 (Condicionales):

Crea un bloque que:
1. Reciba un ID de concierto (usar &input)
2. Calcule el precio base según:
   - 50€ si el día es fin de semana (sábado o domingo)
   - 35€ si es día laborable
   - +20% si el escenario es principal (campo es_principal = 1)
3. Muestre el precio calculado con el desglose
4. Maneje adecuadamente posibles errores
*/

DECLARE
    ID_CONCIERTO INTEGER := '&INPUT';
    DIA_SEMANA VARCHAR(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE ('ID: ' || ID_CONCIERTO);
    SELECT TO_CHAR(HORA_INICIO, 'day') INTO DIA_SEMANA FROM CONCIERTO WHERE ID = ID_CONCIERTO;
    DBMS_OUTPUT.PUT_LINE (DIA_SEMANA);
END;