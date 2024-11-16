CREATE DATABASE legal;
USE legal;

CREATE TABLE tb_funcionario
(
	id		  INT PRIMARY KEY IDENTITY(1,1),
	nome	  VARCHAR(MAX),
	salario   FLOAT,
	data_cont DATE
)

DECLARE @nome VARCHAR(10) = LEFT(NEWID(), 10);
PRINT(@nome)

DECLARE @salario FLOAT = RAND()*(2000 - 1500) + 1500
print(@salario)

DECLARE @data_cont DATE = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1460), '2020-01-01')
PRINT(@data_cont)

INSERT INTO
	tb_funcionario
VALUES
	(@nome, @salario, @data_cont)

SELECT * FROM tb_funcionario