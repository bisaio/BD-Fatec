-- 1 ----------------------------------------------------------------------
-- a)
CREATE TABLE tb_locais
(
	id	 INT PRIMARY KEY,
	nome VARCHAR(8000),
	lat  FLOAT, -- LATITUDE
	lon  FLOAT  -- LONGITUDE
)

INSERT INTO 
	tb_locais
VALUES
	(1, 'Fatec RP (Antigo Cadeião)', -20.793373 , -49.399806),
	(2, 'Prisão de Alcatraz', 37.828268, -122.424422)

SELECT * FROM tb_locais

-- b)
-- coleta de valores nas tabelas para variaveis

-- primeira forma
DECLARE @lat1 FLOAT = (SELECT lat FROM tb_locais WHERE id = 1);
PRINT(CONCAT('Lat 1 = ', @lat1));
DECLARE @lat2 FLOAT = (SELECT lat FROM tb_locais WHERE id = 2);
PRINT(CONCAT('Lat 2 = ', @lat2));

-- segunda forma (desse jeito permite pegar mais valores)
DECLARE @lat1 FLOAT,
		@lon1 FLOAT,
		@lat2 FLOAT,
		@lon2 FLOAT;

SELECT @lat1 = RADIANS(lat), @lon1 = RADIANS(lon)FROM tb_locais WHERE id = 1;
SELECT @lat2 = RADIANS(lat), @lon2 = RADIANS(lon) FROM tb_locais WHERE id = 2;
PRINT(CONCAT('(Lat1, Lon1) = (',@lat1,', ',@lon1,')'));
PRINT(CONCAT('(Lat2, Lon2) = (',@lat2,', ',@lon2,')'));

DECLARE @delta_1 FLOAT = (@lat2 - @lat1) / 2.0,
	    @delta_2 FLOAT = (@lon2 - @lon1) / 2.0,
		@r		 FLOAT = 6371, -- OU 6378 Km (raio da Terra)
		@dist	 FLOAT,
		@D		 FLOAT;

SET @D = POWER(SIN(@delta_1), 2.0) +
		 COS(@lat1) * COS(@lat2) * 
		 POWER(SIN(@delta_2), 2.0);
		 
SET @dist = 2 * @r * ASIN(SQRT(@D));

PRINT(CONCAT('d(Fatec RP, Prisão de Alcatraz) = ', @dist));

-- jeito que eu tinha feito antes da correção
PRINT(2 * 6371 * ASIN(SQRT( POWER(SIN((@lat2 - @lat1)/2.0),2) + COS(@lat1) * COS(@lat2) * POWER(SIN((@lon2 - @lon1)/2.0),2) )))

-- 2 ----------------------------------------------------------------------
DECLARE @indice INT = (SELECT MAX(id) FROM tb_locais) + 1; -- maior que o indice maior atual
--PRINT(@indice)

DECLARE @nome VARCHAR(50) = NEWID();
SET @nome = LEFT(@nome, 20);
	SET @nome = REPLACE(@nome, '-' , 'a');
	SET @nome = REPLACE(@nome, '0' , 'b');
	SET @nome = REPLACE(@nome, '1' , 'c');
	SET @nome = REPLACE(@nome, '2' , 'd');
	SET @nome = REPLACE(@nome, '3' , 'e');
	SET @nome = REPLACE(@nome, '4' , 'f');
	SET @nome = REPLACE(@nome, '5' , 'g');
	SET @nome = REPLACE(@nome, '6' , 'h');
	SET @nome = REPLACE(@nome, '7' , 'i');
	SET @nome = REPLACE(@nome, '8' , 'j');
	SET @nome = REPLACE(@nome, '9' , 'k');
--PRINT(@nome) -- nome alfabetico aleatorio

DECLARE @lat FLOAT = 360 * RAND() - 180;
--PRINT(@lat) -- latitude aleatoria

DECLARE @lon FLOAT = 360 * RAND() - 180;
--PRINT(@lon) -- longitude aleatoria

INSERT INTO	
	tb_locais
VALUES
	(@indice, @nome, @lat, @lon)

SELECT * FROM tb_locais

-- 3 ----------------------------------------------------------------------
