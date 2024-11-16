DECLARE @tamanho INT = (SELECT COUNT(*) FROM tb_funcionario)

IF @tamanho >= 1000
	BEGIN
		RAISERROR('A tabela j� est� muito grande', 16, 1);
	END
ELSE
	BEGIN 
		PRINT('Qualquer a��o!');
	END;

--------------------------------------------------------

DECLARE @x FLOAT = 10, @y FLOAT = 2;

BEGIN TRY
	DECLARE @r FLOAT = FLOOR(RAND()*10);

	IF @r = 0 -- n�o roda por estar no try-catch, j� que o erro esta neste try e n�o do catch
		BEGIN
			RAISERROR('N�o se faz divis�o por 0 nesta casa', 18, 50)
		END;

	PRINT(CONCAT(@x, '/', @y, '=', (@x/@y)));
	PRINT(CONCAT(@x, '/', @r, '=', (@x/@r)));
END TRY
BEGIN CATCH
	PRINT(CONCAT('x = ', @x));
	PRINT(CONCAT('y = ', @y));
	PRINT(CONCAT('r = ', @r));
END CATCH;