--Caso práctico: Consultas útiles.
--Ejercicio 6: Funciones

/*
CREATE OR REPLACE FUNCTION calcular_ocupacion(
    p_concierto_id NUMBER
) RETURN NUMBER IS
    Devuelve porcentaje de ocupación para un concierto específico:
    1. Obtiene capacidad del escenario relacionado
    2. Cuenta entradas vendidas para ese concierto
    3. Calcula: (entradas_vendidas / capacidad) * 100
    4. Maneja casos donde no hay datos
*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION calcular_ocupacion(
    p_concierto_id NUMBER
) RETURN NUMBER 
IS
    v_capacidad         NUMBER;
    v_entradas_vendidas NUMBER;
    v_ocupacion         NUMBER;
BEGIN
    SELECT e.capacidad
    INTO v_capacidad
    FROM concierto c
    JOIN escenario e ON c.escenario_id = e.id
    WHERE c.id = p_concierto_id;

    SELECT COUNT(*)
    INTO v_entradas_vendidas
    FROM entrada
    WHERE concierto_id = p_concierto_id;

    IF v_capacidad > 0 THEN
        v_ocupacion := (v_entradas_vendidas / v_capacidad) * 100;
    ELSE
        v_ocupacion := 0;
    END IF;

    RETURN v_ocupacion;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Si no hay datos, ocupación es 0
    WHEN OTHERS THEN
        RETURN NULL; -- En otros errores, devolver NULL
END;
/

SELECT CALCULAR_OCUPACION(4) FROM dual;
