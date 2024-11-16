CREATE DATABASE db_laboratorio4ADS;

USE db_laboratorio4ADS;

CREATE TABLE tb_locais (
	id INT NOT NULL IDENTITY,
	nome VARCHAR(45) NOT NULL,
	latitude FLOAT,
	longitude FLOAT,
	CONSTRAINT pk_locais PRIMARY KEY(id)
);

INSERT INTO
	tb_locais (nome, latitude, longitude)
VALUES
	('Fatec RP', -20.793373, -49.399806),
	('Alcatraz', 37.828268, -122.424422) -- Inserir 10 registros aleatórios
	DECLARE @inserts FLOAT = 10;

WHILE @inserts > 0 BEGIN
INSERT INTO
	tb_locais (nome, latitude, longitude)
VALUES
	(
		REPLACE(LEFT(NEWID(), 20), '-', 'a'),
		350 * RAND() - 180,
		350 * RAND() - 180
	)
SET
	@inserts = @inserts - 1;

END;

-----------------------------------------------
-- Distancia entre os locais
-----------------------------------------------
CREATE TABLE distancia (
	id_local_1 INT NOT NULL,
	id_local_2 INT NOT NULL,
	distancia FLOAT NOT NULL
) DECLARE @registros INT = (
	SELECT
		COUNT(*)
	FROM
		tb_locais
) + 1,
@contador INT = 1;

WHILE @contador < @registros BEGIN DECLARE @comparador INT = @contador + 1;

WHILE @comparador < @registros BEGIN DECLARE @lat1 FLOAT,
@long1 FLOAT,
@lat2 FLOAT,
@long2 FLOAT;

SELECT
	@lat1 = RADIANS(latitude),
	@long1 = RADIANS(longitude)
FROM
	tb_locais
WHERE
	id = @contador;

SELECT
	@lat2 = RADIANS(latitude),
	@long2 = RADIANS(longitude)
FROM
	tb_locais
WHERE
	id = @comparador;

DECLARE @delta_1 FLOAT = (@lat2 - @lat1) / 2,
@delta_2 FLOAT = (@long2 - @long1) / 2,
@r FLOAT = 6371,
-- km
@dist FLOAT,
@D FLOAT;

SET
	@D = POWER(SIN(@delta_1), 2) + COS(@lat1) * cos(@lat2) * POWER(SIN(@delta_2), 2);

SET
	@dist = 2 * @r * ASIN(SQRT(@D));

INSERT INTO
	distancia (
		id_local_1,
		id_local_2,
		distancia
	)
VALUES
	(
		@contador,
		@comparador,
		@dist
	)
SET
	@comparador = @comparador + 1;

END;

SET
	@contador = @contador + 1;

END;

SELECT
	TOP 2 *
FROM
	distancia
ORDER BY
	distancia DESC;