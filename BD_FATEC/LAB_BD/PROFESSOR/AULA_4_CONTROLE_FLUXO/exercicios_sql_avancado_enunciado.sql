/*Considere a tabela gerada abaixo no banco bd_exames para solucionar os pr�ximos exerc�cios.*/
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
	id			INT PRIMARY KEY IDENTITY(1,1),   -- Identificador �nico do paciente
	nome		VARCHAR(100),                    -- Nome completo do paciente
	data_exame	DATE,                            -- Data em que o exame foi realizado

	colesterol_total DECIMAL(7,2),           -- Colesterol Total
	-- Limite Normal: Menos de 200 mg/dL ([0,200])

	LDL DECIMAL(7,2),                        -- Lipoprote�na de Baixa Densidade
	-- Limite Normal: Menos de 100 mg/dL ([0,100])

	HDL DECIMAL(7,2)                         -- Lipoprote�na de Alta Densidade
	-- Limite Normal: Mais de 60 mg/dL ([0,60])
);

/*Exerc�cio 1:
Adicione 100 registros aleat�rios na tabela acima considerando os seguintes requisitos:

(a) O nome do paciente deve ser uma string aleat�ria de 10 caracteres. Dica: use NEWID(.).

(b) A data a ser gerada deve ser qualquer data v�lida diferente de 29 de fevereiro de qualquer ano entre 1990 e 2024.
Se a data gerada n�o for v�lida, esta deve ser projetada para a data v�lida mais pr�xima.

(c) Os colester�is devem ser gerados no intervalo [0,300].
*/


/*Exerc�cio 2:
Adicione uma coluna na tabela acima chamada "condicao" como sendo um VARCHAR(10). 

O valor associado a essa coluna deve ser:

['Controle'] no caso de todos os valores de colester�is estarem dentro das faixas consideradas saud�veis; ou

['Paciente'] no caso contr�rio.
*/

/*Exerc�cio 3:
(a) Delete Aleatoriamente um paciente com id entre 2 e 99.
(b) Qual � o paciente com colester�is mais semelhantes ao paciente ('observa��o', '2024-08-28', 50, 50, 50, ' - ')?
Dica 1: Considere os tr�s colester�is ao mesmo tempo ao conduzir as compara��es. 
Dica 2: Dist�ncia euclidiana (raiz da soma das diferen�as quadr�ticas).
*/


/*Exerc�cio 4:
Adicione o paciente ('observa��o', '2024-08-28', 50, 50, 50, ' - ') na tabela e atribua a ele a condi��o do paciente mais pr�ximo.
*/


/*Exerc�cio 5:
Adicione os seguintes pacientes � tabela:
i. ('pac (i)', '2024-08-28', 70, 70, 50, 'Paciente');
ii. ('pac (ii)', '2024-08-28', 70, 50, 70, 'Controle');
iii. ('pac (iii)', '2024-08-28', 50, 70, 70, 'Controle').
*/


/*Exerc�cio 6:
Quais s�o oS pacienteS mais pr�ximoS do elemento inserido no Exerc�cio 3?
*/

/* Exerc�cio 7:
Adicione o paciente ('observa��o 2', '2024-08-28', 70, 70, 70, ' - ') na tabela e atribua a ele a condi��o doS pacienteS mais pr�ximoS.
*/

/* Exerc�cio 8:
(a) Adicione o paciente ('observa��o 3', '2024-08-28', 140, 70, 70, 'Controle');

(b) Crie duas tabelas tb_controle e tb_paciente com a mesma estrutura da tabela tb_exames exceto pela coluna 'condicao'. 
Uma dedicada a armazenar uma c�pia dos registros dos indiv�duos saud�veis ('Controle') e outra para os indiv�duos 
afetados ('Paciente'). Nestas duas tabelas, acrescente a coluna 'razao' que armazena a razao entre colesterol total e triglicer�dios 
dada pela f�rmula: colesterol_total / (5 * (colesterol_total - HDL - LDL)).
*/