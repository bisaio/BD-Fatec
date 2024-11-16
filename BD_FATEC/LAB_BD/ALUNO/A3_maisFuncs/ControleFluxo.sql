-- Lancamento de cara ou coroa
DECLARE @moeda FLOAT,
		@i	   INT = 0;

WHILE @i < 10
	BEGIN
		SET @moeda = RAND();
		PRINT(CONCAT('Resultado da moeda: ', @moeda))

		IF @moeda > 0.5
			BEGIN
				PRINT(CONCAT('Jogada nº:', @i, ' = CARA'))
			END
		ELSE
			BEGIN
				PRINT(CONCAT('Jogada nº:', @i, ' = COROA'))
			END;
	SET @i = @i + 1
	END
