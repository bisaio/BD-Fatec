/*
### *1. IF*

A estrutura IF no T-SQL � usada para executar um bloco de c�digo condicionalmente, com base na avalia��o de uma express�o booleana. Voc� pode tamb�m incluir uma cl�usula ELSE para especificar o que deve acontecer se a condi��o for falsa.

#### *Sintaxe*:

IF <condi��o>
BEGIN
    -- C�digo a ser executado se a condi��o for verdadeira
END
ELSE
BEGIN
    -- C�digo a ser executado se a condi��o for falsa
END
*/

--#### *Exemplo*:
DECLARE @Valor INT = 10;

IF @Valor > 5
BEGIN
    PRINT 'O valor � maior que 5';
END
ELSE
BEGIN
    PRINT 'O valor � 5 ou menor';
END


/*
### *2. CASE (Equivalente ao SWITCH)*

O CASE � usado para executar uma express�o ou bloco de c�digo com base em diferentes condi��es. Ele pode ser usado tanto em consultas para retornar valores baseados em condi��es quanto em blocos de c�digo.

#### *Sintaxe*:
SELECT
    CASE 
        WHEN <condi��o1> THEN <resultado1>
        WHEN <condi��o2> THEN <resultado2>
        ELSE <resultado_default>
    END AS Resultado
FROM
    <tabela>;
*/

--#### *Exemplo*:
DECLARE @DiaSemana INT = 3;

SELECT 
    CASE @DiaSemana
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-feira'
        WHEN 3 THEN 'Ter�a-feira'
        ELSE 'Outro dia'
    END AS NomeDia;

/*
### *3. WHILE*

A estrutura WHILE no T-SQL � usada para repetir um bloco de c�digo enquanto uma condi��o espec�fica for verdadeira. � semelhante ao loop WHILE em outras linguagens de programa��o.

#### *Sintaxe*:
WHILE <condi��o>
BEGIN
    -- C�digo a ser executado enquanto a condi��o for verdadeira
END
*/

--#### *Exemplo*:
DECLARE @Contador INT = 1;

WHILE @Contador <= 5
BEGIN
    PRINT 'Contagem: ' + CAST(@Contador AS VARCHAR(10));
    SET @Contador = @Contador + 1;
END;

/*
### *4. TRY-CATCH*

O bloco TRY-CATCH no T-SQL � usado para capturar e tratar exce��es ou erros que possam ocorrer durante a execu��o de um bloco de c�digo. Se um erro ocorrer no bloco TRY, o controle � transferido para o bloco CATCH, onde voc� pode lidar com o erro.

#### *Sintaxe*:
BEGIN TRY
    -- C�digo que pode causar um erro
END TRY
BEGIN CATCH
    -- C�digo para lidar com o erro
    -- Fun��es como ERROR_MESSAGE() podem ser usadas aqui
END CATCH
*/

--#### *Exemplo*:
BEGIN TRY
    -- Tentativa de divis�o por zero, que causar� um erro
    DECLARE @Resultado INT;
    SET @Resultado = 10 / 0;
END TRY
BEGIN CATCH
    PRINT 'Ocorreu um erro: ' + ERROR_MESSAGE();
END CATCH;

-- ### B�nus: Lan�amento de erro.
/*
A fun��o RAISERROR no T-SQL � utilizada para gerar mensagens de erro personalizadas e retornar essas mensagens ao chamador, seja ele uma aplica��o cliente ou outro procedimento T-SQL. Essa fun��o � frequentemente usada dentro de blocos de controle de erro, como TRY-CATCH, para relatar erros espec�ficos com mensagens e n�veis de severidade customizados.

### *Sintaxe*


RAISERROR (message_string, severity, state [, argument [, ...]])


- *message_string*: A mensagem de erro que ser� exibida. Pode incluir marcadores de substitui��o (%s, %d, etc.) para valores que ser�o passados como argumentos.
- *severity*: Um n�mero inteiro entre 0 e 25 que indica a gravidade do erro. Valores comuns s�o:
  - *0-10*: Mensagens informativas.
  - *11-16*: Erros que indicam problemas no c�digo ou l�gica do usu�rio.
  - *17-25*: Erros mais graves, geralmente relacionados ao ambiente ou � integridade do banco de dados.
- *state*: Um n�mero inteiro entre 0 e 255 que indica a origem do erro. O valor � geralmente 1.
- *argument*: Valores que ser�o substitu�dos nos marcadores da message_string.
*/
--### *Exemplos de Uso*

--#### *1. Simples RAISERROR*

RAISERROR('MENSAGEM PADRAO', 16, 1);

/*
#### *2. RAISERROR com Substitui��o de Argumentos*

Voc� pode usar substitui��es na mensagem para incluir valores din�micos:
*/
DECLARE @ErroMensagem NVARCHAR(255) = 'Ocorreu um erro no produto %s com o ID %d.';
DECLARE @Produto NVARCHAR(50) = 'Notebook';
DECLARE @ProdutoID INT = 1001;

RAISERROR(@ErroMensagem, 16, 1, @Produto, @ProdutoID);

/*
#### *3. Uso com TRY-CATCH*

O RAISERROR � frequentemente utilizado dentro de blocos TRY-CATCH para relatar erros personalizados:

*/
BEGIN TRY
    -- Simula��o de um erro
    DECLARE @Divisor INT = 0;
    DECLARE @Resultado INT;
    
    SET @Resultado = 10 / @Divisor;
END TRY
BEGIN CATCH
    RAISERROR ('Divis�o por zero n�o � permitida.', 16, 1);
END CATCH;


-- Neste exemplo, se ocorrer uma divis�o por zero, a mensagem personalizada ser� gerada pelo RAISERROR.

