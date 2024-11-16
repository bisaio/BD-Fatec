USE master
GO

DROP DATABASE TiposJoin_DB
GO

CREATE DATABASE TiposJoin_DB
GO

USE TiposJoin_DB

CREATE TABLE departamento
(
	id		  INT          NOT NULL PRIMARY KEY IDENTITY,
	nome	  VARCHAR(20)  NOT NULL,
	descricao VARCHAR(100) NOT NULL
)
GO

CREATE TABLE funcionario
(
	id		        INT         NOT NULL PRIMARY KEY IDENTITY,
	nome	        VARCHAR(50) NOT NULL,
	cpf		        VARCHAR(14) NOT NULL UNIQUE,
	cargo	        VARCHAR(20) NOT NULL,
	status	        INT 		    NULL CHECK(STATUS IN (1,2)),
	id_departamento INT			    NULL,

	FOREIGN KEY (id_departamento) REFERENCES departamento(id)
)
GO

INSERT INTO 
	departamento 
		(
			nome, 
			descricao
		)
	VALUES
		(
			'Compras', 
			'Compras de suprimentos'
		),
		(
			'Recursos Humanos', 
			'Controle e capacitacao dos Funcionarios'
		),
		(
			'Vendas', 
			'Controle das vendas de produtos'
		),
		(
			'Logistica', 
			'Controle das entregas dos produtos'
		),
		(
			'Diretoria', 
			'Gestao Geral - Diretor'
		)

SELECT * FROM departamento
GO

---------------------------------------------------------------------------------------------
-- Inserir funcionarios relacionados a departamentos
---------------------------------------------------------------------------------------------

INSERT INTO 
	funcionario 
		(
			nome, 
			cpf,
			cargo,
			status,
			id_departamento
		)
	VALUES
		(
			'Joao da Silva', 
			'111.111.111-11',
			'Gerente',
			1,
			1
		),
		(
			'Jose de Souza', 
			'222.222.222-22',
			'Auxiliar',
			1,
			1
		),
		(
			'Ana Maria', 
			'333.333.333-33',
			'Gerente',
			1,
			3
		),
		(
			'Pedro Augusto', 
			'444.444.444-44',
			'Vendedor',
			1,
			3
		),
		(
			'Miguel Augusto', 
			'555.555.555-55',
			'Vendedor',
			1,
			3
		),
		(
			'Julio Cesar', 
			'666.666.666-66',
			'Auxiliar de Vendas',
			1,
			3
		),
		(
			'Maria Rosa', 
			'777.777.777-77',
			'Psicologa',
			1,
			2
		),
		(
			'Vanessa Cristina', 
			'888.888.888-88',
			'Escrevente',
			1,
			2
		)

SELECT departamento.*, funcionario.* 
FROM departamento INNER JOIN
	 funcionario ON departamento.id = funcionario.id_departamento
GO

---------------------------------------------------------------------------------------------
-- Inserir funcionarios NÃO relacionados a departamentos
---------------------------------------------------------------------------------------------
INSERT INTO funcionario (nome, cpf, cargo, status)
VALUES ('Joao Carlos de Souza', '211.111.111-11', 'Gerente', 1),
	   ('Jose Antonio de Souza', '322.222.222-22', 'Auxiliar de compras', 1),
	   ('Ana Maria Vieira', '002.333.333-33', 'Servicos Extras', 1),
	   ('Pedro Augusto Volpe', '123.444.444-44', 'Vendedor Externo', 1),
	   ('Miguel Augusto Volpe', '574.555.444-55', 'Vendedor Internor', 1),
	   ('Julio Cesar Volpe', '658.666.666-66', 'Diretor', 1)
GO

SELECT * FROM funcionario

---------------------------------------------------------------------------------------------
-- INNER JOIN
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- 1.	Consultar todos os departamentos e seus funcionarios
---------------------------------------------------------------------------------------------
SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	INNER JOIN funcionario
		ON departamento.id = funcionario.id_departamento
GO

---------------------------------------------------------------------------------------------
-- LEFT JOIN
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- 2.	Consultar todos os departamentos e funcionarios
---------------------------------------------------------------------------------------------
SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	LEFT JOIN funcionario
		ON departamento.id = funcionario.id_departamento
GO

---------------------------------------------------------------------------------------------
-- RIGHT JOIN
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- 3.	Consultar todos os funcionarios e departamentos
---------------------------------------------------------------------------------------------

SELECT
	funcionario.id,
	funcionario.nome,
	funcionario.cargo,
	departamento.id,
	departamento.nome,
	departamento.descricao
FROM
	funcionario
	RIGHT JOIN departamento
		ON funcionario.id_departamento = departamento.id  
GO

---------------------------------------------------------------------------------------------
-- 3.1	Consultar departamentos e todos os funcionarios (RIGHT JOIN CERTO por conta da mudança do null id_departamento funcionario)
---------------------------------------------------------------------------------------------

SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	RIGHT JOIN funcionario
		ON departamento.id = funcionario.id_departamento
GO

---------------------------------------------------------------------------------------------
-- FULL OUTER JOIN
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- 4.	Consultar todos os funcionarios e departamentos
---------------------------------------------------------------------------------------------

SELECT
	funcionario.id,
	funcionario.nome,
	funcionario.cargo,
	departamento.id,
	departamento.nome,
	departamento.descricao
FROM
	funcionario
	FULL OUTER JOIN departamento
		ON funcionario.id_departamento = departamento.id  
GO

SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	FULL OUTER JOIN funcionario
		ON departamento.id = funcionario.id_departamento
GO

---------------------------------------------------------------------------------------------
-- 4.1	Consultar todos os departamentos e funcionarios
---------------------------------------------------------------------------------------------

SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	FULL OUTER JOIN funcionario
		ON departamento.id = funcionario.id_departamento  
GO

---------------------------------------------------------------------------------------------
-- CROSS JOIN
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- 5.	Consultar todos os funcionarios e departamentos
---------------------------------------------------------------------------------------------

SELECT
	funcionario.id,
	funcionario.nome,
	funcionario.cargo,
	departamento.id,
	departamento.nome,
	departamento.descricao
FROM
	funcionario
	CROSS JOIN departamento
GO

SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	CROSS JOIN funcionario
GO

---------------------------------------------------------------------------------------------
-- 5.1	Consultar todos os departamentos e os funcionarios (feito em aula)
---------------------------------------------------------------------------------------------

SELECT
	departamento.id,
	departamento.nome,
	departamento.descricao,
	funcionario.id,
	funcionario.nome,
	funcionario.cargo
FROM
	departamento
	CROSS JOIN funcionario
GO

SELECT
	funcionario.id,
	funcionario.nome,
	funcionario.cargo,
	departamento.id,
	departamento.nome,
	departamento.descricao
FROM
	funcionario
	CROSS JOIN departamento
GO

---------------------------------------------------------------------------------------------
-- DISTINCT
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-- Consultar os cargos ocupados pelos funcionarios
-- Consultar todos os crgos dos funcionarios e traz o cargos de cada funcionario
---------------------------------------------------------------------------------------------

SELECT funcionario.cargo FROM funcionario
GO


---------------------------------------------------------------------------------------------
-- Consultar os cargos de funcionarios cadastrados
-- Consultar todos os cargos que tem pelo menos um funcionario relacionado
-- traz apenas os cargos sem repetições
---------------------------------------------------------------------------------------------
SELECT DISTINCT funcionario.cargo FROM funcionario
GO