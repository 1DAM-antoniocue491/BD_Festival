SET SERVEROUTPUT ON;

DECLARE
	id_asistente      NUMBER := &input;
	tiene_vip         VARCHAR2(10);
	conteo_entradas   NUMBER;
	precio_entrada    NUMBER;
	descuento         NUMBER := 0;
	precio_total      NUMBER;
BEGIN
	SELECT CASE 
		WHEN COUNT(*) > 0 THEN 'S�?' 
		ELSE 'NO' 
	END
	INTO tiene_vip
	FROM entrada
	WHERE asistente_id = id_asistente AND tipo = 'VIP';

	SELECT COUNT(*)
	INTO conteo_entradas
	FROM entrada
	WHERE asistente_id = id_asistente;

	-- NVL hace que si SUM(precio) es nulo devuelva 0, para que no de errores raros
	SELECT NVL(SUM(precio), 0)
	INTO precio_entrada
	FROM entrada
	WHERE asistente_id = id_asistente;

	IF conteo_entradas >= 3 THEN
		descuento := precio_entrada * 0.05;
	END IF;

	precio_total := precio_entrada - descuento;

	DBMS_OUTPUT.PUT_LINE('Asistente ID: ' || id_asistente);
	DBMS_OUTPUT.PUT_LINE('Tiene entrada VIP: ' || tiene_vip);
	DBMS_OUTPUT.PUT_LINE('Entradas totales: ' || conteo_entradas);
	DBMS_OUTPUT.PUT_LINE('Total sin descuento: ' || precio_entrada || '€');
	DBMS_OUTPUT.PUT_LINE('Descuento aplicado: ' || descuento || '€');
	DBMS_OUTPUT.PUT_LINE('Total final a pagar: ' || precio_total || '€');

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrio el error ' || SQLCODE || ' mensaje: ' || SQLERRM);
END;
/
