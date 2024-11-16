IF NOT EXISTS (SELECT * FROM sys.databases WHERE name='bd11092024')
BEGIN
	CREATE DATABASE bd11092024;
END;
GO

USE bd11092024;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='tb_serie_temporal')
BEGIN
	CREATE TABLE tb_serie_temporal
	(
		id  INT PRIMARY KEY  IDENTITY(1,1),
		jan DECIMAL(10,2),
		fev DECIMAL(10,2),
		mar DECIMAL(10,2),
		abr DECIMAL(10,2),
		mai DECIMAL(10,2),
		jun DECIMAL(10,2)
	);
END;

/* Exercicio 1:
*/

DECLARE @i INT = 1,
		@n INT = 100;

WHILE @i <= @n
BEGIN
	DECLARE @jan DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
			@fev DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
			@mar DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
			@abr DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
			@mai DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10),
			@jun DECIMAL(10,2) = CONVERT(DECIMAL(10,2), RAND() * 10);

	INSERT INTO 
		tb_serie_temporal
	VALUES
		(@jan, @fev, @mar, @abr, @mai, @jun);

	SET @i = @i + 1;
END;

SELECT * FROM tb_serie_temporal

/* Exercicio 2:
Parametros de entrada --> id de uma linha
SAIDA = Media dos valores desta linha (avg(jan, fev, mar, abr, mai, jun))
*/
CREATE OR ALTER FUNCTION dbo.func_media(@id INT)
RETURNS DECIMAL(10,2)
AS 
BEGIN
	DECLARE @jan DECIMAL(10,2),
			@fev DECIMAL(10,2),
			@mar DECIMAL(10,2),
			@abr DECIMAL(10,2),
			@mai DECIMAL(10,2),
			@jun DECIMAL(10,2);

	SELECT 
		@jan = jan, 
		@fev = fev, 
		@mar = mar, 
		@abr = abr, 
		@mai = mai, 
		@jun = jun
	FROM
		tb_serie_temporal
	WHERE
		id = @id;

	DECLARE @media DECIMAL(10,2) = CONVERT(DECIMAL(10,2), (@jan + @fev + @mar + @abr + @mai + @jun)/6.0);

	RETURN @media;
END;
-------
DECLARE @resultado   DECIMAL(10,2),
		@id_de_teste INT = 100;

SET @resultado = dbo.func_media(@id_de_teste);
PRINT(CONCAT('Media: ', @resultado));

SELECT * FROM tb_serie_temporal WHERE id = 100;
--PRINT(nums da linha do id/6.0) para testar

/*Exercicio 3:
*/
CREATE OR ALTER FUNCTION dbo.func_estatistica(@id INT)
RETURNS @tb_retorno TABLE(
							media		  DECIMAL(10,2),
							variancia	  DECIMAL(10,2),
							desvio_padrao DECIMAL(10,2)
						 )
AS
BEGIN
	DECLARE @jan DECIMAL(10,2),
			@fev DECIMAL(10,2),
			@mar DECIMAL(10,2),
			@abr DECIMAL(10,2),
			@mai DECIMAL(10,2),
			@jun DECIMAL(10,2);

	SELECT 
		@jan = jan, 
		@fev = fev, 
		@mar = mar, 
		@abr = abr, 
		@mai = mai, 
		@jun = jun
	FROM
		tb_serie_temporal
	WHERE
		id = @id;

	DECLARE @media DECIMAL(10,2) = CONVERT(DECIMAL(10,2), (@jan + @fev + @mar + @abr + @mai + @jun)/6.0);

	DECLARE @variancia DECIMAL(10,2) = CONVERT(DECIMAL(10,2), 
												(POWER(@jan-@media, 2.0)+
												 POWER(@fev-@media, 2.0)+
												 POWER(@mar-@media, 2.0)+
												 POWER(@abr-@media, 2.0)+
												 POWER(@mai-@media, 2.0)+
												 POWER(@jun-@media, 2.0)
												)/6.0);

	DECLARE @desvio_padrao DECIMAL(10,2) = CONVERT(DECIMAL(10,2), SQRT(@variancia));

	INSERT INTO 
		@tb_retorno
	VALUES
		(@media, @variancia, @desvio_padrao);

	RETURN;
END;

DECLARE @id_de_teste INT = 100;
SELECT * FROM dbo.func_estatistica(@id_de_teste);

SELECT * FROM tb_serie_temporal WHERE id = 100;