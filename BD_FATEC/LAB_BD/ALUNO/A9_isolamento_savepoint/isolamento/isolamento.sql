IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'db_23102024')
	CREATE DATABASE db_23102024;
	GO

USE db_23102024;

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'tb_itens')
	CREATE TABLE tb_itens
		(
			id INT PRIMARY KEY IDENTITY,
			nome VARCHAR(MAX),
			qtd INT
		)

DBCC USEROPTIONS --isolation level::committed

SET TRANSACTION ISOLATION LEVEL
	READ UNCOMMITTED;

DBCC USEROPTIONS --isolation level::uncommitted

SET TRANSACTION ISOLATION LEVEL
	READ COMMITTED;

-------------------------------------
BEGIN TRANSACTION;

	PRINT(@@TRANCOUNT)

	SELECT * FROM tb_itens
	WHERE id IN (1,2,5);

	UPDATE tb_itens
	SET qtd = 2
	WHERE id = 3;

	INSERT INTO	tb_itens
	VALUES ('Periquito', 1)

ROLLBACK TRANSACTION;