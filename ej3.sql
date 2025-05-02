DECLARE
	id_concierto NUMBER := &input;
	precio_base NUMBER;
	principal NUMBER;
	id_dia NUMBER;
	nombre_dia VARCHAR(10);
	aumento_principal NUMBER := 0;
	precio_total NUMBER;
BEGIN
	SELECT c.dia_id, d.nombre, e.es_principal
	INTO id_dia, nombre_dia, principal
	FROM concierto c JOIN dia_festival d ON c.dia_id = d.id 
	JOIN escenario e ON c.escenario_id = e.id
	WHERE id_concierto = c.id;
	
	nombre_dia := UPPER(TRIM(nombre_dia));
	
	IF nombre_dia LIKE 'SABADO%' OR nombre_dia LIKE 'DOMINGO%' THEN
		precio_base := 50;
	ELSE
		precio_base := 35;
	END IF;
	
	IF principal = 1 THEN
		aumento_principal := precio_base * 0.20;
	END IF;
	
	precio_total := precio_base + aumento_principal;
	
	DBMS_OUTPUT.PUT_LINE ('ID concierto: ' || id_concierto);
	DBMS_OUTPUT.PUT_LINE ('DESGLOSE');
	DBMS_OUTPUT.PUT_LINE ('Precio base: ' || precio_base);
	DBMS_OUTPUT.PUT_LINE ('Aumento por ser escenario principal: ' || aumento_principal);
	DBMS_OUTPUT.PUT_LINE ('Precio total: ' || precio_total);
	
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrio el error ' || SQLCODE || ' mensaje: ' || SQLERRM);
END;
/
