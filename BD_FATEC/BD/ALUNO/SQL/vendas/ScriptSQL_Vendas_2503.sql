-----------------------------------------------------------------------------------
-- CRIAÇÃO DO BANCO DE DADOS
-----------------------------------------------------------------------------------
CREATE DATABASE Vendas_ADSBD;
GO

-----------------------------------------------------------------------------------
-- ACESSO AO BANCO DE DADOS
-----------------------------------------------------------------------------------
USE Vendas_ADSBD;
GO

-----------------------------------------------------------------------------------
-- CRIAR A TABELA PESSOAS
-----------------------------------------------------------------------------------
CREATE TABLE pessoa
(
	id	INT	    NOT NULL PRIMARY KEY IDENTITY, -- autoincremento
	nome	VARCHAR(50) NOT NULL,
	cpf	VARCHAR(14) NOT NULL UNIQUE,
	status	INT		NULL,
	--restricao
	CHECK(status IN (1,2)) 
);
GO

-----------------------------------------------------------------------------------
-- CRIAR A TABELA CLIENTES
-----------------------------------------------------------------------------------
CREATE TABLE cliente
(
	pessoaId	INT	      NOT NULL PRIMARY KEY,
	renda		DECIMAL(10,2) NOT NULL,
	credito		DECIMAL(10,2) NOT NULL
	--definir a chave estrangeira (FK)
	FOREIGN KEY (pessoaId) REFERENCES pessoa (id), 
	--restricoes
	CHECK(renda >= 700.00),
	CHECK(credito >= 100.00)
);
GO

-----------------------------------------------------------------------------------
-- CRIAR A TABELA VENDEDOR
-----------------------------------------------------------------------------------
CREATE TABLE vendedor
(
	pessoaId	INT	      NOT NULL PRIMARY KEY,
	salario		DECIMAL(10,2) NOT NULL
	--definir a chave estrangeira (FK)
	FOREIGN KEY (pessoaId) REFERENCES pessoa (id), 
	--restricoes
	CHECK(salario >= 1000.00),
);
GO

-----------------------------------------------------------------------------------
-- CRIAR A TABELA PEDIDOS
-----------------------------------------------------------------------------------
CREATE TABLE pedido
(
	id		   INT		NOT NULL PRIMARY KEY IDENTITY,
	data	   DATETIME NOT NULL,
	valor	   MONEY		NULL,
	status	   INT			NULL CHECK (status IN (1,2,3)),
	vendedorId INT		NOT NULL,
	clienteId  INT		NOT NULL,
	--definir a chave estrangeira (FK)
	FOREIGN KEY (vendedorId) REFERENCES vendedor (pessoaId), 
	FOREIGN KEY (clienteId)  REFERENCES cliente  (pessoaId),
);
GO

-----------------------------------------------------------------------------------
-- CRIAR A TABELA PRODUTOS
-----------------------------------------------------------------------------------
CREATE TABLE produto
(
	id	   INT		NOT NULL PRIMARY KEY IDENTITY,
	descricao  VARCHAR(100) NOT NULL,
	qtd	   INT		    NULL CHECK (qtd >= 0),
	valor	   MONEY	    NULL CHECK (valor > 0),
	status	   INT		    NULL CHECK (status IN (1,2)),
);
GO

-----------------------------------------------------------------------------------
-- CRIAR A TABELA ITENS_PEDIDOS
-----------------------------------------------------------------------------------
CREATE TABLE itens_pedido
(
	pedidoId  INT		 NOT NULL,
	produtoId INT		 NOT NULL,
	qtd	  INT		     NULL,
	valor	  DECIMAL (10,2)     NULL,
	--definir a chave primaria composta
	PRIMARY KEY(pedidoId, produtoId),
	--definir as chaves estrangeiras
	FOREIGN KEY(pedidoId)  REFERENCES pedido (id),
	FOREIGN KEY(produtoId) REFERENCES produto(id),
	--restricoes
	CHECK (qtd > 0),
	CHECK (valor > 0)
);
GO




-----------------------------------------------------------------------------------
-- CONSULTAR TODAS AS TABELAS
-----------------------------------------------------------------------------------
SELECT * FROM pessoa;
GO
SELECT * FROM cliente;
GO
SELECT * FROM vendedor;
GO
SELECT * FROM pedido;
GO
SELECT * FROM itens_pedido;
GO





-----------------------------------------------------------------------------------
-- CRUD - CREAT - INSERT
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- INSERT TABELA PESSOAS
-----------------------------------------------------------------------------------
INSERT INTO pessoa (nome, cpf, status) VALUES ('Dom Pedro I','111.111.111-11', 1);
GO

INSERT INTO pessoa VALUES ('Donna Valeria II','222.222.222-22', 2);
GO

INSERT INTO pessoa (nome, cpf) VALUES ('Don Juan III','333.333.333-33') -- sem cadastrar status pq aceita null
GO

INSERT INTO pessoa 
	(nome, cpf, status) 
VALUES 
	('Lucimar IV','444.444.444-44', 2),
	('Viana V','555.555.555-55', 1),
	('Dezani VI','666.666.666-66', 1),
	('Mariangela VII','777.777.777-77', 2),
	('Adriano VIII','888.888.888-88', null),
	('Lucimeiri IX','999.999.999-99', 1),
	('Teso X','101.010.101-01', 2);
GO

INSERT INTO  pessoa (nome, cpf) VALUES ('Ziraldo', '212-212-212-22')
GO

-----------------------------------------------------------------------------------
-- INSERT TABELA CLIENTES
-----------------------------------------------------------------------------------
INSERT INTO cliente (pessoaId, renda, credito) VALUES (1, 3000.00, 1500.00);
GO

--cadastrar varios clientes em um comando
INSERT INTO cliente (pessoaId, renda, credito) 
VALUES (3, 5000.00, 2000.00),
	   (5, 2500.00, 750.00),
	   (7, 5000.00, 3000.00),
	   (9, 2000.00, 1000.00)
GO

-----------------------------------------------------------------------------------
-- INSERT TABELA VENDEDOR
-----------------------------------------------------------------------------------
INSERT INTO vendedor (pessoaId, salario) VALUES (2, 3500.00)
GO

--cadastrar varios vendedores em um comando sem especificar as colunas
INSERT INTO vendedor
VALUES (4, 2500.00),
	   (6, 3000.00),
	   (8, 1500.00),
	   (10, 2200.00)
GO

-----------------------------------------------------------------------------------
-- INSERT TABELA PRODUTOS
-----------------------------------------------------------------------------------
INSERT INTO produto (descricao, qtd, valor, status) 
VALUES ('Coca-Cola', 150, 5.50, 1)
GO

--status nulo
INSERT INTO produto (descricao, qtd, valor)
VALUES ('Bolo de chocolate', 25, 30.00)
GO

--cadastrar varios produtos em um comando
INSERT INTO produto (descricao, qtd, valor, status)
VALUES ('Lanche natural', 250, 15.00, 1),
	   ('Bombom de chocolate com castanha', 100, 10, 1),
	   ('Bala baiana', 150, 3.50, 2),
	   ('Rosquinha espera marido', 200, 1.50, 1),
	   ('Chocolate ao leite', 50, 8.59, 2),
	   ('Sorvete de chocolate', 15, 10.00, 1),
	   ('Bolo de fubá', 5, 18.90, 1),
	   ('Coxinha de frango', 20, 7.50, 1),
	   ('Cotuba', 250, 7.89, 2)
GO

-----------------------------------------------------------------------------------
-- INSERT TABELA PEDIDOS
-----------------------------------------------------------------------------------
INSERT INTO pedido (data, status, vendedorId, clienteId) 
VALUES ('2023-25-10', 1, 6, 3);
GO

--cadastrar pedido com status null
INSERT INTO pedido (data, vendedorId, clienteId) 
VALUES ('2023-19-12', 4, 1);
GO

--cadastrar um pedido com a data atual
INSERT INTO pedido (data, status, vendedorId, clienteId) 
VALUES (GETDATE(), 1, 2, 5);
GO

--cadastrar varios pedidos em um comando
INSERT INTO pedido (data, status, vendedorId, clienteId) 
VALUES ('2024-03-02', 2, 8, 9),
	   (GETDATE(), 1, 8, 3)
GO

-----------------------------------------------------------------------------------
-- INSERT TABELA ITENS_PEDIDO
-----------------------------------------------------------------------------------
-- N x N
-- Pedido 1
INSERT INTO itens_pedido (pedidoId, produtoId, qtd, valor) 
VALUES (1, 2, 5, 27.50),
	   (1, 8, 1, 10.00),
	   (1, 6, 20, 1.50),
	   (1, 1, 2, 5.50)
GO

-- Pedido 2
INSERT INTO itens_pedido (pedidoId, produtoId, qtd, valor) 
VALUES (2, 4, 5, 5.99),
	   (2, 11, 50, 6.99),
	   (2, 9, 1, 18.90)
GO

-- Pedido 3
INSERT INTO itens_pedido (pedidoId, produtoId, qtd, valor) 
VALUES (3, 1, 5, 5.50),
	   (3, 11, 12, 7.89)
GO

-- Pedido 5
INSERT INTO itens_pedido (pedidoId, produtoId, qtd, valor) 
VALUES (5, 2, 5, 30.00),
	   (5, 3, 1, 15.00),
	   (5, 9, 2, 18.90)
GO


-----------------------------------------------------------------------------------
-- CRUD - READ - SELECT
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- SELECT TABELA PESSOAS
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- 1) Selecionar todas as pessoas cadastradas
-----------------------------------------------------------------------------------
--especificando as colunas da tabela
SELECT 
	pessoa.id, 
	pessoa.nome, 
	pessoa.cpf, 
	pessoa.status 
FROM 
	pessoa
GO

--usando * que representa todas as colunas
SELECT * FROM pessoa
GO

-----------------------------------------------------------------------------------
-- 2) Selecionar todos os Produtos com valor maior ou igual a 5
-----------------------------------------------------------------------------------
SELECT * FROM produto WHERE valor >= 5.00
GO

-----------------------------------------------------------------------------------
-- 3) Selecionar todos os Produtos com valor maior ou igual a 5 ou status igual a 2
-----------------------------------------------------------------------------------
SELECT * FROM produto 
WHERE status = 2 OR valor >= 5.00
GO

-----------------------------------------------------------------------------------
-- 4) Selecionar todos os Produtos com descricao chocolate ao leite
-----------------------------------------------------------------------------------
SELECT * FROM produto WHERE descricao = 'chocolate ao leite'
GO

-----------------------------------------------------------------------------------
-- 5) Selecionar todos os Produtos cuja descricao tenha a letra A
-----------------------------------------------------------------------------------
SELECT * FROM produto WHERE descricao LIKE '%a%' --LIKE só funciona com varchar
GO

-----------------------------------------------------------------------------------
-- 6) Selecionar todos os Produtos cuja descricao tenha a silaba CO no inicio
-----------------------------------------------------------------------------------
SELECT * FROM produto WHERE descricao LIKE 'co%'
GO

-----------------------------------------------------------------------------------
-- 7) Selecionar todos os Produtos cuja descricao termine com a letra O
-----------------------------------------------------------------------------------
SELECT * FROM produto WHERE descricao LIKE '%o'
GO

-----------------------------------------------------------------------------------
-- 8) Selecionar todos os Produtos cuja descricao inicie com qualquer letra,
-- a segunda letra seja O, a terceira letra seja qualquer uma,
-- a quarta letra seja O e as demais podem ser qualquer coisa
-----------------------------------------------------------------------------------
SELECT * FROM produto WHERE descricao LIKE '_o_o%'
GO

-----------------------------------------------------------------------------------
-- 9) Selecionar todos os Produtos com valor entre 3 e 17
-----------------------------------------------------------------------------------
--usando between
SELECT * FROM produto 
WHERE valor BETWEEN 3.00 AND 17.00
GO

--usando operadores
SELECT 
	produto.* 
FROM 
	produto 
WHERE
	produto.valor >= 3.00 
	AND produto.valor <= 17.00
GO