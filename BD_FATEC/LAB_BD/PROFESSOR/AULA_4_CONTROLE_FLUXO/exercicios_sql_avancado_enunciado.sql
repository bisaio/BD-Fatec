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


/*Exercício 2:
Adicione uma coluna na tabela acima chamada "condicao" como sendo um VARCHAR(10). 

O valor associado a essa coluna deve ser:

['Controle'] no caso de todos os valores de colesteróis estarem dentro das faixas consideradas saudáveis; ou

['Paciente'] no caso contrário.
*/

/*Exercício 3:
(a) Delete Aleatoriamente um paciente com id entre 2 e 99.
(b) Qual é o paciente com colesteróis mais semelhantes ao paciente ('observação', '2024-08-28', 50, 50, 50, ' - ')?
Dica 1: Considere os três colesteróis ao mesmo tempo ao conduzir as comparações. 
Dica 2: Distância euclidiana (raiz da soma das diferenças quadráticas).
*/


/*Exercício 4:
Adicione o paciente ('observação', '2024-08-28', 50, 50, 50, ' - ') na tabela e atribua a ele a condição do paciente mais próximo.
*/


/*Exercício 5:
Adicione os seguintes pacientes à tabela:
i. ('pac (i)', '2024-08-28', 70, 70, 50, 'Paciente');
ii. ('pac (ii)', '2024-08-28', 70, 50, 70, 'Controle');
iii. ('pac (iii)', '2024-08-28', 50, 70, 70, 'Controle').
*/


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