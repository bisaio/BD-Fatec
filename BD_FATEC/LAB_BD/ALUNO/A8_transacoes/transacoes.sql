IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name = 'db09102024')
BEGIN
	CREATE DATABASE db09102024;
	GO
END;

USE db09102024;

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE name = 'tb_clientes')
BEGIN
	CREATE TABLE tb_clientes
	(
		id		INT PRIMARY KEY IDENTITY(1,1),
		nome	VARCHAR(MAX),
		saldo	MONEY
	);
END;

CREATE OR ALTER PROCEDURE add_clientes
@n INT
AS
BEGIN
	BEGIN TRANSACTION
	DECLARE @i INT = 1;
	WHILE @i <= @n
	BEGIN
		DECLARE @nome	VARCHAR(MAX) = CONVERT(VARCHAR(MAX), NEWID()),
				@saldo	MONEY = CONVERT(MONEY, 1550 * RAND());
		
		INSERT INTO 
			tb_clientes
		VALUES
			(@nome, @saldo);

		SET @i = @i + 1;
	END;
	COMMIT
END;

SELECT * FROM tb_clientes;

BEGIN TRANSACTION;
	PRINT(CONCAT('numero de trasações abertas: ', @@TRANCOUNT));

	EXEC add_clientes 3;

	SELECT * FROM tb_clientes;
COMMIT TRANSACTION;

PRINT(CONCAT('numero de trasações abertas: ', @@TRANCOUNT));

BEGIN TRANSACTION;
	PRINT(CONCAT('numero de trasações abertas: ', @@TRANCOUNT))

	SELECT * FROM tb_clientes

	EXEC add_clientes 1000;

	SELECT * FROM tb_clientes
ROLLBACK TRANSACTION

PRINT(CONCAT('numero de trasações abertas: ', @@TRANCOUNT))

SELECT * FROM tb_clientes

/* EXERCICIOS
i. Verifique o tempo que leva para serem adicionados 10.000 registros
*/

DECLARE @start DATETIME = GETDATE();
EXEC add_clientes 10000;
DECLARE @end DATETIME = GETDATE();

DECLARE @tempo_em_segundos FLOAT = DATEDIFF(SECOND, @end, @start)

PRINT(CONCAT('Tempo gasto em segundos: ', ABS(@tempo_em_segundos)))

/*
ii. envolva o código interno ao procedimento em uma transação confimada e recalcule o tempo necessário
*/
-- feito na procedure // isso fez com que diminuisse o tempo de execução, já que o proprio programador manipulou a transaction, tirando esse trabalho do SQL

/*
EXERCICIO 2: Crie uma tb_contas com id inteiro e saldo decimal. Escreva um procedimento que transfira um valor de saldo de um cliente para o saldo de outro de maneira segura.
*/

DELETE FROM tb_clientes WHERE id > 1008;

SELECT * FROM tb_clientes;

DECLARE @valor	MONEY = 200.00,
		@id_1	INT = 1,
		@id_2	INT = 3; -- se colocar um id inexistente vai fazer rollback

BEGIN TRANSACTION;

DECLARE @count INT = (SELECT COUNT(*) FROM tb_clientes WHERE id in (@id_1, @id_2));

IF @count != 2
	ROLLBACK TRANSACTION;
ELSE
	BEGIN

	DECLARE @saldo_cliente_1 MONEY = (SELECT saldo FROM tb_clientes WHERE id = @id_1);

	IF @saldo_cliente_1 < @valor
		ROLLBACK TRANSACTION
	ELSE
		BEGIN

		UPDATE tb_clientes
		SET saldo = saldo - @valor
		WHERE id = @id_1;

		UPDATE tb_clientes
		SET saldo = saldo + @valor
		WHERE id = @id_2;
		
		COMMIT TRANSACTION;
	END;
END;

IF @@TRANCOUNT >= 1
	ROLLBACK TRANSACTION; -- se ainda tiver alguma aberta, é pq tem algo errado, matando tudo...

SELECT * FROM tb_clientes;