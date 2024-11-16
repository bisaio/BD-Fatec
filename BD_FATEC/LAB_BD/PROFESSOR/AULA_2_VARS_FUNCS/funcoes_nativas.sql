/*
| *Fun��o*               | *Descri��o*                                              | *Sintaxe e Par�metros*                                              | *Exemplo de Uso*                                             | *Exemplo de Resposta*             |
|------------------------|------------------------------------------------------------|----------------------------------------------------------------------|----------------------------------------------------------------|-------------------------------------|
| *DATEDIFF()*           | Calcula a diferen�a entre duas datas em uma unidade espec�fica (dia, m�s, ano). | DATEDIFF(unidade, data_inicio, data_fim)                          | DATEDIFF(YEAR, '2000-01-01', GETDATE())                      | 24 (diferen�a em anos)            |
| *YEAR()*               | Extrai o ano de uma data.                                  | YEAR(data)                                                        | YEAR('2024-08-09')                                           | 2024                              |
| *SUBSTRING()*          | Extrai uma por��o espec�fica de uma string.                | SUBSTRING(texto, posi��o_inicial, comprimento)                    | SUBSTRING('SQL Database', 5, 8)                              | Database                          |
| *CONCAT()*             | Concatena duas ou mais strings.                            | CONCAT(string1, string2, ...)                                     | CONCAT('Hello', ' ', 'World!')                               | Hello World!                      |
| *LEN()*                | Retorna o comprimento de uma string.                       | LEN(texto)                                                        | LEN('OpenAI')                                                 | 6                                 |
| *CAST()*               | Converte um valor de um tipo de dado para outro.           | CAST(valor AS tipo_destino)                                       | CAST(123.45 AS INT)                                          | 123                               |
| *CONVERT()*            | Converte um valor de um tipo de dado para outro, com op��es de estilo. | CONVERT(tipo_destino, valor, estilo)                            | CONVERT(VARCHAR, GETDATE(), 103)                             | 09/08/2024 (DD/MM/YYYY)           |
| *GETDATE()*            | Retorna a data e hora atuais do sistema.                   | GETDATE()                                                         | GETDATE()                                                    | 2024-08-09 10:00:00.000 (exemplo) |
| *RAND()*               | Gera um n�mero aleat�rio entre 0 e 1.                      | RAND()                                                            | RAND()                                                       | 0.547923 (exemplo)                |
| *DATEPART()*           | Extrai uma parte espec�fica de uma data (ano, m�s, dia, etc.). | DATEPART(parte, data)                                            | DATEPART(MONTH, '2024-08-09')                                | 8 (m�s de agosto)                 |
| *DATENAME()*           | Retorna o nome textual de uma parte espec�fica de uma data. | DATENAME(parte, data)                                            | DATENAME(WEEKDAY, '2024-08-09')                              | Friday                            |
| *LOWER()*              | Converte uma string para letras min�sculas.                | LOWER(texto)                                                      | LOWER('SQL SERVER')                                         | sql server                        |
| *UPPER()*              | Converte uma string para letras mai�sculas.                | UPPER(texto)                                                      | UPPER('sql server')                                         | SQL SERVER                        |
| *LEFT()*               | Retorna um n�mero especificado de caracteres do in�cio de uma string. | LEFT(texto, n�mero_caracteres)                                | LEFT('Database', 4)                                          | Data                              |
| *RIGHT()*              | Retorna um n�mero especificado de caracteres do final de uma string. | RIGHT(texto, n�mero_caracteres)                               | RIGHT('Database', 4)                                         | base                              |
| *ROUND()*              | Arredonda um n�mero para um n�mero espec�fico de casas decimais. | ROUND(valor, casas_decimais)                                  | ROUND(123.456, 2)                                            | 123.46                            |
| *COALESCE()*           | Retorna o primeiro valor n�o nulo em uma lista de argumentos. | COALESCE(valor1, valor2, ...)                                   | COALESCE(NULL, 'Default', 'Another')                         | Default                           |

---

### *Explica��o dos Par�metros*

- *unidade*: A unidade de medida para calcular a diferen�a entre datas (pode ser DAY, MONTH, YEAR, etc.).
- *data_inicio* e *data_fim*: As datas entre as quais a diferen�a ser� calculada.
- *texto*: A string a ser manipulada.
- *posi��o_inicial*: A posi��o inicial de onde a substring deve come�ar.
- *comprimento*: O n�mero de caracteres a serem extra�dos na substring.
- *string1, **string2*: Strings que ser�o concatenadas.
- *valor*: O valor a ser convertido ou manipulado.
- *tipo_destino*: O tipo de dado para o qual o valor ser� convertido.
- *parte*: A parte da data que se deseja extrair (pode ser YEAR, MONTH, DAY, HOUR, WEEKDAY, etc.).
- *n�mero_caracteres*: O n�mero de caracteres a serem retornados de uma string.
- *casas_decimais*: O n�mero de casas decimais para o qual um valor deve ser arredondado.
- *valor1, **valor2*, etc.: Valores a serem verificados por COALESCE(), retornando o primeiro n�o nulo.
*/



DECLARE @nome VARCHAR(8000) = 'Paola Bracho';


DECLARE @n INT = LEN(@nome);

PRINT('N�merio de caracteres no nome: ' + CONVERT(VARCHAR,@n));
PRINT('Substring come�ando em 5 e avan�ando 10 caracteres: ' + SUBSTRING(@nome, 5, 10)); -- SQL � 1-indexed.
PRINT('Substring dos 5 primeiros caracteres: '+ LEFT(@nome,5));
PRINT('Substring dos 5 �ltimos caracteres: '+ RIGHT(@nome,5));
PRINT('Ativa��o CAPS LOCK: ' + UPPER(@nome));
PRINT('Desativa��o CAPS LOCK: ' + LOWER(@nome));
PRINT(REPLACE(@nome, 'Paola', 'Paulina'));

DECLARE @resultado_de_concat VARCHAR(8000) = CONCAT('Sra. ', 'Paola', ' ', 'Bracho', ', MsC.');
PRINT(@resultado_de_concat);



/*
SQL_VARIANT_PROPERTY gera uma informa��o tabelada acerca da vari�vel:
*/
SELECT SQL_VARIANT_PROPERTY(@n,'BaseType') AS Tipo,
       SQL_VARIANT_PROPERTY(@n,'Precision') AS 'Precis�o',
	   SQL_VARIANT_PROPERTY(@n,'Scale') AS Escala;


/*
Fun��es matem�ticas.
*/

DECLARE @PI     FLOAT = 3.14159265;

DECLARE @sinpi2 FLOAT = SIN(@PI / 2),
        @cospi2 FLOAT = COS(@PI / 2),
		@tanpi2 FLOAT = TAN(@PI / 2);

PRINT(CONCAT('sen(PI/2) = ', @sinpi2));
PRINT(CONCAT('cos(PI/2) = ', @cospi2));
PRINT(CONCAT('tan(PI/2) = ', @tanpi2));

DECLARE @x_1 FLOAT = 0.1,
		@y_1 FLOAT = 0.2,
		@x_2 FLOAT = 0.3,
		@y_2 FLOAT = 0.4;
		/*
DECLARE @z FLOAT = SQRT(POWER(@x_1 - @x_2, 2) + POWER(@y_1 - @y_2,2));

PRINT(@z);*/

DECLARE @z FLOAT = POWER(POWER(@x_1 - @x_2, 2) + POWER(@y_1 - @y_2,2), 0.5);

PRINT(@z);




/*
Fun��es de arredondamento:

*/


DECLARE @E FLOAT = 2.718281828;

PRINT(CONCAT('CEILING(', @E, ') = ', CEILING(@E)));
PRINT(CONCAT('FLOOR(', @E, ') = ', FLOOR(@E)));
PRINT(CONCAT('ROUND(', @E, ', 2) = ', ROUND(@E, 2))); -- ROUND(<vari�vel>, <qtde_de_casas_decimais>)


/*
Gera��o de n�meros aleat�rios: RAND() gera n�meros pseudorandoms entre 0 e 1.
*/

PRINT(RAND());

/*
Tratamento de datas!

Fun��es: 
GETDATE(), 
DATEPART(<parte_da_data>, <data>), 
DATENAME(<parte_da_data>, <data>), 
DATEDIFF(<unidade>, <data1>, <data2>), 
YEAR(<data>), DAY(<data>), MONTH(<data>)

*/


DECLARE @data_de_hoje DATETIME = GETDATE(),
		@data_niver DATETIME = '1992-04-12';

PRINT(CONCAT('Dia de hoje: ', @data_de_hoje));

PRINT(YEAR(@data_de_hoje));
PRINT(DATENAME(MONTH,(@data_de_hoje)));
PRINT(DAY(@data_de_hoje));

PRINT(CONCAT('Dias de vida: ', DATEDIFF(DAY, @data_de_hoje, @data_niver)));

PRINT(CONCAT('Segundo atual: ', DATEPART(SECOND, @data_de_hoje)));

/*
Fun��o de gera��o de c�digo hexadecimal rand�mico: NEWID()

Gera valores literais do tipo [8]-[4]-[4]-[4]-[12].

Exemplo de c�digo gerado: A87100DC-975E-4891-8F6A-D4FF809AE823.
*/

PRINT(NEWID());





















