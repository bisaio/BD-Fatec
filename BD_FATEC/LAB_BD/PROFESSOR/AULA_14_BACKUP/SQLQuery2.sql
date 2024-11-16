
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
	 IF @tipo = 1
		BACKUP DATABASE db06112024
		TO DISK = @caminho;
	ELSE
		BACKUP DATABASE db06112024
		TO DISK = @caminho
		WITH DIFFERENTIAL;
END;

EXEC faz_backup 1, 'C:/Backup/Completo/';
GO
EXEC faz_backup 2, 'C:/Backup/Diferencial/';


SELECT COUNT(*) FROM tb;


EXEC add_linhas 10000;

TRUNCATE TABLE tb;






