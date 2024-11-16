CREATE DATABASE legal;
USE legal;

--RESOLUÇÃO EX 1

CREATE TABLE tb_funcionario
(
	id		  INT PRIMARY KEY IDENTITY(1,1),
	nome	  VARCHAR(MAX),
	salario   FLOAT,
	data_cont DATE
)

DECLARE @nome VARCHAR(10) = LEFT(NEWID(), 10);
PRINT(@nome)

DECLARE @salario FLOAT = (RAND() * 500 + 1500);
PRINT(@salario);

DECLARE @dia INT = ROUND(RAND() * 30 + 1, 0),
		--@mes INT = CEIL(12 * RAND())
		@mes INT = ROUND(RAND() * 11 + 1, 0),
		@ano INT = ROUND(RAND() * 34 + 1990, 0);

IF ((@mes = 4 OR @mes = 6 OR @mes = 9 OR @mes = 11) AND (@dia = 31))
	BEGIN
		SET @dia= 30;
	END;

IF @mes = 2
	BEGIN
		IF @dia = 29 OR @dia = 30 OR @dia = 31
			BEGIN
				SET @dia = 28;
			END;
	END;

DECLARE @data_final DATE = CONVERT(DATE, CONCAT(@ano, '-', @mes, '-', @dia))

INSERT INTO 
	tb_funcionario
VALUES
	(@nome, @salario, @data_final)

SELECT * FROM tb_funcionario

--RESOLUÇÃO EX.2

DECLARE @i INT = 1,
		@n INT = 100;
		
WHILE @i <= @n
	BEGIN
		DECLARE @nome VARCHAR(10) = LEFT(NEWID(), 10);
		PRINT(@nome)

		DECLARE @salario FLOAT = (RAND() * 500 + 1500);
		PRINT(@salario);

		DECLARE @dia INT = ROUND(RAND() * 30 + 1, 0),
				--@mes INT = CEIL(12 * RAND())
				@mes INT = ROUND(RAND() * 11 + 1, 0),
				@ano INT = ROUND(RAND() * 34 + 1990, 0);

		IF ((@mes = 4 OR @mes = 6 OR @mes = 9 OR @mes = 11) AND (@dia = 31))
			BEGIN
				SET @dia= 30;
			END;

		IF @mes = 2
			BEGIN
				IF @dia = 29 OR @dia = 30 OR @dia = 31
					BEGIN
						SET @dia = 28;
					END;
			END;

		DECLARE @data_final DATE = CONVERT(DATE, CONCAT(@ano,'-',@mes,'-',@dia))

		INSERT INTO 
			tb_funcionario
		VALUES
			(@nome, @salario, @data_final)

		SET @i = @i + 1;
	END;

SELECT * FROM tb_funcionario

DELETE FROM tb_funcionario