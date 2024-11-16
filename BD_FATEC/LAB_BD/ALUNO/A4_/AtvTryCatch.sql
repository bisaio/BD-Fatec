-- RESOLUÇÃO EX.3

BEGIN TRY
	CREATE TABLE padrao1
	(
		id INT PRIMARY KEY IDENTITY,
		nome VARCHAR(MAX)
	);
END TRY
BEGIN CATCH
	DROP TABLE padrao1

	CREATE TABLE padrao1
	(
		id INT PRIMARY KEY IDENTITY,
		nome VARCHAR(MAX)
	);
END CATCH

SELECT * FROM padrao1

------------------------------
DECLARE @i INT = 0, @n INT = 1000;

WHILE @i < @n
BEGIN
	DECLARE @dia INT = ROUND(RAND()*30 + 1, 0),
			@mes INT = ROUND(RAND()*11 + 1, 0),
			@ano INT = ROUND(RAND()*34 + 1990, 0);

	DECLARE @data_str VARCHAR(MAX) = CONCAT(@ano,'-',@mes,'-',@dia)
	DECLARE @data DATE;

	BEGIN TRY
		SET @data = CONVERT(DATE, @data_str);
	END TRY
	BEGIN CATCH
		IF @mes = 2 --Deu erro e o mes é fevereiro
			BEGIN
				SET @dia = 28;
			END;
		ELSE
			BEGIN
				SET @dia = 30;
			END;
	END CATCH;

	--BEGIN TRY
		SET @data_str = CONCAT(@ano,'-',@mes,'-',@dia)

		SET @data = CONVERT(DATE, @data_str);
		PRINT(CONCAT('Data = ', @data))
	--END TRY
	--BEGIN CATCH
		--PRINT(CONCAT(CHAR(13), 'Dia = ', @dia, 'Mes = ', @mes, 'Ano = ', @ano))
	--END CATCH;

	SET @i = @i + 1;
END;