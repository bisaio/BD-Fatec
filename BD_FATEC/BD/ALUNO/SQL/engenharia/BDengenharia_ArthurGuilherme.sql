-----------------------------------------------------------------------------------
-- FACULDADE DE TECNOLOGIA DE SÃO JOSÉ DO RIO PRETO - FATEC RIO PRETO
-- CURSO: Tecnologia em Análise e Desenvolvimento de Sistemas - ADS
-- DISCIPLINA: Banco de Dados
-- PROFa.: Valéria Maria Volpe
-- ALUNO 1: Arthur Marena
-- ALUNO 2: Guilherme Bisaio
-- DATA DA ENTREGA:	28 de abril de 2024
-----------------------------------------------------------------------------------

CREATE DATABASE engenharia;
GO

USE engenharia;
GO

CREATE TABLE departamento
(
	id		 INT		  NOT NULL PRIMARY KEY IDENTITY,
	nome	 VARCHAR(45)  NOT NULL,
	local	 VARCHAR(100) NOT NULL,
	telefone VARCHAR(15)  NOT NULL
);
GO

CREATE TABLE funcionario
(
	id		  INT			NOT NULL PRIMARY KEY IDENTITY,
	nome	  VARCHAR(45)   NOT NULL,
	cpf		  VARCHAR(14)   NOT NULL UNIQUE,
	data_nasc DATE	        NOT NULL,
	status    BIT DEFAULT 1 NOT NULL, --criando status booleano
);
GO

CREATE TABLE tecnico
(
	id_funcionario INT    NOT NULL PRIMARY KEY,
	valor_hora     MONEY  NOT NULL CHECK (valor_hora >= 0),
	salario        MONEY  NOT NULL,

	FOREIGN KEY (id_funcionario) REFERENCES funcionario (id)
);
GO

CREATE TABLE engenheiro
(
	id_funcionario  INT           NOT NULL PRIMARY KEY,
	especialidade   VARCHAR(100)  NOT NULL,
	anos_exp        INT			  NOT NULL,
	classificacao   INT			  NOT NULL,
	id_departamento INT 	      NOT NULL,

	CHECK (classificacao IN (1,2,3)),
	CHECK (anos_exp > 0),

	FOREIGN KEY (id_funcionario)  REFERENCES funcionario  (id),
	FOREIGN KEY (id_departamento) REFERENCES departamento (id)
);
GO

CREATE TABLE dependente
(
	id			   INT		   NOT NULL PRIMARY KEY IDENTITY,
	nome	       VARCHAR(45) NOT NULL,
	idade	       INT		   NOT NULL,
	parentesco     VARCHAR(20) NOT NULL,
	--chave estrangeira
	id_funcionario INT         NOT NULL REFERENCES funcionario(id)
);
GO

CREATE TABLE projeto
(
	id				INT			 NOT NULL PRIMARY KEY IDENTITY,
	nome	        VARCHAR(100) NOT NULL,
	local	        VARCHAR(100) NOT NULL,
	orcamento       MONEY	     NOT NULL,
	--chave estrangeira
	id_departamento INT			 NOT NULL REFERENCES departamento(id) 
);
GO

CREATE TABLE tecnico_projeto
(
	id_tecnico  INT  NOT NULL,
	id_projeto  INT  NOT NULL,
	qtd_horas   INT      NULL,
	data_inicio DATE     NULL,
	data_fim    DATE     NULL,
	--chave primaria composta
	PRIMARY KEY(id_tecnico, id_projeto),
	--chaves estrangeiras
	FOREIGN KEY (id_tecnico) REFERENCES tecnico (id_funcionario),
	FOREIGN KEY (id_projeto) REFERENCES projeto (id),
	--restricoes
	CHECK(qtd_horas > 0),
	CHECK(data_inicio <= data_fim)
);
GO

CREATE TABLE engenheiro_projeto
(
	id_engenheiro INT  NOT NULL,
	id_projeto    INT  NOT NULL,
	qtd_horas     INT      NULL,
	--chave primaria composta
	PRIMARY KEY (id_engenheiro, id_projeto),
	--chaves estrangeiras
	FOREIGN KEY (id_engenheiro) REFERENCES engenheiro (id_funcionario),
	FOREIGN KEY (id_projeto)    REFERENCES projeto    (id),
	--restricoes
	CHECK(qtd_horas>0)
);
GO



-----------------------------------------------
-- INSERTS / TAREFA
----------------------------------------------
-- Cadastrar
--   5 departamentos
--  15 funcionarios - sendo 5 engenheiros e 10 tecnicos
--   8 projetos - relacione os projetos com tecnicos e engenheiros

-- Cadastre dependentes nsas seguintes condições: funcionario com um dependente,
-- funcionario com dois dependentes, pelo menos um funcionario sem dependente
-----------------------------------------------

--departamento
INSERT INTO departamento (nome, local, telefone)
VALUES ('Eletrico','Rua Zakalski Marena','17 99111-1111'),
       ('Civil','Rua Pereira David','17 99222-2222'),
       ('Ambiental','Rua Andrade Nakamoto','17 99333-3333'),
       ('Fisico','Rua Fontolan Piani','17 99444-4444'),
       ('Software','Rua Domingos Maccimo','17 99555-5555')       
GO

--funcionario
INSERT INTO funcionario(nome, cpf, data_nasc, status)
VALUES ('Arthur', '111.111.111-11', '2001-01-01', 1),
       ('Daniel', '222.222.222-22', '2002-02-02', 1),
       ('Francisco', '333.333.333-33', '2003-03-03', 1),
       ('Guilherme', '444.444.444-44', '2004-04-04', 1),
       ('Heitor', '555.555.555-55', '2005-05-05', 0),
       ('Hugo', '666.666.666-66', '2006-06-06', 1),       
       ('Isaque', '777.777.777-77', '2007-07-07', 1),
       ('Saud', '888.888.888-88', '2008-08-08', 1),
       ('Ana Helena', '999.999.999-99', '2009-09-09', 1),
       ('Ricardo', '101.010.101-01', '2010-10-10', 1),
       ('Bill', '110.110.110-11', '2011-11-11', 1),
       ('Iran', '120.120.120-12', '2012-12-12', 1),
       ('Walter', '130.130.130-13', '2013-12-13', 1),
       ('Zion', '140.140.140-14', '2014-12-14', 0),
       ('Claudio', '150.150.150-15', '2015-12-15', 1)
GO

--tecnico
INSERT INTO tecnico(id_funcionario, valor_hora, salario)
VALUES (1, 50.00, 3000.00),
       (2, 100.00, 3500.00),
       (3, 150.00, 4000.00),
       (4, 200.00, 4500.00),
       (5, 250.00, 5000.00),
       (6, 50.00, 5500.00),
       (7, 100.00, 6000.00),
       (8, 150.00, 6500.00),
       (9, 200.00, 7000.00),
       (10, 250.00, 7500.00) 
GO

--engenheiro
INSERT INTO engenheiro(id_funcionario, especialidade, anos_exp, classificacao, id_departamento)
VALUES (11, 'Torres de energia', 4, 1, 1),
       (12, 'Trabalhos prediais', 6, 2, 2),
       (13, 'Planejamento urbano sustentável', 8, 3, 3),
       (14, 'Fisica nuclear', 10, 2, 4),
       (15, 'PHP e Java', 12, 1, 5)
GO

--dependente
INSERT INTO dependente(nome, idade, parentesco, id_funcionario)
VALUES ('Marena Jr', 10, 'filho', 1),
       ('Danilinho', 7, 'irmão', 2),
       ('Nagamoto II', 11, 'filho', 3),
       ('Silvia', 50, 'mãe', 4),
       ('Luciana', 47, 'madrasta', 5),
       ('Charlie Brown', 3, 'cachorro', 6),
       ('Ozzy Osbourne', 9, 'gato', 6),
       ('Kurt Cobain', 27, 'irmão', 7), 
       ('James Hetfield', 60, 'pai', 8), 
       ('Axel Rose', 62, 'vô', 9), 
       ('Thom Yorke', 55, 'tio', 10), 
       ('Dave Mustaine', 62, 'vô', 10), 
       ('Lionel Messi', 36, 'primo', 12) 
GO

--projeto
INSERT INTO projeto(nome, local, orcamento, id_departamento)
VALUES ('Instlação eletrica em prédio comercial', 'Rua Xesqueletricidade, 750', 15000.00, 1),
       ('Construção de prédio comercial coworking', 'Rua Workinelson, 1500', 20000.00, 2),
       ('Construção de casa sustentavel', 'Rua Sustentabilijhonson, 1580', 20000.00, 3),
       ('Manutenção de reator nuclear - Angra I', 'Rod. Gov. Mário Covas, Km 522', 25000.00, 4),
       ('Sistema de busca', 'Avenida Google dos Santos, 1774', 30000.00, 5),
       ('Pesquisa de nova particula BaskRan', 'Rod. Randolino Bascoto, Km 41', 35000.00, 4),
       ('Manutenção de parque ecologico', 'Rua Beregnight, 300', 40000.00, 3),
       ('Contrutação da Torre de Babel', 'Rua Paraiso, 33', 45000.00, 2)
GO

--tecnico_projeto
INSERT INTO tecnico_projeto(id_tecnico, id_projeto, qtd_horas, data_inicio, data_fim)
VALUES (1, 1, 10, '2024-04-01', '2024-04-10'),
       (2, 2, 25, '2024-04-10', '2024-05-01'),
       (3, 3, 50, '2024-04-20', '2024-05-05'),
       (4, 4, 30, '2024-04-25', '2024-05-10'),
       (6, 5, 40, '2024-04-30', '2024-05-15'),
       (7, 6, 60, '2024-05-01', '2024-05-20'),
       (8, 7, 50, '2024-05-05', '2024-05-25'),
       (9, 8, 5000, '2024-01-01', '2024-07-28'),
       (9, 1, 10, '2024-04-01', '2024-04-10'),
       (10, 2, 25, '2024-04-10', '2024-05-01') 
GO

--engenheiro_projeto
INSERT INTO engenheiro_projeto(id_engenheiro, id_projeto, qtd_horas)
VALUES (11, 1, 10),
       (12, 2, 25),
       (13, 3, 50),
       (14, 4, 30),
       (15, 5, 40),
       (14, 6, 60),
       (13, 7, 50),
       (12, 8, 5000) 
GO

-----------------------------------------------------------------------------------
-- SELECT
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- 1) Consultar todos os funcionáios que são técnicos
-----------------------------------------------------------------------------------
SELECT * FROM funcionario, tecnico WHERE funcionario.id = tecnico.id_funcionario 
GO

-----------------------------------------------------------------------------------
-- 2) Consultar todos os engenheiros e os departamentos que eles trabalham
-----------------------------------------------------------------------------------
SELECT 
	funcionario.nome, 
	engenheiro.*, 
	departamento.nome [nome departamento] 
FROM 
	funcionario, 
	engenheiro, 
	departamento 
WHERE 
	funcionario.id = engenheiro.id_funcionario 
    AND engenheiro.id_departamento = departamento.id
GO

-----------------------------------------------------------------------------------
-- 3) Consultar todos os projetos do departamento 3
-----------------------------------------------------------------------------------
SELECT 
	projeto.* 
FROM 
	projeto, 
	departamento 
WHERE 
	projeto.id_departamento = 3 
	AND projeto.id_departamento = departamento.id
GO

-----------------------------------------------------------------------------------
-- 4) Consultar todos os projetos de cada departamento
-----------------------------------------------------------------------------------
SELECT 
	projeto.* 
FROM 
	projeto, 
	departamento 
WHERE 
	projeto.id_departamento = departamento.id 
ORDER BY
	projeto.id_departamento
GO

-----------------------------------------------------------------------------------
-- 5) Consultar projetos com orçamento maior que um milhão (adapte o valor aos seus 
-- cadastros dos projetos) - USAMOS MAIOR QUE 30000
-----------------------------------------------------------------------------------
SELECT 
	* 
FROM 
	projeto
WHERE 
	projeto.orcamento > 30000
GO

-----------------------------------------------------------------------------------
-- 6) Consultar todos os engenheiros e quais projetos ele gerencia
-----------------------------------------------------------------------------------
SELECT
	funcionario.nome,
	engenheiro.*,
	projeto.*
FROM
	funcionario,
	engenheiro,
	projeto,
	engenheiro_projeto
WHERE
	funcionario.id = engenheiro.id_funcionario
	AND engenheiro.id_funcionario = engenheiro_projeto.id_engenheiro
	AND projeto.id = engenheiro_projeto.id_projeto 
ORDER BY
	funcionario.id
GO

-----------------------------------------------------------------------------------
-- 7) Consultar os dependentes dos técnicos
-----------------------------------------------------------------------------------
SELECT
	funcionario.nome responsavel,
	dependente.*
FROM
	dependente,
	funcionario,
	tecnico
WHERE
	funcionario.id = tecnico.id_funcionario
	AND dependente.id_funcionario = tecnico.id_funcionario
GO

-----------------------------------------------------------------------------------
-- 8) Consultar os técnicos seus projetos e quais engenheiros gerenciam esses projetos
-----------------------------------------------------------------------------------
SELECT
	funcionario_tecnico.nome AS tecnico,
	projeto.*,
	funcionario_engenheiro.nome AS engenheiro
FROM
	tecnico, 
	funcionario AS funcionario_tecnico,
	engenheiro,
	funcionario AS funcionario_engenheiro,
	projeto,
	engenheiro_projeto,
	tecnico_projeto
WHERE	
	tecnico.id_funcionario = funcionario_tecnico.id
	AND engenheiro.id_funcionario = funcionario_engenheiro.id
	AND tecnico.id_funcionario = tecnico_projeto.id_tecnico
	AND engenheiro_projeto.id_projeto = tecnico_projeto.id_projeto
	AND engenheiro.id_funcionario = engenheiro_projeto.id_engenheiro
	AND projeto.id = tecnico_projeto.id_projeto
ORDER BY
	funcionario_tecnico.nome
GO

-----------------------------------------------------------------------------------
-- 9) Consultar engenheiros e seus dependentes
-----------------------------------------------------------------------------------
SELECT
	funcionario.nome AS engenheiro,
	engenheiro.*,
	dependente.nome AS dependente
FROM
	funcionario,
	engenheiro,
	dependente
WHERE
	funcionario.id = engenheiro.id_funcionario
	AND dependente.id_funcionario = engenheiro.id_funcionario
GO

-----------------------------------------------------------------------------------
-- 10) Consultar Funcionarios que não tem dependentes 
-----------------------------------------------------------------------------------
SELECT
	funcionario.*
FROM
	funcionario
WHERE 
	NOT EXISTS 
		(
			SELECT 
				1
			FROM 
				dependente
			WHERE
				dependente.id_funcionario = funcionario.id
		)
GO