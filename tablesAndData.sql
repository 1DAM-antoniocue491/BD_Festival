DROP TABLE entrada;
DROP TABLE concierto;
DROP TABLE dia_festival;
DROP TABLE escenario;
DROP TABLE artista;
DROP TABLE asistente;

-- Tabla ASISTENTE
CREATE TABLE asistente (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Tabla ARTISTA
CREATE TABLE artista (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    genero VARCHAR2(50) NOT NULL,
    pais VARCHAR2(50),
    biografia CLOB
);


-- Tabla ESCENARIO
CREATE TABLE escenario (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    capacidad NUMBER NOT NULL,
 es_principal NUMBER(1) DEFAULT 0 --   ====> añadido
);


-- Tabla DIA_FESTIVAL =======================> el campo es_principal aparecía aquí en vez de en la tabla ESCENARIO
CREATE TABLE dia_festival (
    id NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    nombre VARCHAR2(20) NOT NULL
    --es_principal NUMBER(1) DEFAULT 0 CHECK (es_principal IN (0, 1))
);


-- Tabla CONCIERTO
CREATE TABLE concierto (
    id NUMBER PRIMARY KEY,
    artista_id NUMBER NOT NULL,
    escenario_id NUMBER NOT NULL,
    dia_id NUMBER NOT NULL,
    hora_inicio TIMESTAMP NOT NULL,
    duracion NUMBER NOT NULL, -- en minutos
    estado VARCHAR2(20) DEFAULT 'ACTIVO' CHECK (estado IN ('ACTIVO', 'CANCELADO', 'COMPLETADO')),
    FOREIGN KEY (artista_id) REFERENCES artista(id),
    FOREIGN KEY (escenario_id) REFERENCES escenario(id),
    FOREIGN KEY (dia_id) REFERENCES dia_festival(id)
);


-- Tabla ENTRADA
CREATE TABLE entrada (
    id NUMBER PRIMARY KEY,
    asistente_id NUMBER NOT NULL,
    concierto_id NUMBER NOT NULL,
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    precio NUMBER(10,2) NOT NULL,
    tipo VARCHAR2(20) NOT NULL CHECK (tipo IN ('GENERAL', 'VIP', 'PREMIUM')),
    codigo_qr VARCHAR2(100) UNIQUE,
    estado VARCHAR2(20) DEFAULT 'VALIDA' CHECK (estado IN ('VALIDA', 'USADA', 'CANCELADA')),
    FOREIGN KEY (asistente_id) REFERENCES asistente(id),
    FOREIGN KEY (concierto_id) REFERENCES concierto(id)
);

------------------------------- DATOS DE EJEMPLO PARA LAS TABLAS ---------------------------------------------------

/*


--ASISTENTE

INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(1, 'Juan Pérez', 'juan.perez@email.com', TO_DATE('2025-05-10', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(2, 'María García', 'maria.garcia@email.com', TO_DATE('2025-05-15', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(3, 'Carlos López', 'carlos.lopez@email.com', TO_DATE('2025-05-20', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(4, 'Ana Rodríguez', 'ana.rodriguez@email.com', TO_DATE('2025-05-25', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(5, 'David Martínez', 'david.martinez@email.com', TO_DATE('2025-06-01', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(6, 'Laura Sánchez', 'laura.sanchez@email.com', TO_DATE('2025-06-03', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(7, 'Pedro Ramírez', 'pedro.ramirez@email.com', TO_DATE('2025-06-04', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(8, 'Sofía Torres', 'sofia.torres@email.com', TO_DATE('2025-06-05', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(9, 'Miguel Fernández', 'miguel.fernandez@email.com', TO_DATE('2025-06-06', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(10, 'Lucía Gómez', 'lucia.gomez@email.com', TO_DATE('2025-06-07', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(11, 'Diego Morales', 'diego.morales@email.com', TO_DATE('2025-06-08', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(12, 'Valentina Herrera', 'valentina.herrera@email.com', TO_DATE('2025-06-09', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(13, 'Andrés Ruiz', 'andres.ruiz@email.com', TO_DATE('2025-06-10', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(14, 'Isabela Castro', 'isabela.castro@email.com', TO_DATE('2025-06-11', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(15, 'Javier Ríos', 'javier.rios@email.com', TO_DATE('2025-06-12', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(16, 'Camila León', 'camila.leon@email.com', TO_DATE('2025-06-13', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(17, 'Tomás Ortega', 'tomas.ortega@email.com', TO_DATE('2025-06-14', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(18, 'Martina Peña', 'martina.pena@email.com', TO_DATE('2025-06-15', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(19, 'Gabriel Silva', 'gabriel.silva@email.com', TO_DATE('2025-06-16', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(20, 'Renata Vargas', 'renata.vargas@email.com', TO_DATE('2025-06-17', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(21, 'Sebastián Aguilar', 'sebastian.aguilar@email.com', TO_DATE('2025-06-18', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(22, 'Natalia Mendoza', 'natalia.mendoza@email.com', TO_DATE('2025-06-19', 'YYYY-MM-DD'));
INSERT INTO asistente (id, nombre, email, fecha_registro) VALUES 
(23, 'Álvaro Reyes', 'alvaro.reyes@email.com', TO_DATE('2025-06-20', 'YYYY-MM-DD'));


--ARTISTA

INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(1, 'Powerwolf', 'Metal', 'Alemania', 'Banda de power metal conocida por sus temas sobre licantropía y religión');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(2, 'Alestorm', 'Metal', 'Reino Unido', 'Banda de pirate metal que combina metal con temas náuticos');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(3, 'Bad Bunny', 'Reggaeton', 'Puerto Rico', 'Uno de los artistas más influyentes del reggaeton actual');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(4, 'Eminem', 'Rap', 'EEUU', 'Uno de los raperos más importantes de la historia');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(5, 'LiSA', 'Anime', 'Japón', 'Cantante conocida por temas de apertura de populares animes');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(6, 'Taylor Swift', 'Pop', 'EEUU', 'Superestrella del pop con múltiples premios Grammy');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(7, 'Sabaton', 'Metal', 'Suecia', 'Banda de power metal conocida por sus letras históricas');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(8, 'Duki', 'Rap', 'Argentina', 'Uno de los máximos exponentes del trap latino');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(9, 'Electric Callboy', 'Metal', 'Alemania', 'Banda que combina techno y metal');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(10, 'J Balvin', 'Reggaeton', 'Colombia', 'El príncipe del reggaeton, conocido por su estilo urbano');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(11, 'Kendrick Lamar', 'Rap', 'EEUU', 'Rapero ganador del Pulitzer por su álbum DAMN.');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(12, 'Aimer', 'Anime', 'Japón', 'Cantante con voz distintiva para bandas sonoras de anime');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(13, 'Dua Lipa', 'Pop', 'Reino Unido', 'Estrella del pop internacional con sonido futurista');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(14, 'Brothers of metal', 'Metal', 'Suecia', 'Banda de metal con canciones inspiradas en la mitología nórdica');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(15, 'Karol G', 'Reggaeton', 'Colombia', 'Reina del reggaeton femenino con ritmos urbanos');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(16, 'Travis Scott', 'Rap', 'EEUU', 'Artista de hip-hop experimental y shows pirotécnicos');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(17, 'Hiroyuki Sawano', 'Anime', 'Japón', 'Compositor de bandas sonoras para Attack on Titan y otros animes');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(18, 'Billie Eilish', 'Pop', 'EEUU', 'Cantante alternativa con sonidos oscuros y letras profundas');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(19, 'Arch Enemy', 'Metal', 'Suecia', 'Banda de melodic death metal con vocalista femenina');
INSERT INTO artista (id, nombre, genero, pais, biografia) VALUES 
(20, 'Rosalía', 'Pop', 'España', 'Fusiona flamenco con pop y reggaeton en su estilo único');

--ESCENARIO
--se ha reducido la capacidad para facilitar la realización de los ejercicios

INSERT INTO escenario (id, nombre, capacidad, es_principal) VALUES (1, 'Main Stage', 15,1);
INSERT INTO escenario (id, nombre, capacidad,es_principal) VALUES (2, 'Metal Temple', 8,0);
INSERT INTO escenario (id, nombre, capacidad,es_principal) VALUES (3, 'Urban Beats', 7,0);
INSERT INTO escenario (id, nombre, capacidad,es_principal) VALUES (4, 'Pop Paradise', 9,0);
INSERT INTO escenario (id, nombre, capacidad,es_principal) VALUES (5, 'Anime Central', 5,0);

--DIA_FESTIVAL

INSERT INTO dia_festival (id, fecha, nombre) VALUES 
(1, TO_DATE('2026-07-28', 'YYYY-MM-DD'), 'Viernes 1');
INSERT INTO dia_festival (id, fecha, nombre) VALUES 
(2, TO_DATE('2026-07-29', 'YYYY-MM-DD'), 'Sábado 2');
INSERT INTO dia_festival (id, fecha, nombre) VALUES 
(3, TO_DATE('2026-07-30', 'YYYY-MM-DD'), 'Domingo 3');
INSERT INTO dia_festival (id, fecha, nombre) VALUES 
(4, TO_DATE('2026-07-31', 'YYYY-MM-DD'), 'Lunes 4');

--CONCIERTO

INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(1, 1, 2, 1, TO_TIMESTAMP('2026-07-28 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(2, 2, 2, 2, TO_TIMESTAMP('2026-07-31 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 75, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(3, 3, 3, 1, TO_TIMESTAMP('2026-07-28 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 120, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(4, 4, 3, 3, TO_TIMESTAMP('2026-07-30 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(5, 5, 5, 2, TO_TIMESTAMP('2026-07-29 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 60, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(6, 6, 4, 3, TO_TIMESTAMP('2026-07-30 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(7, 7, 2, 3, TO_TIMESTAMP('2026-07-30 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 80, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(8, 8, 3, 2, TO_TIMESTAMP('2026-07-29 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 70, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(9, 9, 1, 1, TO_TIMESTAMP('2026-07-28 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 85, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(10, 10, 2, 1, TO_TIMESTAMP('2026-07-31 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 95, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(11, 11, 3, 2, TO_TIMESTAMP('2026-07-29 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(12, 12, 4, 2, TO_TIMESTAMP('2026-07-29 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 110, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(13, 13, 5, 3, TO_TIMESTAMP('2026-07-31 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 75, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(14, 14, 1, 3, TO_TIMESTAMP('2026-07-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(15, 15, 2, 3, TO_TIMESTAMP('2026-07-30 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(16, 16, 3, 1, TO_TIMESTAMP('2026-07-31 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(17, 17, 4, 2, TO_TIMESTAMP('2026-07-29 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 90, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(18, 18, 5, 3, TO_TIMESTAMP('2026-07-30 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 120, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(19, 19, 1, 1, TO_TIMESTAMP('2026-07-31 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 105, 'ACTIVO');
INSERT INTO concierto (id, artista_id, escenario_id, dia_id, hora_inicio, duracion, estado) VALUES 
(20, 20, 2, 2, TO_TIMESTAMP('2026-07-31 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), 95, 'ACTIVO');

--ENTRADA

INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES 
(1, 1, 1, TO_TIMESTAMP('2025-06-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-1-1-20230615103000123456789', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES 
(2, 2, 2, TO_TIMESTAMP('2025-06-16 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-2-2-20230616114500567891234', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES 
(3, 3, 3, TO_TIMESTAMP('2025-06-17 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-3-3-20230617091500345678912', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES 
(4, 4, 1, TO_TIMESTAMP('2025-06-18 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-4-4-20230618142000789123456', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES 
(5, 5, 2, TO_TIMESTAMP('2025-06-19 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-5-5-20230619163000123456789', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(6, 6, 3, TO_TIMESTAMP('2025-06-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-6-1-20250603100000123456006', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(7, 7, 4, TO_TIMESTAMP('2025-06-04 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-7-2-20250604100000123456007', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(8, 8, 5, TO_TIMESTAMP('2025-06-05 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-8-3-20250605100000123456008', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(9, 9, 6, TO_TIMESTAMP('2025-06-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-9-4-20250606100000123456009', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(10, 10, 7, TO_TIMESTAMP('2025-06-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-10-1-20250607100000123456010', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(11, 11, 8, TO_TIMESTAMP('2025-06-08 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-11-2-20250608100000123456011', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(12, 12, 9, TO_TIMESTAMP('2025-06-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-12-3-20250609100000123456012', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(13, 13, 10, TO_TIMESTAMP('2025-06-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-13-4-20250610100000123456013', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(14, 14, 11, TO_TIMESTAMP('2025-06-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-14-1-20250611100000123456014', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(15, 15, 12, TO_TIMESTAMP('2025-06-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-15-2-20250612100000123456015', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(16, 16, 13, TO_TIMESTAMP('2025-06-13 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-16-3-20250613100000123456016', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(17, 17, 14, TO_TIMESTAMP('2025-06-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-17-4-20250614100000123456017', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(18, 18, 15, TO_TIMESTAMP('2025-06-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-18-1-20250615100000123456018', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(19, 19, 16, TO_TIMESTAMP('2025-06-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-19-2-20250616100000123456019', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(20, 20, 17, TO_TIMESTAMP('2025-06-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-20-3-20250617100000123456020', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(21, 21, 18, TO_TIMESTAMP('2025-06-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'VIP', 'ENT-21-4-20250618100000123456021', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(22, 22, 19, TO_TIMESTAMP('2025-06-19 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50, 'GENERAL', 'ENT-22-1-20250619100000123456022', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(23, 23, 20, TO_TIMESTAMP('2025-06-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-23-2-20250620100000123456023', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(24, 23, 20, TO_TIMESTAMP('2025-06-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-23-2-20250620100000123456024', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(25, 23, 20, TO_TIMESTAMP('2025-06-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-23-2-20250620100000123456025', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(26, 23, 20, TO_TIMESTAMP('2025-06-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-23-2-20250620100000123456026', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(27, 23, 20, TO_TIMESTAMP('2025-06-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-23-2-20250620100000123456027', 'VALIDA');
INSERT INTO entrada (id, asistente_id, concierto_id, fecha_compra, precio, tipo, codigo_qr, estado) VALUES
(28, 23, 20, TO_TIMESTAMP('2025-06-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150, 'PREMIUM', 'ENT-23-2-20250620100000123456028', 'VALIDA');

