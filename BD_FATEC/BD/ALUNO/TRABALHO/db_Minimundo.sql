-----------------------------------------------------------------
-- FATEC - RIO PRETO - 2024-1
-- CURSO: TECNOLOGIA EM ANÁLISE E DESENVOLVIMENTO DE SISTEMAS - ADS
-- DISCIPLINA: BANCO DE DADOS
-- NOME: Arthur Marena
-- NOME: Guilherme Bisaio
-- 						ATIVIDADE 03
-- DATA: 19 de junho de 2024 - 18h 
-- Professora: Valéria Maria Volpe da Silva
-----------------------------------------------------------------

-----------------------------------------------------------------
-- criar o Banco de Dados
-----------------------------------------------------------------
CREATE DATABASE db_Minimundo
GO
-----------------------------------------------------------------
-- acessando o Banco de Dados
-----------------------------------------------------------------
USE db_Minimundo
GO

-----------------------------------------------------------------
--				ATIVIDADE 02
-----------------------------------------------------------------

-----------------------------------------------------------------
-- CRIAR AS TABELAS
-----------------------------------------------------------------
CREATE TABLE assunto
(
	id   INT	     NOT NULL IDENTITY,
	nome VARCHAR(30) NOT NULL,

	CONSTRAINT pk_assunto PRIMARY KEY (id)
) 
GO

CREATE TABLE editora
(
	id		 INT	     NOT NULL IDENTITY,
	nome	 VARCHAR(80) NOT NULL,
	telefone VARCHAR(15) NOT NULL

	CONSTRAINT pk_editora PRIMARY KEY (id)
)
GO

CREATE TABLE livro
(
	id			   INT		    NOT NULL IDENTITY,
	id_assunto	   INT		    NOT NULL,
	id_editora	   INT		    NOT NULL,
	titulo		   VARCHAR(100) NOT NULL,
	autor		   VARCHAR(100) NOT NULL,
	ISBN		   CHAR(13)	    NOT NULL,
	ano_publicacao VARCHAR(04)  NOT NULL,
	preco		   MONEY	    NOT NULL,
	qtd_estoque    INT	        NOT NULL

	CONSTRAINT pk_livro PRIMARY KEY (id),
	CONSTRAINT uk_livro_isbn UNIQUE (isbn),
	CONSTRAINT ck_livro_ano CHECK(ano_publicacao <= YEAR(GETDATE())),

	CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) REFERENCES editora (id),
	CONSTRAINT fk_livro_assunto FOREIGN KEY (id_assunto) REFERENCES assunto (id),
)
GO

CREATE TABLE cliente 
(
	id     INT			 NOT NULL IDENTITY,
	nome   VARCHAR(50)   NOT NULL,
	status INT DEFAULT 1 NOT NULL, -- 1 - Ativo, 2 - Inativo, 3 - Bloqueado,

	CONSTRAINT pk_cliente PRIMARY KEY (id),
	CONSTRAINT ck_cliente_status CHECK(status IN(1,2,3))
)
GO

CREATE TABLE cliente_telefone
(
	id_cliente INT		   NOT NULL,
	telefone   VARCHAR(45) NOT NULL

	CONSTRAINT pk_cliente_telefone PRIMARY KEY (id_cliente, telefone),
	CONSTRAINT fk_cliente_telefone_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id)
)
GO


CREATE TABLE cliente_endereco
(
	id_cliente  INT		    NOT NULL,
	cep		    VARCHAR(09) NOT NULL,
	logradouro  VARCHAR(50) NOT NULL,
	bairro	    VARCHAR(25) NOT NULL,
	numero		VARCHAR(05) NULL,
	complemento VARCHAR(20) NULL,
	
	CONSTRAINT fk_cliente_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id)
)
GO

CREATE TABLE cliente_pessoa
(
	id_cliente  INT			NOT NULL,
	dat_nasc    DATE		NOT NULL,
	cpf		    VARCHAR(14) NOT NULL,
	nome_social VARCHAR(50) NULL,

	CONSTRAINT pk_cliente_pessoa PRIMARY KEY(id_cliente),
	CONSTRAINT fk_cliente_pessoa_cliente FOREIGN KEY(id_cliente) REFERENCES cliente (id),
	CONSTRAINT uk_cliente_pessoa_cpf UNIQUE (cpf)
)
GO


CREATE TABLE cliente_empresa
(
	id_cliente    INT		  NOT NULL,
	cnpj		  VARCHAR(20) NOT NULL,
	nome_fantasia VARCHAR(50) NULL,

	CONSTRAINT pk_cliente_empresa PRIMARY KEY(id_cliente),
	CONSTRAINT fk_cliente_empresa_cliente FOREIGN KEY(id_cliente) REFERENCES cliente (id),
	CONSTRAINT uk_cliente_empresa_cnpj UNIQUE (cnpj)
)
GO

CREATE TABLE compra
(
	id           INT						NOT NULL IDENTITY,
	id_cliente   INT					    NOT NULL,
	dat_compra   DATETIME DEFAULT GETDATE() NOT NULL,
	total_compra MONEY						NULL,

	CONSTRAINT pk_compra PRIMARY KEY(id),
	CONSTRAINT fk_compra_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id)
)
GO

CREATE TABLE itens_compra
(
	id_compra	   INT	 NOT NULL,
	id_livro	   INT	 NOT NULL,
	qtd		       INT	 NOT NULL,
	preco_unitario MONEY NOT NULL,
	desconto	   MONEY	 NULL DEFAULT 0,

	CONSTRAINT pk_itens_compra PRIMARY KEY (id_compra, id_livro),
	CONSTRAINT fk_itens_compra_compra FOREIGN KEY (id_compra) REFERENCES compra (id),
	CONSTRAINT fk_itens_compra_livro FOREIGN KEY (id_livro) REFERENCES livro (id),
	CONSTRAINT fk_itens_compra_qtd CHECK (qtd >0)
)
GO


-----------------------------------------------------------------
-- Tabela: 
-----------------------------------------------------------------

-----------------------------------------------------------------
-- INSERIR DADOS NAS TABELAS
-----------------------------------------------------------------
-- TABELA ASSUNTO
----------------------------------------------------------------
INSERT INTO 
	assunto (nome) 
VALUES 
	('Romance'), 
	('Suspense'),
	('Policial'),
	('Infantil'),
	('Fantasia'),
	('Ficção Científica'),
	('Aventura'),
	('Biografia'),
	('História'),
	('Autoajuda'),
	('Tecnologia'),
	('Culinária'),
	('Saúde'),
	('Negócios'),
	('Economia'),
	('Psicologia'),
	('Filosofia'),
	('Educação'),
	('Artes'),
	('Esportes')
GO

----------------------------------------------------------------
-- TABELA EDITORA
----------------------------------------------------------------
INSERT INTO 
	editora (nome, telefone) 
VALUES 
	('Editora Alpha', '(11) 91111-1111'),
	('Editora Beta', '(21) 92222-2222'),
	('Editora La ele', '(31) 93333-3333'),
	('Editora Delta', '(41) 94444-4444'),
	('Editora Epsilon', '(51) 95555-5555'),
	('Editora do bill', '(61) 96666-6666'),
	('Editora Eta', '(71) 97777-7777'),
	('Editora livros.com', '(81) 98888-8888'),
	('Editora Iota', '(91) 99999-9999'),
	('Editora zezinho da esquina', '(12) 91010-1010'),
	('Editora Lambda', '(13) 91112-1112'),
	('Editora Muuuuuuuuuuuuu', '(14) 91212-1212'),
	('Editora Nu', '(15) 91313-1313'),
	('Editora Xiririm', '(16) 91414-1414'),
	('Editora Viana', '(17) 91515-1515'),
	('Editora Pi', '(18) 91616-1616'),
	('Editora receba', '(19) 91717-1717'),
	('Editora Sigma', '(22) 91818-1818'),
	('Editora Tau', '(23) 91919-1919'),
	('Editora Upsilon', '(24) 92020-2020')
GO

----------------------------------------------------------------
-- TABELA LIVRO
----------------------------------------------------------------
INSERT INTO
	livro 
		( 
		 id_assunto, 
		 id_editora, 
		 titulo, 
		 autor, 
		 ISBN, 
		 ano_publicacao,
		 preco, 
		 qtd_estoque
		)
VALUES
	(1, 1, 'Os sofrimentos do jovem Werther', 'Johann Wolfgang von Goethe', '9780631019008', 1774, 35.00, 10),			-- romance
	(1, 2, 'O Processo', 'Franz Kafka', '9780805210408', 1925, 33.00, 18),												-- romance
	(2, 2, 'Garota Exemplar', 'Gillian Flynn', '9780307588364', 2012, 50.00, 15),										-- suspense
	(2, 2, 'Louca Obsessão', 'Stephen King', '9781405876650', 1987, 54.44, 10),										    -- suspense
	(3, 3, 'A Sangue Frio', 'Truman Capote', '9780140026825', 1965, 42.50, 7),											-- policial
	(4, 4, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', '9783140464079', 1943, 25.00, 20),							-- infantil
	(5, 5, 'Coraline', 'Neil Gaiman', '9780060575915', 2002, 25.00, 5),												    -- fantasia
	(6, 6, '2001: Uma odisséia no espaço', 'Arthur C. Clarke', '9780090898305', 1968, 52.45, 2),						-- ficção cientifica
	(6, 7, 'Blade Runner: Androides sonham com ovelhas elétricas?', 'Philip K. Dick', '9780194230636', 1968, 55.90, 5), -- ficção cientifica
	(6, 8, 'Laranja Mecânica', 'Anthony Burgess', '9780393089134', 1962, 49.94, 7),										-- ficção cientifica
	(7, 7, 'Vinte mil léguas submarinas', 'Júlio Verne', '9780679203735', 1870, 37.99, 4),								-- aventura
	(8, 8, 'Ayrton Senna – Uma lenda a toda velocidade', 'Cristopher Hilton', '9788526013711', 2009, 250.00, 10),		-- biografia
	(9, 9, 'As Veias Abertas da América Latina', 'Eduardo Galeano', '9780853452799', 1971, 42.70, 12),					-- historia
	(10, 10, 'O cavaleiro preso na armadura', 'Robert Fisher', '9788862281836', 1987, 32.89, 3),						-- autoajuda
	(11, 11, 'Entendendo Algoritmos', 'Aditya Y. Bhargava', '9788575225639', 2017, 56.20, 25),							-- tecnologia
	(11, 12, 'Código Limpo', 'Robert Cecil Martin', '9780132350884', 2008, 88.37, 30),									-- tecnologia
	(11, 12, 'Arquitetura Limpa', 'Robert Cecil Martin', '9788550808161', 2019, 71.93, 30),								-- tecnologia
	(11, 13, 'C#: Como Programar', 'H. M. Deitel', '9788534614597', 2003, 561.75, 20),									-- tecnologia
	(12, 12, 'Le Cordon Bleu : Todas as técnicas', 'Eric Treuillé', '9788521318460', 2014, 202.43, 1),					-- culinaria
	(13, 13, 'A saúde dos planos de saúde', 'Drauzio Varella', '9788565530774', 2014, 16.90, 6),						-- saude
	(14, 14, 'A psicologia financeira', 'Morgan Housel', '9786555111101', 2021, 38.40, 4),								-- negocios
	(15, 15, 'Introdução à Economia', 'Gregory Mankiw', '9780030293238', 1997, 27.55, 8),								-- economia
	(16, 16, 'A Interpretação dos Sonhos', 'Sigmund Freud', '9780199537587', 1899, 67.25, 13),							-- psicologia
	(17, 17, 'O Mito de Sísifo', 'Albert Camus', '9780679733737', 1942, 53.64, 9),										-- filosofia
	(17, 18, 'Fenomenologia do Espírito', 'Georg Wilhelm Friedrich Hegel', '9780061313035', 1807, 134.19, 13),			-- filosofia
	(17, 19, 'O Existencialismo É um Humanismo', 'Jean-Paul Sartre', '9788435014403', 1946, 11.18, 10),					-- filosofia
	(18, 19, 'Pedagogia da Autonomia', 'Paulo Freire', '9788577531639', 1996, 39.92, 5),								-- educação
	(19, 19, 'A mise en scène no cinema', 'Luiz Carlos Oliveira Júnior', '9788530810511', 2013, 74.28, 13),				-- artes
	(19, 19, 'A odisseia do cinema brasileiro', 'Laurent Desbois', '9788535928228', 2016, 89.57, 12),					-- artes
	(20, 20, 'Onze aneis: A alma do sucesso', 'Phil Jackson', '9788499187433', 2013, 56.49, 2)							-- esporte
GO

----------------------------------------------------------------
-- TABELA CLIENTE
----------------------------------------------------------------
INSERT INTO
	cliente 
		( 
		 nome,
		 status
		)
VALUES
	('H. Romeu', 1), -- 1
	('Giuseppe Camolle', 1), -- 2
	('Oscar Alho', 1), -- 3
	('Dayde Costa', 1), -- 4
	('Déssio Pinto', 1), -- 5
	('Zeca Gado', 1), -- 6
	('Eduardo Vieira', 1), -- 7
	('Felipe Castanhari', 1), -- 8
	('João Victor', 1), -- 9
	('José Aparecido de Aguiar Viana', 1), -- 10
	('Valéria Maria Volpe', 1), -- 11
	('Padaria Pão Molhado', 1), -- 12
	('Box 5 Centro Automotivo', 1), -- 13
	('Interact', 1), -- 14
	('Aqui Tem Barbearias', 1), -- 15
	('Ito Frutas', 1), -- 16
	('Villa Calui', 1), -- 17
	('Bebidas Online', 1), -- 18
	('Donna Sorvetes', 1), -- 19
	('TechTrust', 1), -- 20
	('Ecori', 2), -- 21
	('Comercial Fagus', 3) -- 22
GO

----------------------------------------------------------------
-- TABELA CLIENTE_PESSOA
----------------------------------------------------------------
INSERT INTO
	cliente_pessoa
		( 
		 id_cliente,
		 dat_nasc,
		 cpf,
		 nome_social
		)
VALUES
	(1, '1597-1-1', '001.001.001-01', null),
	(2, '1892-4-30', '002.002.002-02', null),
	(3, '2000-10-5', '003.003.003-03', null),
	(4, '1985-7-15', '004.004.004-04', null),
	(5, '1938-8-8', '005.005.005-05', null),
	(6, '1911-11-11', '006.006.006-06', null),
	(7, '1991-4-11', '007.007.007-07', 'Games EduUu'),
	(8, '1989-10-20', '008.008.008-08', 'Canal Nostalgia'),
	(9, '1998-8-25', '009.009.009-09', 'Jovirone'),
	(10, '1991-4-11', '010.010.010-10', null), -- mudar data
	(11, '1991-4-11', '011.011.011-11', null) -- mudar data
GO

----------------------------------------------------------------
-- TABELA CLIENTE_EMPRESA
----------------------------------------------------------------
INSERT INTO
	cliente_empresa
		( 
		 id_cliente,
		 cnpj,
		 nome_fantasia
		)
VALUES
	(12, '12.012.012/0001-12', null),
	(13, '13.013.013/0001-13', 'Box 5 Oficina Mecanica'),
	(14, '14.014.014/0001-14', null),
	(15, '15.015.015/0001-15', null),
	(16, '16.016.016/0001-16', null),
	(17, '17.017.017/0001-17', null),
	(18, '18.018.018/0001-18', null),
	(19, '19.019.019/0001-19', null),
	(20, '20.020.020/0001-20', null),
	(21, '21.021.021/0001-21', 'Ecori Energia Solar'),
	(22, '22.022.022/0001-22', 'Eletricidade e Hidraulica Fagus')
GO

----------------------------------------------------------------
-- TABELA CLIENTE_TELEFONE
----------------------------------------------------------------
INSERT INTO
	cliente_telefone
		( 
		 id_cliente,
		 telefone
		)
VALUES
	(1, '(01) 99876-4321'),
	(2, '(02) 99876-4322'),
	(3, '(03) 99876-4323'),
	(3, '(03) 99876-4343'),
	(3, '(03) 99876-4344'),
	(4, '(04) 99876-4324'),
	(5, '(05) 99876-4325'),
	(6, '(06) 99876-4326'),
	(7, '(07) 99876-4327'),
	(7, '(07) 99876-4345'),
	(8, '(18) 99876-4328'),
	(9, '(09) 99876-4329'),
	(10, '(10) 99876-4330'),
	(11, '(11) 99876-4331'),
	(12, '(12) 99876-4332'),
	(12, '(12) 99876-4347'),
	(12, '(12) 99876-4348'),
	(13, '(13) 99876-4333'),
	(14, '(14) 99876-4334'),
	(15, '(15) 99876-4335'),
	(15, '(15) 99876-4349'),
	(15, '(15) 99876-4350'),
	(15, '(15) 99876-4351'),
	(16, '(16) 99876-4336'),
	(17, '(17) 99876-4337'),
	(18, '(18) 99876-4338'),
	(19, '(19) 99876-4339'),
	(20, '(20) 99876-4340'),
	(20, '(20) 99876-4352'),
	(21, '(21) 99876-4341'),
	(22, '(22) 99876-4342')
GO

----------------------------------------------------------------
-- TABELA CLIENTE_ENDERECO
----------------------------------------------------------------
INSERT INTO
	cliente_endereco
		( 
		 id_cliente,
		 cep,
		 logradouro,
		 bairro,
		 numero,
		 complemento
		)
VALUES
	(1, '15090-000', 'Av. Brg. Faria Lima', 'Vila São Jose', '5544', null),
	(2, '04538-132', 'Rua Arizona', 'Brooklin', '500', null),
	(3, '04094-050', 'Avenida Jabaquara', 'Mirandópolis', '1500', null),
	(4, '01415-002', 'Rua Haddock Lobo', 'Cerqueira César', '900', null),
	(5, '05001-200', 'Rua Clélia', 'Lapa', '300', null),
	(6, '03085-040', 'Rua da Mooca', 'Mooca', '400', null),
	(7, '01156-030', 'Rua José Paulino', 'Bom Retiro', '200', 'Sala 707'),
	(8, '03132-010', 'Rua dos Trilhos', 'Brás', '800', 'Apto 808'),
	(9, '01504-001', 'Rua Pires da Mota', 'Liberdade', '600', 'Apto 909'),
	(10, '02044-020', 'Avenida Brás Leme', 'Santana', '1000', null),
	(11, '01535-001', 'Rua Domingos de Morais', 'Vila Mariana', '1100', null),
	(12, '02341-001', 'Avenida Tucuruvi', 'Tucuruvi', '1200', 'Apto 1212'),
	(13, '15035-010', 'Av. dos Estudantes', 'Jardim Novo Aeroporto', '2410', null),
	(14, '15025-380', 'Rua João Bôsco de Camargo', 'Vila MariaSão', '88', null),
	(15, '05005-030', 'Rua Guaicurus', 'Lapa', '1500', 'Apto 1515'),
	(16, '15035-470', 'Av. João Batista Vetorasso', 'Distrito Industrial', '1600', null),
	(17, '15020-200', 'R. Carmelino Gonçalves Condessa', 'Santos Dumont', '395', null),
	(18, '15055-300', 'Rua Dr. Coutinho Cavalcante', 'Jardim Alto Alegre', '723', null),
	(19, '15040-300', 'Av. Fortunato Ernesto Vetorasso', 'Jardim Res. Vetorasso', '1050', null),
	(20, '15092-430', 'Rua Hélio Negrelli', 'Jardim Tarraf II', '1615', null),
	(21, '15130-000', 'Av. Eliezer Magalhaes', 'Jardim Alvorada', '3849', null),
	(22, '15010-110', 'Rua Independência', 'Centro', '2610', null)
GO

----------------------------------------------------------------
-- TABELA COMPRA
----------------------------------------------------------------
INSERT INTO
	compra
		(
		 id_cliente
		)
VALUES
	(1),
	(2),
	(3),
	(4),
	(5),
	(6),
	(7),
	(7),
	(8),
	(9),
	(10),
	(11),
	(12),
	(13),
	(14),
	(15),
	(16),
	(17),
	(18),
	(19),
	(20)
GO

----------------------------------------------------------------
-- TABELA ITENS_COMPRA
----------------------------------------------------------------
INSERT INTO
	itens_compra
		(
		 id_compra,
		 id_livro,
		 qtd,
		 preco_unitario,
		 desconto
		)
VALUES
	-- compra cliente 1
	(1, 1, 1, 35.00, 0), 
	(1, 2, 1, 32.75, 0), 
	-- compra cliente 2
	(2, 3, 1, 50.00, 0), 
	(2, 4, 1, 54.44, 0), 
	-- compra cliente 3
	(3, 5, 2, 42.50, 0), 
	-- compra cliente 4
	(4, 6, 1, 25.00, 0), 
	(4, 11, 1, 37.99, 5.00),
	(4, 14, 1, 32.89, 0),
	-- compra cliente 5
	(5, 29 , 3, 89.57, 5.00),
	-- compra cliente 6
	(6, 28, 1, 74.28, 0),
	-- compra cliente 7 (1)
	(7, 24, 2, 53.64, 0),
	-- compra cliente 7 (2)
	(8, 25, 1, 134.19, 0),
	-- compra cliente 8
	(9, 26, 1, 11.18, 0),
	-- compra cliente 9
	(10, 30, 1, 56.49, 0),
	-- compra cliente 10
	(11, 17, 1, 71.93, 0),
	(11, 18, 1, 561.75, 0),
	-- compra cliente 11
	(12, 15, 1, 56.20, 0),
	(12, 16, 1, 88.37, 0),
	-- compra cliente 12
	(13, 21, 1, 38.40, 0),
	(13, 22, 1, 27.55, 0),
	-- compra cliente 13
	(14, 22, 1, 27.55, 0),
	(14, 30, 1, 56.49, 0),
	-- compra cliente 14
	(15, 13, 1, 42.70, 0),
	-- compra cliente 15
	(16, 10, 1, 49.94, 0),
	(16, 9, 1, 55.90, 5),
	(16, 8, 1, 52.45, 0),
	-- compra cliente 16
	(17, 19, 1, 202.43, 0),
	-- compra cliente 17
	(18, 19, 10, 202.43, 70.00),
	-- compra cliente 18
	(19, 21, 1, 38.40, 0),
	-- compra cliente 19
	(20, 21, 1, 38.40, 0),
	(20, 27, 1, 39.92, 0),
	-- compra cliente 20
	(21, 16, 1, 88.37, 0),
	(21, 17, 1, 71.93, 0)
GO

----------------------------------------------------------------
-- UPDATE TABELA COMPRA com total_compra
----------------------------------------------------------------
UPDATE 
	compra 
SET 
	total_compra = 
		(
		select 
			sum(itens_compra.preco_unitario*itens_compra.qtd - itens_compra.desconto ) 
		from 
			itens_compra 
		where 
			id_compra = compra.id
		)
GO

SELECT * FROM livro
SELECT * FROM cliente
SELECT * FROM compra
SELECT * FROM itens_compra
SELECT * FROM cliente

-----------------------------------------------------------------
-- CONSULTAS  
-----------------------------------------------------------------

-----------------------------------------------------------------
-- 1) Faça uma consulta que traga todos os livros e seus respectivos assuntos.
-----------------------------------------------------------------
SELECT
	livro.id,
	livro.titulo,
	assunto.nome AS genero
FROM
	livro 
	INNER JOIN assunto 
		ON livro.id_assunto = assunto.id
GO

-----------------------------------------------------------------
-- 2) Faça uma consulta para obter todos os livros que, quando comprados, tiveram desconto na compra.
-----------------------------------------------------------------
SELECT
	livro.id,
	livro.titulo,
	livro.preco,
	itens_compra.id_compra AS 'cod. compra',
	itens_compra.desconto
FROM
	livro
	INNER JOIN itens_compra
		ON livro.id = itens_compra.id_livro
		   AND itens_compra.desconto > 0
GO

-----------------------------------------------------------------
-- 3) Faça uma consulta que traga todos os livros que foram ou não 
--    comprados e suas respectivas compras (use algum tipo de JOIN).
-----------------------------------------------------------------
SELECT
	livro.id,
	livro.titulo,
	livro.preco,
	itens_compra.id_compra AS 'cod. compra'
FROM
	livro
	LEFT JOIN itens_compra
		ON livro.id = itens_compra.id_livro
ORDER BY
	livro.id
GO

-----------------------------------------------------------------
-- 4) Faça uma consulta que traga todos os clientes que são pessoa física (use Inner Join).
-----------------------------------------------------------------
SELECT
	cliente.id,
	cliente.nome,
	cliente_pessoa.nome_social,
	cliente.status
FROM
	cliente
	INNER JOIN cliente_pessoa
		ON cliente.id = cliente_pessoa.id_cliente
GO

-----------------------------------------------------------------
-- 5) Faça alteração de preço de todos os livros do assunto “Romance”, aumentando o preço em 10%.
-----------------------------------------------------------------
UPDATE 
	livro 
SET 
	livro.preco = (livro.preco + (livro.preco * 0.10))
	FROM livro
	INNER JOIN assunto 
		ON livro.id_assunto = assunto.id
		   AND assunto.nome LIKE 'romance'
GO

SELECT * FROM livro

-----------------------------------------------------------------
-- 6) Inative o cliente sempre que desejar excluí-lo do Banco de Dados,
--    para evitar que se faça uma exclusão física dos dados do cliente.
-----------------------------------------------------------------
UPDATE
	cliente
SET
	status = 2
WHERE
	cliente.id = 17 -- Villa Calui

SELECT * FROM cliente

-----------------------------------------------------------------
-- 7) Exclua o telefone de todos os clientes pessoa jurídica cujo valor da compra seja maior que R$ 100.000,00.
-- AJUSTAMOS O VALOR PARA 1.000, JA QUE NAO TEMOS COMPRAS ACIMA DE 100.000
-----------------------------------------------------------------
DELETE FROM 
	cliente_telefone
FROM
	cliente_telefone
	INNER JOIN cliente
		ON cliente.id = cliente_telefone.id_cliente
		INNER JOIN compra
			ON compra.id_cliente = cliente.id
			AND compra.total_compra > 1000 -- id 17, Villa Calui

SELECT * FROM cliente_telefone

-----------------------------------------------------------------
-- 8) Calcule o valor de cada compra.
-----------------------------------------------------------------
SELECT
	compra.id AS 'cod. compra',
	SUM(itens_compra.preco_unitario * itens_compra.qtd - itens_compra.desconto) AS 'total compra'
FROM
	compra
	JOIN itens_compra
		ON compra.id = itens_compra.id_compra
GROUP BY
	compra.id

-----------------------------------------------------------------
-- 9) Encontre o livro mais caro, o mais barato, o preço médio dos livros.
-----------------------------------------------------------------
SELECT
	MAX(livro.preco) AS 'mais caro',
	MIN(livro.preco) AS 'mais barato',
	AVG(livro.preco) AS 'preco medio'
FROM
	livro
GO
