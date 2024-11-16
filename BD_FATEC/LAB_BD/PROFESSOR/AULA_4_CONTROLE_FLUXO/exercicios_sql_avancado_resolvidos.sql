/*Considere a tabela gerada abaixo no banco bd_exames para solucionar os próximos exercícios.*/
BEGIN TRY
	CREATE DATABASE bd_exames;
	USE bd_exames;
END TRY
BEGIN CATCH
	USE bd_exames;
END CATCH

IF EXISTS(SELECT 1 FROM sys.tables WHERE name = 'tb_exames')
BEGIN
	DROP TABLE tb_exames;
END;

CREATE TABLE tb_exames (
	id			INT PRIMARY KEY IDENTITY(1,1),   -- Identificador único do paciente
	nome		VARCHAR(100),                    -- Nome completo do paciente
	data_exame	DATE,                            -- Data em que o exame foi realizado

	colesterol_total DECIMAL(7,2),           -- Colesterol Total
	-- Limite Normal: Menos de 200 mg/dL ([0,200])

	LDL DECIMAL(7,2),                        -- Lipoproteína de Baixa Densidade
	-- Limite Normal: Menos de 100 mg/dL ([0,100])

	HDL DECIMAL(7,2)                         -- Lipoproteína de Alta Densidade
	-- Limite Normal: Mais de 60 mg/dL ([0,60])
);

/*Exercício 1:
Adicione 100 registros aleatórios na tabela acima considerando os seguintes requisitos:

(a) O nome do paciente deve ser uma string aleatória de 10 caracteres. Dica: use NEWID(.).

(b) A data a ser gerada deve ser qualquer data válida diferente de 29 de fevereiro de qualquer ano entre 1990 e 2024.
Se a data gerada não for válida, esta deve ser projetada para a data válida mais próxima.

(c) Os colesteróis devem ser gerados no intervalo [0,300].
*/

DECLARE @i				INT = 0,
		@max_registros	INT = 100;

WHILE @i < @max_registros
BEGIN
	DECLARE @nome VARCHAR(10) = SUBSTRING(CONVERT(VARCHAR(36),NEWID()),1,10),
	        @dia INT = CONVERT(INT, 30 * RAND() + 1),
	        @mes INT = CONVERT(INT, 11 * RAND() + 1),
	        @ano INT = CONVERT(INT, (2024 - 1990) * RAND() + 1990),
	        @CT  INT = CONVERT(INT, 300 * RAND()),
	        @LDL INT = CONVERT(INT, 300 * RAND()),
	        @HDL INT = CONVERT(INT, 300 * RAND()),
			@data_str VARCHAR(MAX);

	-- Vamos lidar com a data
	SET @data_str = CONCAT(@ano, '-', @mes, '-', @dia);

	DECLARE @data DATE;

	IF @dia = 29 AND @mes = 2
	BEGIN
		SET @dia = 28;
	END;

	BEGIN TRY
		SET @data = CONVERT(DATE, @data_str); -- Se deu certo, a data é válida.
	END TRY
	BEGIN CATCH		
		-- Se não deu certo, é dia 31 de algum mês que não tem 31.
		-- Então, vamos projetar pro dia anterior.
		SET @data_str = CONCAT(@ano, '-', @mes, '-', @dia - 1);
		SET @data = CONVERT(DATE, @data_str);
	END CATCH;
	-- Valor da data ajustado

	-- Condução dos INSERTs
	INSERT INTO tb_exames
	VALUES (@nome, @data, @CT, @LDL, @HDL);

	-- Atualização do passo.
	SET @i = @i + 1;
END;

SELECT * FROM tb_exames;

/*Exercício 2:
Adicione uma coluna na tabela acima chamada "condicao" como sendo um VARCHAR(10). 

O valor associado a essa coluna deve ser:

['Controle'] no caso de todos os valores de colesteróis estarem dentro das faixas consideradas saudáveis; ou

['Paciente'] no caso contrário.
*/

ALTER TABLE tb_exames
ADD condicao VARCHAR(10);

SELECT * FROM tb_exames;


UPDATE tb_exames
SET condicao = 'Paciente';

SELECT * FROM tb_exames;

UPDATE tb_exames
SET condicao = 'Controle'
WHERE colesterol_total <= 200 AND LDL <= 100 AND HDL >= 60;

SELECT * FROM tb_exames;

/*Exercício 3:
(a) Delete Aleatoriamente um paciente com id entre 2 e 99.
(b) Qual é o paciente com colesteróis mais semelhantes ao paciente ('observação', '2024-08-28', 50, 50, 50, ' - ')?
Dica 1: Considere os três colesteróis ao mesmo tempo ao conduzir as comparações. 
Dica 2: Distância euclidiana (raiz da soma das diferenças quadráticas).
*/
DECLARE @id_mais_proximo	INT = 1,
		@dist_max			FLOAT = 250 * SQRT(3);

-- Declarar o cursor
DECLARE cursor_exames CURSOR FOR
SELECT id, colesterol_total, LDL, HDL 
FROM tb_exames;

-- Abrir o cursor
OPEN cursor_exames;

-- Buscar o primeiro registro na tabela
DECLARE @id INT, @CT FLOAT, @HDL FLOAT, @LDL FLOAT;
FETCH NEXT FROM cursor_exames INTO @id, @CT, @HDL, @LDL;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Calcular a distância
	DECLARE @dist FLOAT = SQRT(POWER(50-@CT,2.0) + POWER(50-@HDL,2.0) + POWER(50-@HDL,2.0));
	
	IF @dist < @dist_max
	BEGIN
		SET @id_mais_proximo = @id;
		SET @dist_max = @dist;
	END;

    FETCH NEXT FROM cursor_exames INTO @id, @CT, @HDL, @LDL;
END;

CLOSE cursor_exames;
DEALLOCATE cursor_exames;

PRINT(CONCAT('ID do paciente mais parecido: ', @id_mais_proximo, CHAR(13), 'distância: ',@dist_max));

SELECT * FROM tb_exames WHERE id = @id_mais_proximo;

/*Exercício 4:
Adicione o paciente ('observação', '2024-08-28', 50, 50, 50, ' - ') na tabela e atribua a ele a condição do paciente mais próximo.
*/

INSERT INTO tb_exames VALUES ('observação', '2024-08-28', 50, 50, 50, 'Controle');

/*Exercício 5:
Adicione os seguintes pacientes à tabela:
i. ('pac (i)', '2024-08-28', 70, 70, 50, 'Paciente');
ii. ('pac (ii)', '2024-08-28', 70, 50, 70, 'Controle');
iii. ('pac (iii)', '2024-08-28', 50, 70, 70, 'Controle').
*/


INSERT INTO tb_exames 
VALUES 
('pac (i)', '2024-08-28', 70, 70, 50, 'Paciente'),
('pac (ii)', '2024-08-28', 70, 50, 70, 'Controle'),
('pac (iii)', '2024-08-28', 50, 70, 70, 'Controle');

/*Exercício 6:
Quais são oS pacienteS mais próximoS do elemento inserido no Exercício 3?
*/

/* Exercício 7:
Adicione o paciente ('observação 2', '2024-08-28', 70, 70, 70, ' - ') na tabela e atribua a ele a condição doS pacienteS mais próximoS.
*/

/* Exercício 8:
(a) Adicione o paciente ('observação 3', '2024-08-28', 140, 70, 70, 'Controle');

(b) Crie duas tabelas tb_controle e tb_paciente com a mesma estrutura da tabela tb_exames exceto pela coluna 'condicao'. 
Uma dedicada a armazenar uma cópia dos registros dos indivíduos saudáveis ('Controle') e outra para os indivíduos 
afetados ('Paciente'). Nestas duas tabelas, acrescente a coluna 'razao' que armazena a razao entre colesterol total e triglicerídios 
dada pela fórmula: colesterol_total / (5 * (colesterol_total - HDL - LDL)).
*/