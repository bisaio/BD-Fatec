/* Exercicio 4:
*/

ALTER TABLE tb_serie_temporal 
ADD jul DECIMAL(10,2);

SELECT * FROM tb_serie_temporal;

CREATE OR ALTER PROCEDURE add_mes
AS
BEGIN
	UPDATE tb_serie_temporal
	SET jul = (jan + fev + mar + abr + mai + jun) / 6.0; -- calculando valor aproximado (media) para o proximo mes (menor chance de erro assim)

	SELECT * FROM tb_serie_temporal
END;

EXEC add_mes;

/* Exercicio 5:
*/
CREATE OR ALTER PROCEDURE add_row
--lista de parametros
@n INT
AS
BEGIN
	DECLARE @i INT = 1;

	WHILE @i <= @n
		BEGIN
			DECLARE @jan DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
					@fev DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
					@mar DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
					@abr DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
					@mai DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
					@jun DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
					@jul DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10);

			INSERT INTO 
				tb_serie_temporal
			VALUES
				(@jan, @fev, @mar, @abr, @mai, @jun, @jul);

			SET @i = @i + 1;
		END;
END;

-- BD GUARDA AS FUNCOES/PROCEDURES/TRIGGERS NAS PASTAS DO BD/BDATUAL/PROGRAMAÇÃO/pastas de funcoes, procedimentos, gatilhos 

SELECT COUNT(*) AS 'Quantidade de linhas' FROM tb_serie_temporal

EXEC add_row 10;
SELECT COUNT(*) AS 'Quantidade de linhas' FROM tb_serie_temporal

EXEC add_row 100;
SELECT COUNT(*) AS 'Quantidade de linhas' FROM tb_serie_temporal

EXEC add_row 1000;
SELECT COUNT(*) AS 'Quantidade de linhas' FROM tb_serie_temporal

/* Exercicio 6:
*/
CREATE OR ALTER PROCEDURE add_noise
@alpha FLOAT -- Precisa estar entre 0 e 1
AS
BEGIN
	IF (@alpha< 0) OR (@alpha > 1) -- Fora do intervalo [0,1]
		BEGIN
			PRINT('Valor de @alpha fora do intervalo necessário!')
		END;
	ELSE
		BEGIN
			UPDATE tb_serie_temporal
			SET jul = jul + RAND() * @alpha;
		END;
END;

SELECT jul FROM tb_serie_temporal;

EXEC add_noise 0.7;

SELECT jul FROM tb_serie_temporal;


/* Exercicio 7:
*/
CREATE OR ALTER PROCEDURE drop_rows
@jan DECIMAL(10,2),
@fev DECIMAL(10,2),
@mar DECIMAL(10,2),
@abr DECIMAL(10,2),
@mai DECIMAL(10,2),
@jun DECIMAL(10,2),
@jul DECIMAL(10,2),
@qtd INT OUTPUT -- Variavel de retorno que armazena a quantidade de linhas removidas

AS
BEGIN
	DECLARE @qtde_inicial INT = (SELECT COUNT(*) FROM tb_serie_temporal);

	DELETE FROM tb_serie_temporal
	WHERE (
		   (jan > @jan) OR
		   (fev > @fev) OR
		   (mar > @mar) OR
		   (abr > @abr) OR
		   (mai > @mai) OR
		   (jun > @jun) OR
		   (jul > @jul)
		  );

	DECLARE @qtde_final INT = (SELECT COUNT(*) FROM tb_serie_temporal);

	SET @qtd = ABS(@qtde_final - @qtde_inicial);
END;

DECLARE @qtde_linhas_removidas INT;
EXEC drop_rows 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, @qtde_linhas_removidas OUTPUT;
PRINT(CONCAT('Quantidade de linhas removidas: ', @qtde_linhas_removidas));

SELECT MAX(jan) FROM tb_serie_temporal
SELECT MAX(fev) FROM tb_serie_temporal
SELECT MAX(mar) FROM tb_serie_temporal
SELECT MAX(abr) FROM tb_serie_temporal
SELECT MAX(mai) FROM tb_serie_temporal
SELECT MAX(jun) FROM tb_serie_temporal
SELECT MAX(jul) FROM tb_serie_temporal

/* Exercicio 8:
*/

CREATE OR ALTER PROCEDURE calc_estatisticas
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM sys.tables WHERE name='#tb_temp')
		BEGIN
			CREATE TABLE #tb_temp(
				mes VARCHAR(3) PRIMARY KEY,
				mAVG FLOAT,
				mVAR FLOAT,
				mSTD FLOAT,
				mMAX FLOAT,
				mMIN FLOAT
			)
		END;
	ELSE
		BEGIN
			TRUNCATE TABLE #tb_temp -- Apaga todas as linhas da tabela
		END;

	DECLARE @avg FLOAT, @var FLOAT, @std FLOAT, @max FLOAT, @min FLOAT

	SELECT 
		@avg = AVG(jan), 
		@var = VAR(jan),
		@std = STDEV(jan),
		@max = MAX(jan),
		@min = MIN(jan)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('jan', @avg, @var, @std, @max, @min)

	SELECT 
		@avg = AVG(fev), 
		@var = VAR(fev),
		@std = STDEV(fev),
		@max = MAX(fev),
		@min = MIN(fev)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('fev', @avg, @var, @std, @max, @min)

	SELECT 
		@avg = AVG(mar), 
		@var = VAR(mar),
		@std = STDEV(mar),
		@max = MAX(mar),
		@min = MIN(mar)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('mar', @avg, @var, @std, @max, @min)

	SELECT 
		@avg = AVG(abr), 
		@var = VAR(abr),
		@std = STDEV(abr),
		@max = MAX(abr),
		@min = MIN(abr)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('abr', @avg, @var, @std, @max, @min)

	SELECT 
		@avg = AVG(mai), 
		@var = VAR(mai),
		@std = STDEV(mai),
		@max = MAX(mai),
		@min = MIN(mai)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('mai', @avg, @var, @std, @max, @min)

	SELECT 
		@avg = AVG(jun), 
		@var = VAR(jun),
		@std = STDEV(jun),
		@max = MAX(jun),
		@min = MIN(jun)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('jun', @avg, @var, @std, @max, @min)

	SELECT 
		@avg = AVG(jul), 
		@var = VAR(jul),
		@std = STDEV(jul),
		@max = MAX(jul),
		@min = MIN(jul)
	FROM
		tb_serie_temporal

	INSERT INTO
		#tb_temp
	VALUES
		('jul', @avg, @var, @std, @max, @min)

	SELECT * FROM #tb_temp;
END;

EXEC calc_estatisticas;