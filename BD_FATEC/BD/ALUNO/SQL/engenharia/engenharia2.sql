CREATE DATABASE sala;
GO

USE sala;
GO

CREATE TABLE departamento
(
	id		 INT		  NOT NULL IDENTITY,
	nome	 VARCHAR(45)  NOT NULL,
	local	 VARCHAR(100) NOT NULL,
	telefone VARCHAR(15)  NOT NULL,

	CONSTRAINT pk_departamento PRIMARY KEY (id)
);
GO

CREATE TABLE funcionario
(
	id		  INT						   NOT NULL IDENTITY,
	nome	  VARCHAR(45)				   NOT NULL,
	cpf		  VARCHAR(14)				   NOT NULL,
	dat_nasc  DATE						   NOT NULL,
	status    BIT		 DEFAULT 1		   NOT NULL, --criando status booleano
	dat_cad   DATETIME   DEFAULT GETDATE() NOT NULL,

	CONSTRAINT pk_funcionario PRIMARY KEY (id)
);
GO

CREATE TABLE tecnico
(
	id			   INT							NOT NULL IDENTITY,
	id_funcionario INT							NOT NULL,
	valor_hora	   MONEY						NOT NULL,
	salario        MONEY						NOT NULL,
	status		   BIT		  DEFAULT 1			NOT NULL, --criando status booleano
	dat_cad		   DATETIME   DEFAULT GETDATE() NOT NULL,

	CONSTRAINT pk_tecnico			  PRIMARY KEY (id),
	CONSTRAINT fk_tecnico_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id)
);
GO


CREATE TABLE engenheiro
(
	id			   INT							NOT NULL IDENTITY,
	id_funcionario INT							NOT NULL,
	especialidade  VARCHAR(40)					NOT NULL,
	anos_exp       INT							NOT NULL,
	classificacao  INT							NOT NULL,
	status		   BIT		  DEFAULT 1			NOT NULL, --criando status booleano
	dat_cad		   DATETIME   DEFAULT GETDATE() NOT NULL,

	CONSTRAINT pk_engenheiro			   PRIMARY KEY (id),
	CONSTRAINT fk_engenheiro_funcionario   FOREIGN KEY (id_funcionario) REFERENCES funcionario (id),
	CONSTRAINT ck_engenheiro_classificacao CHECK (classificacao IN (1,2,3)),
	CONSTRAINT ck_engenheiro_anos_exp      CHECK (anos_exp > 0)
);
GO

CREATE TABLE dependente
(
	id		   INT		   NOT NULL IDENTITY,
	nome	   VARCHAR(45) NOT NULL,
	idade	   INT		   NOT NULL,
	parentesco VARCHAR(20) NOT NULL,

	CONSTRAINT pk_dependente PRIMARY KEY (id),
	CONSTRAINT ck_dependente_idade CHECK (idade > 0)
);
GO

CREATE TABLE projeto
(
	id		  INT		   NOT NULL IDENTITY,
	nome	  VARCHAR(45)  NOT NULL,
	local	  VARCHAR(100) NOT NULL,
	orcamento MONEY		   NOT NULL,

	CONSTRAINT pk_projeto PRIMARY KEY (id)
);
GO

CREATE TABLE tecnico_projeto
(
	id_tecnico	INT  NOT NULL,
	id_projeto  INT  NOT NULL,
	qtd_horas	INT  NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim    DATE NOT NULL,

	CONSTRAINT fk_tecnico_projeto_tecnico   FOREIGN KEY (id_tecnico) REFERENCES tecnico (id),
	CONSTRAINT fk_tecnico_projeto_projeto   FOREIGN KEY (id_projeto) REFERENCES projeto (id),
	CONSTRAINT ck_tecnico_projeto_qtd_horas CHECK (qtd_horas > 0),
	CONSTRAINT ck_tecnico_projeto_datas     CHECK (data_inicio < data_fim),
);
GO

CREATE TABLE engenheiro_projeto
(
	id_engenheiro INT  NOT NULL,
	id_projeto    INT  NOT NULL,
	qtd_horas	  INT  NOT NULL,

	CONSTRAINT fk_engenheiro_projeto_engenheiro FOREIGN KEY (id_engenheiro) REFERENCES engenheiro (id),
	CONSTRAINT fk_engenheiro_projeto_projeto    FOREIGN KEY (id_projeto)    REFERENCES projeto (id),
	CONSTRAINT ck_engenheiro_projeto_qtd_horas CHECK (qtd_horas > 0),
);
GO