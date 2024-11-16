IF NOT EXISTS (
	SELECT 1 FROM sys.databases WHERE name = 'db13112024'
)
CREATE DATABASE db13112024;
GO
USE db13112024;

IF NOT EXISTS (
	SELECT 1 FROM sys.tables WHERE name = 'tb_user'
)
CREATE TABLE tb_user(
	id INT PRIMARY KEY IDENTITY,
	nome VARCHAR(MAX),
	saldo FLOAT
);

CREATE OR ALTER PROCEDURE add_itens
@n INT
AS
BEGIN
	BEGIN TRANSACTION
		DECLARE @i INT = 1;
		WHILE @i <= @n
		BEGIN
			INSERT INTO tb_user
				(nome, saldo)
			VALUES 
				((CONVERT(VARCHAR(MAX), NEWID())), (2450 * RAND() + 50));
	
			SET @i = @i + 1;
		END;
	COMMIT TRANSACTION
END;

CREATE OR ALTER PROCEDURE update_valor
    @valor FLOAT, 
    @id1 INT, 
    @id2 INT
AS
BEGIN
    IF @valor <= 0
    BEGIN
        PRINT ('O valor de transferência deve ser maior que zero.');
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @saldoAtual FLOAT;
        SELECT @saldoAtual = saldo FROM tb_user WHERE id = @id1;

        IF @saldoAtual IS NULL
        BEGIN
            PRINT ('Usuário 1 não encontrado.');
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @saldoAtual < @valor
        BEGIN
            PRINT ('Saldo insuficiente para realizar a transferência.');
            ROLLBACK TRANSACTION;
            RETURN;
        END

		IF NOT EXISTS (SELECT 1 FROM tb_user WHERE id = @id2)
        BEGIN
            PRINT ('Usuário 2 não encontrado.');
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE tb_user
        SET saldo = saldo - @valor
        WHERE id = @id1;

        UPDATE tb_user
        SET saldo = saldo + @valor
        WHERE id = @id2;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
    END CATCH;
END;


SELECT * FROM tb_user WHERE id IN(1,2)
EXEC update_valor 30, 1, 2;


CREATE OR ALTER PROCEDURE make_backup
AS 
BEGIN
	DECLARE cursor_backup CURSOR
	FOR SELECT name FROM sys.databases WHERE name NOT IN('master', 'tempdb', 'model', 'msdb')
	OPEN cursor_backup
	DECLARE
		@name VARCHAR(MAX);
	FETCH NEXT FROM cursor_backup INTO @name;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE 
			@file_name VARCHAR(MAX) = 
				CONCAT(
					@name, 
					'_', 
					CONVERT(VARCHAR(MAX), DATEPART(YEAR, GETDATE())),  
					'_', 
					CONVERT(VARCHAR(MAX), DATEPART(MONTH, GETDATE())), 
					'_', 
					CONVERT(VARCHAR(MAX), DATEPART(DAY, GETDATE())), 
					'_', 
					CONVERT(VARCHAR(MAX), DATEPART(HOUR, GETDATE())), 
					'_', 
					CONVERT(VARCHAR(MAX), DATEPART(MINUTE, GETDATE())), 
					'_', 
					CONVERT(VARCHAR(MAX), DATEPART(SECOND, GETDATE())),
					'.bak'
				);
		DECLARE
			@full_path VARCHAR(MAX) = CONCAT('C:/Backup/' , @file_name); 

		BACKUP DATABASE @name
		TO DISK = @full_path;

		FETCH NEXT FROM cursor_backup INTO @name;
	END;

	CLOSE cursor_backup;
	DEALLOCATE cursor_backup;
END;

EXEC make_backup;

