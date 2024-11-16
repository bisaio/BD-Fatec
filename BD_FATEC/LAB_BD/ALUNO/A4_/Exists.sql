SELECT * FROM sys.databases; --retorna todos os bds no sistema

SELECT name FROM sys.databases; 

IF EXISTS (SELECT * FROM sys.databases WHERE name='legal')
--IF EXISTS (SELECT 1 FROM sys.databases WHERE name='legal')
	BEGIN
		PRINT('Existe!');
	END
ELSE
	BEGIN
		PRINT('Não existe!');
	END;

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'legal')
	BEGIN
		CREATE DATABASE legal;
	END

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'legal')
	BEGIN
		DROP DATABASE legal;
	END;
CREATE DATABASE legal;

------------------------

SELECT * FROM sys.tables

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'padrao2')
	BEGIN
		DROP TABLE padrao2;
	END;
CREATE TABLE padrao2
(
	id INT PRIMARY KEY IDENTITY
)

------------------------
SELECT * FROM tb_funcionario

DECLARE @sal FLOAT = 1990;
DECLARE @cmd VARCHAR(MAX) = CONCAT('SELECT * FROM tb_funcionario WHERE salario > ', @sal);

EXEC(@cmd);