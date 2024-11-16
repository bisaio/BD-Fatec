IF NOT EXISTS(SELECT * FROM sys.databases
				WHERE name = 'db06112024')
	CREATE DATABASE db06112024;
GO
USE db06112024;


IF NOT EXISTS(SELECT * FROM sys.tables
				WHERE name = 'tb')
	CREATE TABLE tb(
		id INT PRIMARY KEY IDENTITY(1,2),
		nome VARCHAR(MAX),
		valor FLOAT
	);

SELECT * FROM tb;
CREATE OR ALTER PROCEDURE add_linhas
@n INT
AS
BEGIN
	DECLARE @i INT = 1;
	WHILE @i <= @n
	BEGIN
		INSERT INTO tb 
		VALUES (CONVERT(VARCHAR(MAX), NEWID()),
				RAND()*10);

		SET @i = @i + 1;
	END
END;


BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_completo.bak';


BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial.bak'
WITH DIFFERENTIAL;


EXEC add_linhas 100000;

SELECT COUNT(*) FROM tb;


BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial_4.bak'
WITH DIFFERENTIAL;


DELETE FROM tb;

BACKUP DATABASE db06112024
TO DISK = 'C:/Backup/db06112024_diferencial_5.bak'
WITH DIFFERENTIAL;



DECLARE c CURSOR
FOR
SELECT name FROM sys.databases;

OPEN c;

DECLARE @i INT = 1;
WHILE @i <= (SELECT COUNT(*) FROM sys.databases)
BEGIN
	DECLARE @name VARCHAR(MAX);
	FETCH NEXT FROM c INTO @name;
	PRINT(CONCAT('nome do banco = ',@name));
	EXEC('DROP DATABASE ' + @name);
	SET @i = @i + 1;
END;

CLOSE c;
DEALLOCATE c;