BEGIN TRY
	CREATE DATABASE legal;
END TRY
BEGIN CATCH 
	PRINT('BD já criado');
END CATCH;
GO --garante que todas as transações de cima sejam concluidas antes de começar as próxs

USE legal;

IF NOT EXISTS(
				SELECT 
					* 
				FROM 
					sys.tables 
				WHERE 
					name='tb_coordenadas'
			 )
BEGIN
	CREATE TABLE tb_coordenadas
	(
		id		INT PRIMARY KEY IDENTITY(1,1),
		nome	VARCHAR(MAX),
		x		FLOAT,
		y		FLOAT
	);
END;

/*
Exercicio 1: introduzir 100 linhas aleatorias... (lista de exs cursores)

I. inserir 100 linhas
II. o nome é particula i (= numero de linhas)
III. x e y numeros aleatorios entre 50 e 100
*/

DECLARE @i	  INT = 1;
WHILE @i <= 100
BEGIN
	DECLARE @nome VARCHAR(MAX) = 'particula' + CONVERT(VARCHAR, @i); -- precisa abrir outro declare pq não consigo usar uma variavel em outra antes dela ser declarada na memoria
	DECLARE @x	  FLOAT = (50 + RAND() * 50),
			@y	  FLOAT = (50 + RAND() * 50);

	INSERT INTO 
		tb_coordenadas
	VALUES
		(@nome, @x, @y)

	SET @i = @i + 1;
END;

SELECT * FROM tb_coordenadas;

/*
Exercicio 2:

I.Fazer copia da tabela tb_coordenadas
II. Esta copia deve ser feita com cursores

--> Criar uma tabela tb_copia c/ a mesma estrutura da tb_coordenadas e preenche-las com as respectivas linhas
*/

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tb_copia')
BEGIN
	CREATE TABLE tb_copia
	(
		id		INT PRIMARY KEY IDENTITY(1,1),
		nome	VARCHAR(MAX),
		x		FLOAT,
		y		FLOAT
	);
END;

-- CRIANDO CURSORES ---------------------------------
-- 1) Declaração
DECLARE cursor_ex2 CURSOR
FOR
SELECT * FROM tb_coordenadas;

-- 2) Abertura
OPEN cursor_ex2;

-- 3) Varredura

-- Desativar o travamento de registro de ID causado pelo identity
SET IDENTITY_INSERT tb_copia ON; 

DECLARE @id		 INT,
		@nome	 VARCHAR(MAX),
		@x		 FLOAT,
		@y		 FLOAT,
		@i		 INT = 1,
		@tamanho INT = (SELECT COUNT(*) FROM tb_coordenadas);

WHILE @i <= @tamanho
BEGIN
	-- Uso do cursor
	FETCH NEXT FROM cursor_ex2 INTO @id, @nome, @x, @y;

	-- Uma vez feito o acesso, pode-se utiliza as vaiaveis
	-- ou o conteudo das linhas da tabela tb_coordenadsa
	INSERT INTO tb_copia (id, nome, x, y)
	VALUES (@id, @nome, @x, @y);

	SET @i = @i + 1;
END;

-- Ligar de novo o travamento causado pelo IDENTITY
SET IDENTITY_INSERT tb_copia OFF; 

-- 4) Fechamento
CLOSE cursor_ex2;
DEALLOCATE cursor_ex2;

SELECT * FROM tb_coordenadas
SELECT * FROM tb_copia



-- OUTRA FORMA DE UTILIZAR CURSORES ---------------------------------
IF NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'tb_copia2')
BEGIN
	CREATE TABLE tb_copia2
	(
		id		INT PRIMARY KEY IDENTITY(1,1),
		nome	VARCHAR(MAX),
		x		FLOAT,
		y		FLOAT
	);
END;

-- 1) Declaração
DECLARE cursor_ex2_2 CURSOR
FOR
SELECT * FROM tb_coordenadas;

-- 2) Abertura
OPEN cursor_ex2_2;

-- 3) Varredura

-- Desativar o travamento de registro de ID causado pelo identity
SET IDENTITY_INSERT tb_copia2 ON; 

DECLARE @id		 INT,
		@nome	 VARCHAR(MAX),
		@x		 FLOAT,
		@y		 FLOAT;

FETCH NEXT FROM cursor_ex2_2 INTO @id, @nome, @x, @y
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Uma vez feito o acesso, pode-se utiliza as vaiaveis
	-- ou o conteudo das linhas da tabela tb_coordenadsa
	INSERT INTO tb_copia2(id, nome, x, y)
	VALUES (@id, @nome, @x, @y);

	-- Passar para a prox linha
	FETCH NEXT FROM cursor_ex2_2 INTO @id, @nome, @x, @y;
END;

-- Ligar de novo o travamento causado pelo IDENTITY
SET IDENTITY_INSERT tb_copia2 OFF; 

-- 4) Fechamento
CLOSE cursor_ex2_2;
DEALLOCATE cursor_ex2_2;

SELECT * FROM tb_coordenadas
SELECT * FROM tb_copia2

/*
Exercicio 4:

I. Deletar aleatoriamente 4 itens da tabela tb_coordenadas
	--> Tenta remover
	  --> Deu certo? +1
	--> Não deu?
	  --> Tentar de novo

II. Detectar os itens removidos da tb_coordenadas pela tb_copia usando cursores
	--> Fazer varredura na tb_copia e detectar quem não está mais na tb_coordenadas

III. Recuperar estes itens
	--> INSERT(<mesmo item anterior>)
*/

-- I.
DECLARE @qtd_removidos INT = 0,
		@tamanho_tabela INT = (SELECT COUNT(*) FROM tb_coordenadas);

PRINT(CONCAT('tamanho inicial = ', @tamanho_tabela));

WHILE @qtd_removidos < 4
BEGIN
	DECLARE @id_random INT = CONVERT(INT, (1 + RAND() * (@tamanho_tabela - 1)));

	BEGIN TRY
		DELETE FROM tb_coordenadas
		WHERE id = @id_random

		SET @qtd_removidos = @qtd_removidos + 1;
	END TRY
	BEGIN CATCH
		PRINT('id não encontrado');
	END CATCH;
END;

DECLARE @tamanho_final INT = (SELECT COUNT(*) FROM tb_coordenadas)
PRINT(CONCAT('tamanho final = ', @tamanho_final))

-- II.

-- Declaração
DECLARE cursor_ex4 CURSOR
FOR
SELECT * FROM tb_copia;

-- Abertura
OPEN cursor_ex4;

-- Varredura
DECLARE @i INT = 1,
		@n INT = (SELECT COUNT(*) FROM tb_copia);
DECLARE @id INT, @nome VARCHAR(MAX), @x FLOAT, @y FLOAT;

WHILE @i <= @n
BEGIN
	FETCH NEXT FROM cursor_ex4 INTO @id, @nome, @x, @y;

	DECLARE @m INT = (SELECT COUNT(*) FROM tb_coordenadas WHERE id = @id);

	IF @m = 0
	BEGIN
		PRINT(CONCAT('Linha com id = ', @id, 'foi removida'));
	END;

	SET @i = @i + 1
END;

-- Fechamento
CLOSE cursor_ex4;
DEALLOCATE cursor_ex4;

-- III.
-- Declaração
DECLARE cursor_ex4_2 CURSOR
FOR
SELECT * FROM tb_copia;

-- Abertura
OPEN cursor_ex4_2;

-- Varredura
DECLARE @i INT = 1,
		@n INT = (SELECT COUNT(*) FROM tb_copia);
DECLARE @id INT, @nome VARCHAR(MAX), @x FLOAT, @y FLOAT;

WHILE @i <= @n
BEGIN
	FETCH NEXT FROM cursor_ex4_2 INTO @id, @nome, @x, @y;

	DECLARE @m INT = (SELECT COUNT(*) FROM tb_coordenadas WHERE id = @id);

	IF @m = 0
	BEGIN
		PRINT(CONCAT('Linha com id = ', @id, 'foi removida'));
	END;

	SET @i = @i + 1
END;

-- Fechamento
CLOSE cursor_ex4_2;
DEALLOCATE cursor_ex4_2;