DECLARE @i INT = 0, 
		@nome VARCHAR(8000) = 'Alexandre Toledo';

PRINT(@nome);
SELECT @nome;

PRINT(@i);
SELECT @i;

-- Vari�veis de Sistema ------------------------------------------------
PRINT('Vers�o do Sistema: ' + @@VERSION);
PRINT('Nome do Servidor: ' + @@SERVERNAME);
PRINT('Idioma Padr�o: ' + @@LANGUAGE);
PRINT(@@IDENTITY);
PRINT('N�mero de linhas alteradas na �ltima opera��o: ' + @@ROWCOUNT);

PRINT('ID da se��o: ' + CONVERT(VARCHAR,@@SPID));
PRINT('Numero de linhas alteradas na ultima opera��o: ' + CONVERT(VARCHAR, @@ROWCOUNT));
PRINT('Numero de conex�es ativas no BD: ' + CONVERT(VARCHAR, @@CONNECTIONS));
PRINT('Tempo limite de conex�o: ' + CONVERT(VARCHAR, @@LOCK_TIMEOUT))

-- Fun��es -------------------------------------------------------------
DECLARE @j INT = 0;
DECLARE @msg VARCHAR(8000) = 'O valor de j �: ' + CONVERT(VARCHAR, @j);
PRINT(@msg);


DECLARE @nome          VARCHAR(8000),
		@sobrenome	   VARCHAR(8000),
		@nome_completo VARCHAR(8000);

SET @nome = 'Bia';
SET @sobrenome = 'Falc�o';
SET @nome_completo = @nome + ' ' + @sobrenome;

PRINT('O nome completo �: ' + @nome_completo);