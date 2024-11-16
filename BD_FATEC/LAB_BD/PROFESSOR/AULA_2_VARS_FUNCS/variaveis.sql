/*
| Tipo de Dado   | Descri��o                                            | Tamanho                       |
|-------------------|---------------------------------------------------------|----------------------------------|
| bit           | Armazena valores 0 ou 1                                  | 1 bit                            |
| tinyint       | Armazena inteiros de 0 a 255                             | 1 byte                           |
| smallint      | Armazena inteiros de -32.768 a 32.767                    | 2 bytes                          |
| int           | Armazena inteiros de -2.147.483.648 a 2.147.483.647      | 4 bytes                          |
| bigint        | Armazena inteiros de -9.223.372.036.854.775.808 a 9.223.372.036.854.775.807 | 8 bytes                          |
| decimal/numeric | Armazena n�meros decimais com precis�o e escala definidas | 5 a 17 bytes, dependendo da precis�o |
| smallmoney    | Armazena valores monet�rios de -214.748,3648 a 214.748,3647 | 4 bytes                        |
| money         | Armazena valores monet�rios de -922.337.203.685.477,5808 a 922.337.203.685.477,5807 | 8 bytes |
| float         | Armazena n�meros de ponto flutuante                       | 4 bytes (precis�o 1-24) ou 8 bytes (precis�o 25-53) |
| real          | Armazena n�meros de ponto flutuante com precis�o menor    | 4 bytes                          |
| date          | Armazena uma data (ano, m�s, dia)                         | 3 bytes                          |
| datetime      | Armazena data e hora, precisa at� 1/300 de segundo        | 8 bytes                          |
| datetime2     | Armazena data e hora com precis�o estendida               | 6 a 8 bytes, dependendo da precis�o |
| smalldatetime | Armazena data e hora com precis�o de minutos              | 4 bytes                          |
| time          | Armazena apenas a hora do dia                             | 3 a 5 bytes, dependendo da precis�o |
| char(n)       | Armazena uma cadeia de caracteres de comprimento fixo     | n bytes                        |
| varchar(n)    | Armazena uma cadeia de caracteres de comprimento vari�vel | At� n bytes + 2 bytes de overhead |
| nchar(n)      | Armazena uma cadeia de caracteres Unicode de comprimento fixo | 2n bytes                   |
| nvarchar(n)   | Armazena uma cadeia de caracteres Unicode de comprimento vari�vel | At� 2n bytes + 2 bytes de overhead |
| binary(n)     | Armazena dados bin�rios de comprimento fixo               | n bytes                        |
| varbinary(n)  | Armazena dados bin�rios de comprimento vari�vel           | At� n bytes + 2 bytes de overhead |
| uniqueidentifier | Armazena um identificador exclusivo global (GUID)     | 16 bytes                         |
*/

/*
Estrutura para declara��o de vari�veis no T-SQL

DECLARE <nome_da_variavel> <tipo_da_variavel> [opcional] = <valor_inicial>;
*/

DECLARE @i INT = 0;
DECLARE @k INT;

/*
� poss�vel declarar mais de uma vari�vel por vez, mas o tipo de cada uma deve ser especificado:

DECLARE var_1 <tipo_1> [inicializa��o],
		var_2 <tipo_2> [inicializa��o],
		...
		var_n <tipo_n> [inicializa��o];
*/

DECLARE @r FLOAT = 0,
        @PI FLOAT = 3.14159265,
		@nome VARCHAR(1000) = 'Alexandre Toledo',
		@data_de_inicio DATETIME;

/*
As vari�veis podem ser visualizadas com sele��es ou com impress�es pela fun��o PRINT(.).
*/

PRINT('Nome declarado: ' + @nome);


/*
			Vari�veis de Sistema (@@)
*/

PRINT('Vers�o do sistema:' + @@VERSION);
PRINT('Nome do servidor:' + @@SERVERNAME);
PRINT('ID da se��o atual:' + @@SPID);
PRINT('Total de conex�es no BD:' + @@CONNECTIONS);
PRINT('N�mero de transa��es ativas:' + @@TRANCOUNT);
PRINT('Idioma padr�o:' + @@LANGUAGE);
PRINT('Tempo limite para bloqueio: ' + @@LOCK_TIMEOUT);
PRINT('Linhas afetadas pela �ltima opera��o de leitura ou escrita no BD: '+@@IDENTITY);

/*

� poss�vel converter uma vari�vel de um tipo para o outro no T-SQL com a fun��o CONVERT(<tipo_destino>, <variavel>).

Obs.: Existe a fun��o CAST(<variavel> AS <tipo_destino>) que tem o mesmo efeito.

*/

PRINT('Vers�o do sistema:' + @@VERSION);
PRINT('Nome do servidor:' + @@SERVERNAME);
PRINT('ID da se��o atual:' + CONVERT(VARCHAR,@@SPID));
PRINT('Total de conex�es no BD:' + CONVERT(VARCHAR,@@CONNECTIONS));
PRINT('N�mero de transa��es ativas:' + CONVERT(VARCHAR,@@TRANCOUNT));
PRINT('Idioma padr�o:' + @@LANGUAGE);
PRINT('Tempo limite para bloqueio: ' + CONVERT(VARCHAR,@@LOCK_TIMEOUT));
PRINT('Linhas afetadas pela �ltima opera��o de leitura ou escrita no BD: '+CONVERT(VARCHAR,@@ROWCOUNT));


/*
Toda e qualquer atribui��o de vari�veis fora do escopo de defini��o da mesma se faz em um ambiente de configura��o (SET).
*/

DECLARE @i INT = 0;

SET @i = @i + 1;

PRINT(@i);

DECLARE @nome VARCHAR(8000) = 'Bia';

SET @nome = @nome + ' Falc�o';

DECLARE @msg VARCHAR(8000) = 'Nome: ' + @nome;

PRINT(@msg);



























