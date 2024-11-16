IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'db02092024')
BEGIN
	CREATE DATABASE db02092024
END;
GO

USE db02092024;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_serie_temporal')
BEGIN
	CREATE TABLE tb_serie_temporal
	(
		id  INT PRIMARY KEY IDENTITY(1,1),
		jan DECIMAL(10,2),
		fev DECIMAL(10,2),
		mar DECIMAL(10,2),
		abr DECIMAL(10,2),
		mai DECIMAL(10,2),
		jun DECIMAL(10,2)
	)
END;

INSERT INTO tb_serie_temporal
VALUES (CONVERT(DECIMAL(10,2), RAND()*10),
		CONVERT(DECIMAL(10,2), RAND()*10),
		CONVERT(DECIMAL(10,2), RAND()*10),
		CONVERT(DECIMAL(10,2), RAND()*10),
		CONVERT(DECIMAL(10,2), RAND()*10),
		CONVERT(DECIMAL(10,2), RAND()*10));

SELECT * FROM tb_serie_temporal

/* Exercicio 11:
Crie uma trigger que impeça a remoção de linhas quando a coluna JUN tiver o valor maior que 7.5
--> Na remoção
	--> Não fazer a remoção a menos que JUN <= 7.5
		--> Caso contrário, nós removemos na trigger
--> Após a remoção
	--> Se o valor de JUN for > 7.5, devolva-o para a tabela
*/
CREATE OR ALTER TRIGGER on_delete_tb_serie_temporal_1
ON tb_serie_temporal
INSTEAD OF /*EM VEZ DE*/ DELETE /*REMOVER*/
AS
BEGIN
	DELETE FROM 
		tb_serie_temporal
	WHERE 
		(
			(jun <= 7.5) 
			AND (id IN (SELECT id FROM DELETED))
		);
END;

SELECT * FROM tb_serie_temporal

DELETE FROM tb_serie_temporal
/*SELECT * FROM tb_serie_temporal*/ WHERE jun > 5;

/* Exercicio 12
Limitar o valor da coluna JUN para 7.5 em novos registros
	--> Depois de inserir
		--> Atualiza o valor de JUN do novo registro se for o caso (quando JUN for > 7.5 / Truncar para 7.5)
*/
CREATE OR ALTER TRIGGER on_insert_tb_serie_temporal
ON tb_serie_temporal
AFTER INSERT
AS
BEGIN
	UPDATE 
		tb_serie_temporal
	SET 
		jun = 7.5
	WHERE 
		(
			(jun > 7.5)
			AND (id IN (SELECT id FROM INSERTED))
		);
END;

SELECT * FROM tb_serie_temporal;

INSERT INTO tb_serie_temporal
VALUES (1,1,1,1,1,10)

/* Exercicio 13:
A atualizacao só ocorre se JUN for <= 7.5
*/
CREATE OR ALTER TRIGGER on_update_tb_serie_temporal
ON tb_serie_temporal
INSTEAD OF UPDATE
AS
BEGIN
	UPDATE 
		tb_serie_temporal
	SET 
		jan = INSERTED.jan,
		fev = INSERTED.fev,
		mar = INSERTED.mar,
		abr = INSERTED.abr,
		mai = INSERTED.mai,
		jun = INSERTED.jun
	FROM
		tb_serie_temporal
		JOIN INSERTED
			ON tb_serie_temporal.id = INSERTED.id
	WHERE
		INSERTED.jun <= 7.5;
END;

SELECT * FROM tb_serie_temporal
WHERE id = 2

UPDATE
	tb_serie_temporal
SET
	jan = 1,
	fev = 1,
	mar = 1,
	abr = 1,
	mai = 1,
	jun = 2
WHERE id = 2

/* Exercicio 14:
Criar a tabela contadora que faça um log (registro) das atualizações da tb_serie_temporal
Ao inserir na tb_serie_temporal, inserir nesta tabela
	o id do registro
	tido de CRUD feito
	qtd de linhas afetadas
	e a horario da acao
*/
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name='tb_contadora')
BEGIN
	CREATE TABLE tb_contadora
	(
		id		INT PRIMARY KEY IDENTITY(1,1),
		tipo	VARCHAR(MAX),
		qtde	INT,
		horario DATETIME
	);
END;

CREATE OR ALTER TRIGGER on_all_tb_serie_temporal
ON tb_serie_temporal
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	
	DECLARE @qtde_inseridos INT = (SELECT COUNT(*) FROM INSERTED),
			@qtde_deletados INT = (SELECT COUNT(*) FROM DELETED);

	IF ((@qtde_inseridos != 0) OR (@qtde_deletados != 0))
	BEGIN
		IF (@qtde_inseridos = @qtde_deletados)
		BEGIN
			INSERT INTO 
				tb_contadora
			VALUES 
				('Atualização', @qtde_inseridos, GETDATE());
		END;
		ELSE
		BEGIN
			IF (@qtde_inseridos != 0)
			BEGIN
				INSERT INTO
					tb_contadora
				VALUES 
					('Inserção', @qtde_inseridos, GETDATE());
			END;
			ELSE
			BEGIN
				INSERT INTO
					tb_contadora
				VALUES 
					('Remoção', @qtde_inseridos, GETDATE());
			END;
		END;
	END;
END;

SELECT * FROM tb_contadora;

INSERT INTO tb_serie_temporal
VALUES
	(1,2,3,4,5,10),
	(6,5,4,3,2,10)

SELECT * FROM tb_serie_temporal


/* Exercicio 15: NA PROVA -- item a) ex 5
uma trigger que projeto todos os valores de tb_serie_temporal (jan, fev, ...) entre o intervalo de [0,10]
	--> se JAN < 0  => JAN = 0
	--> se JAN > 10 => JAN = 10

	Fazer uma função para a projeção
	passar a função dentro da trigger (depois de inserir, projete)
*/
CREATE OR ALTER FUNCTION dbo.f_proj(@x   DECIMAL(10,2),
									@inf DECIMAL(10,2), -- inferior
									@sup DECIMAL(10,2)) -- superior
RETURNS DECIMAL(10,2)
AS
BEGIN
	IF (@inf > @sup)
	BEGIN
		DECLARE @temp DECIMAL(10,2) = @inf;
		SET @inf = @sup;
		SET @sup = @temp;
	END;

	DECLARE @resultado DECIMAL(10,2) = @x;

	IF (@x < @inf)
	BEGIN
		SET @resultado = @inf;
	END;
	ELSE IF (@x > @sup)
	BEGIN
		SET @resultado = @sup;
	END;

	RETURN @resultado;
END;

DECLARE @r DECIMAL(10,2) = dbo.f_proj(5,10,0);
PRINT(@r)

CREATE OR ALTER TRIGGER on_insert_2_tb_serie_temporal
ON tb_serie_temporal
AFTER INSERT
AS
BEGIN
	UPDATE
		tb_serie_temporal
	SET
		jan = dbo.f_proj(jan, 0, 10),
		fev = dbo.f_proj(fev, 0, 10),
		mar = dbo.f_proj(mar, 0, 10),
		abr = dbo.f_proj(abr, 0, 10),
		mai = dbo.f_proj(mai, 0, 10),
		jun = dbo.f_proj(jun, 0, 10)
	WHERE
		id IN (SELECT id FROM INSERTED);
END;

INSERT INTO tb_serie_temporal
VALUES (11,-2,3,4,5,15);

SELECT * FROM tb_serie_temporal