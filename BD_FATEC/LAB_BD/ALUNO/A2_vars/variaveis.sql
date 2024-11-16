DECLARE @i INT = 0, 
		@nome VARCHAR(8000) = 'Alexandre Toledo';

PRINT(@nome);
SELECT @nome;

PRINT(@i);
SELECT @i;

-- Variáveis de Sistema ------------------------------------------------
PRINT('Versão do Sistema: ' + @@VERSION);
PRINT('Nome do Servidor: ' + @@SERVERNAME);
PRINT('Idioma Padrão: ' + @@LANGUAGE);
PRINT(@@IDENTITY);
PRINT('Número de linhas alteradas na última operação: ' + @@ROWCOUNT);

PRINT('ID da seção: ' + CONVERT(VARCHAR,@@SPID));
PRINT('Numero de linhas alteradas na ultima operação: ' + CONVERT(VARCHAR, @@ROWCOUNT));
PRINT('Numero de conexões ativas no BD: ' + CONVERT(VARCHAR, @@CONNECTIONS));
PRINT('Tempo limite de conexão: ' + CONVERT(VARCHAR, @@LOCK_TIMEOUT))

-- Funções -------------------------------------------------------------
DECLARE @j INT = 0;
DECLARE @msg VARCHAR(8000) = 'O valor de j é: ' + CONVERT(VARCHAR, @j);
PRINT(@msg);


DECLARE @nome          VARCHAR(8000),
		@sobrenome	   VARCHAR(8000),
		@nome_completo VARCHAR(8000);

SET @nome = 'Bia';
SET @sobrenome = 'Falcão';
SET @nome_completo = @nome + ' ' + @sobrenome;

PRINT('O nome completo é: ' + @nome_completo);