CREATE TABLE tb_aux(
	id		INT PRIMARY KEY IDENTITY(1,1),
	tipo	VARCHAR(MAX),
	horario DATETIME
);

CREATE OR ALTER TRIGGER on_modify
ON tb
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @qtde_removidos INT = (SELECT COUNT(*)
									FROM DELETED),
			@qtde_inseridos INT = (SELECT COUNT(*)
									FROM INSERTED);

	DECLARE @tipo_modificacao VARCHAR(MAX);
	IF ((@qtde_inseridos != 0) AND (@qtde_removidos != 0))
		SET @tipo_modificacao = 'Atualizacao';
	ELSE
	BEGIN
		IF (@qtde_inseridos = 0)
			SET @tipo_modificacao = 'Remocao';
		ELSE
			SET @tipo_modificacao = 'Insercao';
	END;

	INSERT INTO tb_aux
	VALUES (@tipo_modificacao, GETDATE());
END;

SELECT * FROM tb;

SELECT * FROM tb_aux;

EXEC add_linhas 10000;

DELETE FROM tb;

UPDATE tb
SET nome = 'atualizado'
WHERE id = 262043;


CREATE OR ALTER PROCEDURE faz_backup
@tipo INT,
@endereco VARCHAR(MAX)
AS
BEGIN
	DECLARE @nome_do_arquivo VARCHAR(MAX) = 'db06112024_';

	 -- Definir o nome
	 IF @tipo = 1
		SET @nome_do_arquivo = @nome_do_arquivo + 'completo_';
	 ELSE
		SET @nome_do_arquivo = @nome_do_arquivo + 'diferencial_';

	 SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX),DATEPART(YEAR,GETDATE())) + '_';
	 SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX),DATEPART(MONTH,GETDATE())) + '_';
	 SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX),DATEPART(DAY,GETDATE())) + '_';
	 SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX),DATEPART(HOUR,GETDATE())) + '_';
	 SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX),DATEPART(MINUTE,GETDATE())) + '_';
	 SET @nome_do_arquivo = @nome_do_arquivo + CONVERT(VARCHAR(MAX),DATEPART(SECOND,GETDATE()));
	 SET @nome_do_arquivo = @nome_do_arquivo + '.bak';

	 -- Definir o caminho completo = @endereco + @nome_do_arquivo
	 DECLARE @caminho VARCHAR(MAX) = @endereco + @nome_do_arquivo;

	 -- Executar o comando de backup DE ACORDO com o @tipo
	 IF (SELECT COUNT(*) FROM tb_aux) >= 10000
	 BEGIN
		 IF @tipo = 1
			BACKUP DATABASE db06112024
			TO DISK = @caminho;
		 ELSE
			BACKUP DATABASE db06112024
			TO DISK = @caminho
			WITH DIFFERENTIAL;

		 TRUNCATE TABLE tb_aux;
	END;
END;

EXEC faz_backup 2, 'C:/Backup/Diferencial/';

EXEC add_linhas 10000;

SELECT COUNT(*) FROM tb_aux;