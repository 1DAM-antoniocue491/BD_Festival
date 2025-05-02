-- Crear tabla de errores y secuencia para id
DROP TABLE erorres CASCADE CONSTRAINTS;
DROP SEQUENCE seq_errores;

CREATE TABLE errores (
    id_error     NUMBER PRIMARY KEY,
    proceso      VARCHAR2(100),
    mensaje      VARCHAR2(4000),
    fecha_hora   DATE DEFAULT SYSDATE,
    detalles     VARCHAR2(4000)
);

CREATE SEQUENCE seq_errores START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE vender_entrada(
    p_asistente_id NUMBER,
    p_concierto_id NUMBER,
    p_tipo_entrada VARCHAR2
) IS
    NUM_ENTRADAS NUMBER(5);
    CAPACIDAD_ESCENARIO NUMBER(5);
    PORCENTAJE_OCUPACION NUMBER(3);
    PRECIOTOTAL NUMBER(3);
    ID_ENTRADA INTEGER;
    ID_CONFIRMACION INTEGER;
    v_estado_concierto VARCHAR2(20);
    v_escenario_id NUMBER;
    v_count NUMBER;
BEGIN
    -- Validar que el concierto existe y esta ACTIVO
    BEGIN
        SELECT estado, escenario_id INTO v_estado_concierto, v_escenario_id
        FROM concierto
        WHERE id = p_concierto_id;

        -- Si el concierto no esta activo, registrar el error y lanzar excepcion con RAISE
        IF v_estado_concierto != 'ACTIVO' THEN
            INSERT INTO errores (id_error, proceso, mensaje, detalles)
            VALUES (
                seq_errores.NEXTVAL, 'VENTA_ENTRADA',
                'Concierto no está activo',
                'ConciertoID: ' || p_concierto_id || ', AsistenteID: ' || p_asistente_id
            );
            RAISE_APPLICATION_ERROR(-20001, 'Error: El concierto no está activo.');
        END IF;
    END;

    -- Verificar si el asistente existe con un COUNT
    SELECT COUNT(*) INTO v_count
    FROM asistente
    WHERE id = p_asistente_id;

    IF v_count = 0 THEN
        INSERT INTO errores (id_error, proceso, mensaje, detalles)
        VALUES (
            seq_errores.NEXTVAL, 'VENTA_ENTRADA',
            'Asistente no encontrado',
            'ConciertoID: ' || p_concierto_id || ', AsistenteID: ' || p_asistente_id
        );
        RAISE_APPLICATION_ERROR(-20003, 'Error: Asistente no encontrado.');
    END IF;

    -- Calcular ocupaciOn usando la función calcular_ocupacion del ej6
    PORCENTAJE_OCUPACION := calcular_ocupacion(p_concierto_id);

    -- Si la ocupacion es >=90 aparece error  
    IF PORCENTAJE_OCUPACION >= 90 THEN
        INSERT INTO errores (id_error, proceso, mensaje, detalles)
        VALUES (
            seq_errores.NEXTVAL, 'VENTA_ENTRADA',
            'Capacidad excedida',
            'ConciertoID: ' || p_concierto_id || ', AsistenteID: ' || p_asistente_id
        );
        RAISE_APPLICATION_ERROR(-20004, 'Error: Capacidad excedida para este concierto.');
    END IF;

	-- Parte del ej5 mas una excepcion que maneja si el tipo de entrada es correcto
    IF p_tipo_entrada = 'VIP' THEN
        PRECIOTOTAL := 100;
    ELSIF p_tipo_entrada = 'PREMIUM' THEN
        PRECIOTOTAL := 150;
    ELSIF p_tipo_entrada = 'GENERAL' THEN
        PRECIOTOTAL := 50;
    ELSE
        INSERT INTO errores (id_error, proceso, mensaje, detalles)
        VALUES (
            seq_errores.NEXTVAL, 'VENTA_ENTRADA',
            'Tipo de entrada inválido',
            'ConciertoID: ' || p_concierto_id || ', AsistenteID: ' || p_asistente_id || ', TipoEntrada: ' || p_tipo_entrada
        );
        RAISE_APPLICATION_ERROR(-20005, 'Error: El tipo de entrada indicada es incorrecto.');
    END IF;

    SELECT (MAX(ID) + 1) INTO ID_ENTRADA FROM ENTRADA;

    INSERT INTO ENTRADA VALUES (
        ID_ENTRADA, p_asistente_id, p_concierto_id, SYSDATE, PRECIOTOTAL, p_tipo_entrada, 'CODIGO QR GENERADO', 'VALIDA'
    );

    SELECT ID INTO ID_CONFIRMACION FROM ENTRADA WHERE ID = ID_ENTRADA;
    
    IF ID_CONFIRMACION = ID_ENTRADA THEN
        DBMS_OUTPUT.PUT_LINE('LA ENTRADA HA SIDO CREADA CON EXITO');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('LA ENTRADA NO HA SIDO CREADA CON EXITO');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Registra erorres que no se contemplen
        INSERT INTO errores (id_error, proceso, mensaje, fecha_hora, detalles)
        VALUES (
            seq_errores.NEXTVAL,
            'VENTA_ENTRADA',
            SQLERRM,
            SYSDATE,
            'ConciertoID: ' || p_concierto_id || ', AsistenteID: ' || p_asistente_id || ', TipoEntrada: ' || p_tipo_entrada
        );
        
END;
/
