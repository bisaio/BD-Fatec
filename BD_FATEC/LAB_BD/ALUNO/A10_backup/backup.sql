IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name = 'db06112024')
	CREATE DATABASE db06112024;
GO
USE db06112024

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE name = 'tb')
	CREATE TABLE tb
		(
			id INT PRIMARY KEY IDENTITY(1,2),
			nome VARCHAR(MAX),
			valor FLOAT
		);

SELECT * FROM tb

-------------------------------------------------------------------

CREATE OR ALTER PROCEDURE add_linhas
@n INT 
AS
BEGIN
	DECLARE @i INT = 1
	WHILE @i <= @n
		BEGIN
			INSERT INTO	tb
			VALUES(CONVERT(VARCHAR(MAX), NEWID()),
				   RAND()*10);

			SET @i = @i + 1
		END;
END

-------------------------------------------------------------------

EXEC add_linhas 10;

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_completo.bak'
--TEM QUE CRIAR A PASTA NO DISCO ANTES DE EXECUTAR O CODIGO

SELECT * FROM tb

EXEC add_linhas 100;

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial.bak'
WITH DIFFERENTIAL;

SELECT * FROM tb

EXEC add_linhas 1000

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial_2.bak'
WITH DIFFERENTIAL;

SELECT * FROM tb

EXEC add_linhas 10000

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial_3.bak'
WITH DIFFERENTIAL;

SELECT * FROM tb

EXEC add_linhas 100000

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial_4.bak'
WITH DIFFERENTIAL;

SELECT * FROM tb

DELETE FROM tb;

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial_5.bak'
WITH DIFFERENTIAL;
--neste caso seria igual se tivesse feito o BKP no tempo inicial, sendo assim, tera o mesmo tamanho