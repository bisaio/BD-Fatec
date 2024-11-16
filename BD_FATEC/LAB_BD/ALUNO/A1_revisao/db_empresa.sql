CREATE DATABASE db_empresa;
USE db_empresa;

DROP TABLE departamento;
CREATE TABLE departamento 
(
	id   INT	     PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(50)
);

DROP TABLE funcionario;
CREATE TABLE funcionario
(
	id				 INT          PRIMARY KEY IDENTITY(1,1),
	nome			 VARCHAR(100) NOT NULL,
	salario			 FLOAT		  NOT NULL,
	data_contratacao DATE		  NOT NULL,
	id_departamento  INT,
	
	FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO
	departamento
VALUES
	('administracao'),
	('financeiro'),
	('comercial'),
	('TI')

INSERT INTO
	funcionario
VALUES
	('ronaldo', 4000.0, '2024/05/12', 1),
	('bill', 4500.0, '2024/06/13', 2),
	('giusepe camolle', 6000.0, '2024/07/14', 3),
	('oscar alho', 6500.0, '2024/08/15', 4)

SELECT * FROM departamento;
SELECT * FROM funcionario;

SELECT * FROM funcionario WHERE salario >= 6500;

SELECT SUM(salario) AS soma_salarios FROM funcionario;

SELECT COUNT(*) FROM funcionario WHERE id_departamento = 1;

SELECT 
	* 
FROM 
	funcionario
	INNER JOIN departamento
		ON funcionario.id_departamento = departamento.id
		WHERE departamento.nome = 'TI';

UPDATE funcionario SET nome = 'S.nha' + nome where id = 1

DELETE FROM funcionario WHERE id = 2

SELECT * FROM funcionario