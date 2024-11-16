SET TRANSACTION ISOLATION LEVEL
	READ UNCOMMITTED;

DBCC USEROPTIONS

USE db_23102024;

INSERT INTO tb_itens
VALUES ('Sabão', 10),
	   ('Calça', 20),
	   ('Rim', 3)

--------------------------------

BEGIN TRANSACTION;

	PRINT(@@TRANCOUNT)

	INSERT INTO	tb_itens
	VALUES ('Periquito', 1)

	SELECT * FROM tb_itens;

	UPDATE tb_itens
	SET qtd = 2
	WHERE id = 3;

ROLLBACK TRANSACTION;