/*
1. Escrever um procedyure que salva o banco de dados em uso de acordo com o @tipo, que pode ser 1 para completo e 2 para diferencial,
e o @endereco que representa o local em disco para o backup. Além disso, o nome do arquivo de backup deve ser definido como:
<nome_do_BD>_<tipo de Backup>_<dia>_<mes>_<ano>_<hora>_<minuto>_<segundo>.BAK
*/
USE db06112024;

--- PROFESSOR -----------------------------------
CREATE OR ALTER PROCEDURE faz_backup
@tipo INT,
@endereco VARCHAR(MAX)
AS
BEGIN
	-- Definir o nome
	DECLARE @nome_do_arquivo VARCHAR(MAX) = 'db06112024_';

	IF @tipo = 1
		SET @nome_do_arquivo = @nome_do_arquivo + 'completo_';
	ELSE
		SET @nome_do_arquivo = @nome_do_arquivo + 'diferencial_';

	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(YEAR, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(MONTH, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(DAY, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(HOUR, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(MINUTE, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(SECOND, GETDATE())) + '.bak';

	-- Definir o caminho completo = @endereco + @nome_do_arquivo
	DECLARE @caminho VARCHAR(MAX) = @endereco + @nome_do_arquivo

	-- Executar o comando de Backup DE ACORDO com o @tipo
	IF @tipo = 1
		BACKUP DATABASE db06112024
		TO DISK = @caminho
	ELSE
		BACKUP DATABASE db06112024
		TO DISK = @caminho
		WITH DIFFERENTIAL
END;

EXEC faz_backup 1, 'C:/Backup/Completo/'
EXEC faz_backup 2, 'C:/Backup/Diferencial/'

SELECT COUNT(*) FROM tb

EXEC add_linhas 1000;

DELETE FROM tb

/*
PARA RESTAURAR:
	- F8
	- SELECIONAR O BANCO
	- BOTAO DIREITO -> TAREFAS
	- RESTAURAR
	- BANCO DE DADOS
*/




/*
2. Escreva uma procedure que conduza um backup diferencial sempre que a tabela tb receber 10.000 atualizacoes

-> A procedure é parecida com a procedure do exercicio anterior, mas precisa verificar o numero de atualizacoes em tb
-> criar tabela auxiliar que vai ter uma trigger para atualizar esta tabela com as acoes realizadas na tb
	-> se tb_auxiliar tiver com mais de 10.000 atualizar a tb e apagar o que tiver em auxiliar
*/

CREATE TABLE tb_aux
	(
		id		INT PRIMARY KEY IDENTITY(1,1),
		tipo	VARCHAR(MAX),
		horario DATETIME
	);

CREATE OR ALTER TRIGGER on_modify
ON tb
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @qtde_removidos INT = (SELECT COUNT(*) FROM DELETED),
			@qtde_inseridos INT = (SELECT COUNT(*) FROM INSERTED);

	DECLARE @tipo_modificacao VARCHAR(MAX)

	IF ((@qtde_inseridos != 0) AND (@qtde_removidos != 0))
		SET @tipo_modificacao = 'Atualizacao'
	ELSE
		BEGIN
			IF (@qtde_inseridos = 0)
				SET @tipo_modificacao = 'Remocao'
			ELSE
				SET @tipo_modificacao = 'Insercao';
		END;

	INSERT INTO tb_aux
	VALUES (@tipo_modificacao, GETDATE());
END;

CREATE OR ALTER PROCEDURE faz_backup
@tipo INT,
@endereco VARCHAR(MAX)
AS
BEGIN
	-- Definir o nome
	DECLARE @nome_do_arquivo VARCHAR(MAX) = 'db06112024_';

	IF @tipo = 1
		SET @nome_do_arquivo = @nome_do_arquivo + 'completo_';
	ELSE
		SET @nome_do_arquivo = @nome_do_arquivo + 'diferencial_';

	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(YEAR, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(MONTH, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(DAY, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(HOUR, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(MINUTE, GETDATE())) + '_';
	SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX), DATEPART(SECOND, GETDATE())) + '.bak';

	-- Definir o caminho completo = @endereco + @nome_do_arquivo
	DECLARE @caminho VARCHAR(MAX) = @endereco + @nome_do_arquivo

	-- Executar o comando de Backup DE ACORDO com o @tipo
	IF (SELECT COUNT(*) FROM tb_aux) >= 10000
	BEGIN
		IF @tipo = 1
			BACKUP DATABASE db06112024
			TO DISK = @caminho
		ELSE
			BACKUP DATABASE db06112024
			TO DISK = @caminho
			WITH DIFFERENTIAL

		TRUNCATE TABLE tb_aux
	END
END;



SELECT * FROM tb_aux

EXEC add_linhas 1000;

SELECT * FROM tb_aux

DELETE FROM tb

SELECT * FROM tb_aux

SELECT * FROM tb

UPDATE tb
SET nome = 'atualizado'
WHERE id = 248483

EXEC faz_backup 1, 'C:/Backup/Completo/'

EXEC add_linhas 10000;

EXEC faz_backup 1, 'C:/Backup/Completo/'
SELECT * FROM tb_aux