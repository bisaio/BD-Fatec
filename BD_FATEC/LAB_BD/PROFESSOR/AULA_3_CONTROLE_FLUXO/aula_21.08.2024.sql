-- Exercício 1
-- Solução do item (a)

CREATE TABLE tb_locais(
	id		INT PRIMARY KEY,
	nome	VARCHAR(8000),
	lat		FLOAT,
	long	FLOAT
);

INSERT INTO tb_locais 
VALUES
-- Cadastro da Fatec
(1, 'Fatec SJRP (Antigo Cadeião de RP)', -20.793373, -49.399806),
-- Cadastro de Alcatraz
(2, 'Prisão de Alcatraz', 37.828268, -122.424422);

SELECT * FROM tb_locais;

-- (b)
-- Coleta de valores nas tabelas para variáveis
-- Primeira forma
DECLARE @lat1 FLOAT = (SELECT lat FROM tb_locais WHERE id = 1);
PRINT(CONCAT('Lat 1 = ', @lat1));

-- Segunda forma
DECLARE @lat1  FLOAT,
		@long1 FLOAT,
		@lat2  FLOAT,
		@long2 FLOAT;
SELECT @lat1 = RADIANS(lat), @long1 = RADIANS(long) 
FROM tb_locais WHERE id = 1;
SELECT @lat2 = RADIANS(lat), @long2 = RADIANS(long) 
FROM tb_locais WHERE id = 2;
PRINT(CONCAT('(Lat1,Long1) = (',@lat1,',',@long1,')'));
PRINT(CONCAT('(Lat2,Long2) = (',@lat2,',',@long2,')'));

DECLARE @delta_1 FLOAT = (@lat2 - @lat1) / 2.0,
		@delta_2 FLOAT = (@long2 - @long1) / 2.0,
		@r		 FLOAT = 6371, -- km
		@dist	 FLOAT,
		@D		 FLOAT;

SET @D = POWER(SIN(@delta_1), 2.0) + 
         COS(@lat1) * COS(@lat2) * POWER(SIN(@delta_2), 2.0);
SET @dist = 2 * @r * ASIN(SQRT(@D));
PRINT(CONCAT('d(Fatec RP, Prisão de Alcatraz) = ', @dist));



-- Exercício 2

DECLARE @ind INT = (SELECT MAX(id) FROM tb_locais) + 1;

DECLARE @nome VARCHAR(50) = NEWID();
SET @nome = LEFT(@nome, 20);
SET @nome = REPLACE(@nome, '-','a');
SET @nome = REPLACE(@nome, '0','b');
SET @nome = REPLACE(@nome, '1','c');
SET @nome = REPLACE(@nome, '2','d');
SET @nome = REPLACE(@nome, '3','e');
SET @nome = REPLACE(@nome, '4','f');
SET @nome = REPLACE(@nome, '5','g');
SET @nome = REPLACE(@nome, '6','h');
SET @nome = REPLACE(@nome, '7','i');
SET @nome = REPLACE(@nome, '8','j');
SET @nome = REPLACE(@nome, '9','k');
PRINT(@nome);

DECLARE @lat  FLOAT = 360 * RAND() - 180;
DECLARE @long FLOAT = 360 * RAND() - 180;

INSERT INTO tb_locais 
VALUES
(@ind, @nome, @lat, @long);

SELECT * FROM tb_locais;



/* Lancamento de cara ou coroa */

DECLARE @moeda FLOAT,
		@i	   INT = 0;

WHILE @i < 10
BEGIN
	SET @moeda = RAND();
	IF @moeda > 0.5
	BEGIN
		PRINT('Cara!');
	END
	ELSE
	BEGIN
		PRINT('Coroa!');
	END;
	SET @i = @i + 1;
END;







PRINT(POWER(2.0,1.0/2.0))

PRINT(SQRT(3))

PRINT(EXP(1))

PRINT(LOG(2.718281828) / LOG(2))


