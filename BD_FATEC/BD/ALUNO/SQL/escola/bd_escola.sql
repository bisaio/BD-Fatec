CREATE DATABASE escola
GO

USE escola
GO

--------------------------------------------------------------------------

CREATE TABLE curso
(
	id   INT		  NOT NULL PRIMARY KEY IDENTITY,
	nome VARCHAR(100) NOT NULL
)
GO

CREATE TABLE professor
(
	id	 INT		 NOT NULL PRIMARY KEY IDENTITY,
	nome VARCHAR(50) NOT NULL
)

CREATE TABLE aluno
(
	id   INT		 NOT NULL PRIMARY KEY IDENTITY,
	nome VARCHAR(50) NOT NULL
)
GO

CREATE TABLE disciplina
(
	id			  INT		   NOT NULL PRIMARY KEY IDENTITY,
	nome		  VARCHAR(100) NOT NULL,
	carga_horaria INT		   NOT NULL,
	id_curso	  INT		   NOT NULL,
	id_professor  INT		   NOT NULL,

	FOREIGN KEY (id_curso)	   REFERENCES curso(id),
	FOREIGN KEY (id_professor) REFERENCES professor(id),

	CHECK(carga_horaria > 0)
)
GO

CREATE TABLE aproveitamento
(
	id_aluno	   INT			NOT NULL,
	id_disciplina  INT			NOT NULL,
	ano_aprov	   INT			NOT NULL,
	semestre_aprov INT          NOT NULL,
	nota		   DECIMAL(6,2)		NULL,
	faltas		   INT				NULL DEFAULT 0,

	PRIMARY KEY (id_aluno, id_disciplina, ano_aprov, semestre_aprov),

	FOREIGN KEY (id_aluno)		REFERENCES aluno(id),
	FOREIGN KEY (id_disciplina) REFERENCES disciplina(id),

	CHECK (nota >= 0.0 AND nota <= 10.0)
)
GO

--------------------------------------------------------------------------
-- INSERT
-- Cadastrar 3 cursos, 5 disciplinas por curso, 10 professores, 20 alunos,
--------------------------------------------------------------------------

INSERT INTO 
	curso
		(nome)
	VALUES
		('Tec. Analise e Desenvolvimento de Sistemas'),
		('Tec. Informatica para Negocios'),
		('Tec. Agronegocios')
GO

INSERT INTO 
	professor
		(nome)
	VALUES
		('Valeria Maria Volpe'),
		('Walter Gomes Pedroso Junior'),
		('Maura Cristina Frigo'),
		('Jose Aparecido de Aguiar Viana'),
		('Carlos Magnus Carlson Filho'),
		('Luciene Cavalcanti'),
		('Djalma Domingos da Silva'),
		('Marildo Domingos da Silva'),
		('Henrique Dezani'),
		('Lucimar Sasso Vieira')
GO

INSERT INTO 
	aluno
		(nome)
	VALUES
		('Super Man'),
		('Spider Man'),
		('Aqua Man'),
		('Batman'),
		('Mulher Maravilha'),
		('Iron Man'),
		('Mulher Gato'),
		('Capitao America'),
		('Flash'),
		('Thor'),
		('Branca de Neve'),
		('Frozen'),
		('Alice'),
		('Penelope Charmosa'),
		('Ayrton Senna'),
		('Portugues da Padaria'),
		('Cristiano Ronaldo'),
		('Lionel Messi'),
		('Vinicius Junior'),
		('Richarlison de Andrade')
GO

INSERT INTO 
	disciplina -- do curso 1
		(nome, carga_horaria, id_curso, id_professor)
	VALUES
		('Algoritimo e Logica de Programacao', 80, 1, 1),
		('Banco de Dados', 80, 1, 1),
		('Ingles I', 40, 1, 3),
		('Redes de Computadores', 80, 1, 2),
		('Programacao Orientada a Objetos', 80, 1, 9)
GO

INSERT INTO 
	disciplina -- do curso 2
		(nome, carga_horaria, id_curso, id_professor)
	VALUES
		('Administracao de Banco de Dados', 80, 2, 1),
		('Introducao a Informatica', 40, 2, 10),
		('Ingles II', 40, 2, 3),
		('Sistems Operacionais', 80, 2, 4),
		('Estrutura de Dados', 80, 2, 5)
GO

INSERT INTO 
	disciplina -- do curso 3
		(nome, carga_horaria, id_curso, id_professor)
	VALUES
		('Hortas Caseiras', 80, 3, 6),
		('Producao Agricola I', 40, 3, 8),
		('Portugues Instrumental', 40, 3, 7),
		('Agropecuaria II', 80, 3, 5),
		('Manejo de Bovinos', 40, 3, 7)
GO

INSERT INTO 
	aproveitamento -- curso 1, disciplina 1
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(1,  1, 2023, 1, 9.5, 2),  -- aluno aprovado
		(20, 1, 2022, 2, 5.0, 0),  -- aluno reprovado por nota
		(5,  1, 2023, 2, 3.5, 35), -- aluno reprovado por falta
		(5,  1, 2023, 1, 4.5, 10), -- aluno reprovado por nota
		(8,  1, 2021, 1, 6.0, 12) -- aluno aprovado
GO

INSERT INTO 
	aproveitamento -- curso 1, disciplina 2
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(3,  2, 2021, 1, 7.0, 4),  -- aluno aprovado
		(6,  2, 2023, 1, 2.0, 0),  -- aluno reprovado por nota
		(6,  2, 2023, 2, 3.5, 10), -- aluno reprovado por nota
		(15, 2, 2022, 2, 10.0, 2), -- aluno aprovado
		(17, 2, 2023, 1, 7.5, 22)  -- aluno reprovado por falta
GO

INSERT INTO 
	aproveitamento -- curso 1, disciplina 3
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(1,  3, 2020, 2, 1.8, 8),  -- aluno reprovado por nota
		(13, 3, 2023, 2, 5.5, 24), -- aluno reprovado por falta
		(10, 3, 2022, 1, 7.5, 6),  -- aluno aprovado
		(7,  3, 2022, 1, 8.75, 6)  -- aluno aprovado
GO


-- TAREFA
-- INSERIR PARA TODAS AS DISCIPLINAS, em pelo menos uma colocar todos os alunos reprovados e todos os alunos aprovados

INSERT INTO 
	aproveitamento -- curso 1, disciplina 4
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(17, 4, 2019, 1, 2.0, 7),  -- aluno reprovado por nota
		(12, 4, 2022, 2, 3.5, 4),  -- aluno reprovado por nota
		(5,  4, 2020, 1, 1.5, 6),  -- aluno reprovado por nota
		(8,  4, 2020, 1, 4.0, 27)  -- aluno reprovado por nota e falta
GO

INSERT INTO 
	aproveitamento -- curso 1, disciplina 5
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(3,  5, 2024, 1, 7.0, 7),  -- aluno aprovado 
		(10, 5, 2023, 2, 8.5, 4),  -- aluno aprovado
		(7,  5, 2021, 1, 9.5, 6),  -- aluno aprovado
		(4,  5, 2023, 2, 10.0, 0)  -- aluno aprovado
GO

INSERT INTO 
	aproveitamento -- curso 2, disciplina 6
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(1, 6, 2020, 2, 2.0, 7), 
		(2, 6, 2021, 1, 8.5, 40),  
		(3, 6, 2022, 1, 9.5, 6),  
		(4, 6, 2023, 2, 7.0, 0)  
GO

INSERT INTO 
	aproveitamento -- curso 2, disciplina 7
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(5, 7, 2023, 1, 5.0, 0), 
		(6, 7, 2022, 1, 6.5, 2),  
		(7, 7, 2021, 2, 9.0, 5),  
		(8, 7, 2020, 2, 7.0, 10)  
GO

INSERT INTO 
	aproveitamento -- curso 2, disciplina 8
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(9,  8, 2022, 2, 10.0, 2), 
		(10, 8, 2021, 2, 9.0, 3),  
		(11, 8, 2021, 1, 5.5, 7),  
		(12, 8, 2022, 1, 2.0, 18)  
GO

INSERT INTO 
	aproveitamento -- curso 2, disciplina 9
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(13, 9, 2022, 1, 7.0, 20), 
		(14, 9, 2023, 2, 7.5, 5),  
		(15, 9, 2023, 2, 3.0, 5),  
		(16, 9, 2022, 1, 6.7, 12)  
GO

INSERT INTO 
	aproveitamento -- curso 2, disciplina 10
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(17, 10, 2019, 1, 8.0, 20), 
		(18, 10, 2019, 2, 7.5, 5),  
		(19, 10, 2019, 1, 5.5, 5),  
		(20, 10, 2019, 2, 7.7, 12)  
GO

INSERT INTO 
	aproveitamento -- curso 3, disciplina 11
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(1, 11, 2019, 2, 7.0, 15), 
		(3, 11, 2022, 2, 8.15, 2),  
		(5, 11, 2023, 2, 9.5, 9),  
		(7, 11, 2021, 2, 3.0, 10)  
GO

INSERT INTO 
	aproveitamento -- curso 3, disciplina 12
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(9,  12, 2020, 1, 8.0, 5), 
		(11, 12, 2020, 1, 7.0, 12),  
		(13, 12, 2021, 1, 10.0, 19),  
		(15, 12, 2021, 1, 2.5, 0)  
GO

INSERT INTO 
	aproveitamento -- curso 3, disciplina 13
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(17, 13, 2022, 2, 9.0, 4), 
		(19, 13, 2022, 1, 9.5, 2),  
		(2,  13, 2023, 2, 10.0, 0),  
		(4,  13, 2023, 1, 7.5, 0)  
GO

INSERT INTO 
	aproveitamento -- curso 3, disciplina 14
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(6,  14, 2023, 2, 10.0, 2), 
		(8,  14, 2023, 2, 1.5, 12),  
		(10, 14, 2024, 2, 1.0, 3),  
		(12, 14, 2024, 1, 4.5, 6)  
GO

INSERT INTO 
	aproveitamento -- curso 3, disciplina 15
		(id_aluno, id_disciplina, ano_aprov, semestre_aprov, nota, faltas)
	VALUES
		(14, 15, 2024, 1, 6.0, 7), 
		(16, 15, 2023, 2, 6.5, 8),  
		(18, 15, 2022, 2, 10.0, 22),  
		(20, 15, 2021, 1, 5.5, 10)  
GO

--------------------------------------------------------------------------
-- 1. Consultar as disciplinas do curso 1
--    Apresente: id, nome e carga horaria da disciplina
--    Ordene a saida pelo nome da disciplina em ordem crescente
--------------------------------------------------------------------------

SELECT 
	disciplina.id, 
	disciplina.nome, 
	disciplina.carga_horaria
FROM
	disciplina
WHERE
	disciplina.id_curso = 1
ORDER BY
	disciplina.nome ASC -- ORDEM CRESCENTE
GO

--------------------------------------------------------------------------
-- 2. Consultar as disciplinas do curso 1
--    Apresente: id, nome e carga horaria da disciplina
--    Ordene a saida pelo nome da disciplina em ordem decrescente
--------------------------------------------------------------------------

SELECT 
	disciplina.id, 
	disciplina.nome, 
	disciplina.carga_horaria
FROM
	disciplina
WHERE
	disciplina.id_curso = 1
ORDER BY
	disciplina.nome DESC -- ORDEM DECRESCENTE
GO

--------------------------------------------------------------------------
-- 3. Consultar todos os cursos e suas disciplinas
--    Apresente: id e nome do curso; id, nome e carga horaria da disciplina
--    Ordene a saida pelo nome do curso em ordem crescente
--------------------------------------------------------------------------

SELECT 
	curso.id,
	curso.nome,
	disciplina.id, 
	disciplina.nome, 
	disciplina.carga_horaria
FROM
	disciplina,
	curso
WHERE
	curso.id = disciplina.id_curso
ORDER BY
	curso.nome ASC
GO

--------------------------------------------------------------------------
-- 4. Consultar todas disciplinas cursadas pelo aluno com id = 1
--    Apresente nome da disciplina, nome do professor, nome do aluno, nota e frequencia
--------------------------------------------------------------------------
SELECT
	d.id, 
	d.nome,
	p.nome,
	a.nome,
	ap.nota, 
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia
FROM
	disciplina AS d,
	professor AS p,
	aluno AS a,
	aproveitamento AS ap
WHERE
	d.id_professor = p.id
	AND d.id = ap.id_disciplina
	AND a.id = ap.id_aluno
	AND a.id = 1
GO

--------------------------------------------------------------------------
-- 5. Consultar todas os alunos aprovados
--    Saida deve mostrar o nome do curso, nome da disciplina, nome do aluno, nota, frequencia
--------------------------------------------------------------------------
SELECT 
	c.id, c.nome,
	d.id, d.nome,
	a.nome,
	ap.nota, ap.faltas,
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia
FROM 
	curso AS c,
	disciplina AS d,
	aluno AS a,
	aproveitamento AS ap
WHERE c.id = d.id_curso
	  AND d.id = ap.id_disciplina
	  AND a.id = ap.id_aluno
	  AND ap.nota >= 6.0
	  AND (1 - ((ap.faltas * 1.0) / d.carga_horaria)) >= 0.75
ORDER BY
	d.nome ASC
GO

--------------------------------------------------------------------------
-- 6. Consultar todas os alunos reprovados por falta
--    Saida deve mostrar o nome do curso, nome da disciplina, nome do aluno, nota, frequencia
--------------------------------------------------------------------------
SELECT 
	c.id, c.nome,
	d.id, d.nome, d.carga_horaria,
	a.id, a.nome,
	ap.nota, ap.faltas,
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia
FROM 
	curso AS c,
	disciplina AS d,
	aluno AS a,
	aproveitamento AS ap
WHERE
	c.id = d.id
	AND d.id = ap.id_disciplina
	AND a.id = ap.id_aluno
	AND (1 - ((ap.faltas * 1.0) / d.carga_horaria)) < 0.75
ORDER BY
	c.nome, d.nome
GO


--------------------------------------------------------------------------
-- 7. Consultar todas os alunos reprovados por falta OU nota
--    Saida deve mostrar o nome do curso, nome da disciplina, nome do aluno, nota, frequencia
--------------------------------------------------------------------------
SELECT 
	c.id, c.nome,
	d.id, d.nome, d.carga_horaria,
	a.id, a.nome,
	ap.ano_aprov, ap.semestre_aprov, ap.nota, ap.faltas,
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia
FROM 
	curso AS c,
	disciplina AS d,
	aluno AS a,
	aproveitamento AS ap
WHERE
	c.id = d.id
	AND d.id = ap.id_disciplina
	AND a.id = ap.id_aluno
	AND ( (1 - ((ap.faltas * 1.0) / d.carga_horaria)) < 0.75 OR ap.nota < 6.0 )
ORDER BY
	c.nome, d.nome
GO

--------------------------------------------------------------------------
-- 8. Consultar todos os alunos que tenham a letra R no nome
--    Saida: mostrar id, nome dos alunos
--------------------------------------------------------------------------
SELECT
	aluno.id,
	aluno.nome
FROM
	aluno
WHERE
	aluno.nome LIKE '%r%'
GO

--------------------------------------------------------------------------
-- 9. Consultar todos os alunos que o nome comece com a letra S
--    Saida: mostrar id, nome dos alunos ordenados pelo nome
--------------------------------------------------------------------------
SELECT
	aluno.id,
	aluno.nome
FROM
	aluno
WHERE
	aluno.nome LIKE 's%'
ORDER BY
	aluno.nome ASC
GO

--------------------------------------------------------------------------
-- 10. Consultar os alunos que reprovaram somente por falta na disciplina 1 no segundo semestre de 2023
--     Apresentar o nome do aluno, ano, semestre, nota e a frequencia
--------------------------------------------------------------------------
SELECT 
	a.id, a.nome,
	d.id, d.nome,
	ap.ano_aprov, ap.semestre_aprov, ap.nota, ap.faltas,
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia
FROM 
	disciplina AS d,
	aluno AS a,
	aproveitamento AS ap
WHERE
	ap.id_disciplina = 1
	AND ap.ano_aprov = 2023
	AND ap.semestre_aprov = 2
	AND ap.id_disciplina = d.id
	AND ap.id_aluno = a.id
	AND (1 - ((ap.faltas * 1.0) / d.carga_horaria)) < 0.75
GO

--------------------------------------------------------------------------
-- 11. Consultar os alunos que reprovaram por falta ou nota na disciplina 1 no ano de 2023
--     Apresentar o nome do aluno, ano, semestre, nota e a frequencia
--------------------------------------------------------------------------
SELECT 
	a.id, a.nome,
	d.id, d.nome,
	ap.ano_aprov, ap.semestre_aprov, ap.nota, ap.faltas,
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia
FROM 
	disciplina AS d,
	aluno AS a,
	aproveitamento AS ap
WHERE
	ap.id_disciplina = 1
	AND ap.ano_aprov = 2023
	AND ap.id_disciplina = d.id
	AND ap.id_aluno = a.id
	AND ( ap.nota < 6.0 OR (1 - ((ap.faltas * 1.0) / d.carga_horaria)) < 0.75 )
GO

--------------------------------------------------------------------------
-- 12. Consultar os alunos que reprovaram na disciplina 2 no ano de 2023
--     Apresentar id e nome do aluno; ano, semestre, nota e a frequencia do aproveitamento ; nome do professor
--	   Saida deve estar ordenada pelo nome do aluno em ordem decrescente
--------------------------------------------------------------------------
SELECT 
	a.id, a.nome AS aluno,
	d.id AS id_disciplina, d.nome AS disciplina,
	ap.ano_aprov, ap.semestre_aprov, ap.nota, ap.faltas,
	convert(varchar(7), 
		convert(decimal(5,1), 
			((1 - ((ap.faltas * 1.0) / d.carga_horaria)) * 100)
		)
	) + '%' AS frequencia,
	p.nome AS professor
FROM 
	disciplina AS d,
	aluno AS a,
	aproveitamento AS ap,
	professor AS p
WHERE
	ap.id_disciplina = 2
	AND ap.ano_aprov = 2023
	AND ap.id_disciplina = d.id
	AND ap.id_aluno = a.id
	AND p.id = d.id_professor
	AND ( ap.nota < 6.0 OR (1 - ((ap.faltas * 1.0) / d.carga_horaria)) < 0.75 )
ORDER BY
	a.nome DESC
GO

--------------------------------------------------------------------------
-- 13. Consultar a media de cada aluno. Apresente o RM, nome do aluno e media
--	   Ordene a saida pela media em ordem crescente
--------------------------------------------------------------------------
SELECT
	aluno.id, 
	aluno.nome, 
	CONVERT(DECIMAL(5,2), AVG(aproveitamento.nota)) media
FROM
	aluno, aproveitamento
WHERE
	aluno.id = aproveitamento.id_aluno -- filtra e faz a intersecção entre as tabelas
GROUP BY				
	aluno.id, aluno.nome			   -- agrupa pelo id do aluno
ORDER BY
	media DESC						   -- ordena pela média em ordem crescente
GO

--------------------------------------------------------------------------
-- 14. Consultar a media de cada disciplina no segundo semestre de 2023. 
--	   Apresente o codigo, nome da disciplina e a media.
--	   Ordene a saida pelo nome da disciplina em ordem crescente
--------------------------------------------------------------------------
SELECT
	disciplina.id, 
	disciplina.nome, 
	CONVERT(DECIMAL(5,2), AVG(aproveitamento.nota)) media
FROM
	disciplina, aproveitamento
WHERE
	disciplina.id = aproveitamento.id_disciplina -- filtra e faz a intersecção entre as tabelas
	AND aproveitamento.ano_aprov = 2023
	AND aproveitamento.semestre_aprov = 2
GROUP BY				
	disciplina.id, disciplina.nome			     -- agrupa pelo id do aluno
ORDER BY
	disciplina.nome  						     -- ordena pela média em ordem crescente
GO

--------------------------------------------------------------------------
-- 15. Consultar a quantidade de reprovações por nota das disciplinas oferecidas no ano de 2023
--	   Apresente o codigo, nome da disciplina e a quantidaed de reprovações.
--	   Ordene a saida pela quantidade de reprovações em ordem crescente
--------------------------------------------------------------------------
SELECT 
	disciplina.id, disciplina.nome, COUNT(*) reprovados
FROM
	disciplina, aproveitamento
WHERE
	disciplina.id = aproveitamento.id_disciplina
	AND aproveitamento.ano_aprov = 2023
	AND aproveitamento.nota < 6
	AND (1 - ((aproveitamento.faltas * 1.0) / disciplina.carga_horaria)) >= 0.75
GROUP BY
	disciplina.id, disciplina.nome
ORDER BY
	reprovados DESC
GO

--------------------------------------------------------------------------
-- 16. Consultar a quantidade de reprov~ções por nota das disciplinas
-- oferecidas no primeiro semestre de 2023.
-- Apresente o codigo, nome da disciplina e a quantidade de
-- reprovações somente das disciplinas com 2 ou mais reprovados
-- Ordene a saida pela quantidade de reprovações em ordem crescente
--------------------------------------------------------------------------

SELECT 
	disciplina.id, disciplina.nome, COUNT(*) reprovados
FROM
	disciplina, aproveitamento
WHERE
	disciplina.id = aproveitamento.id_disciplina
	AND aproveitamento.ano_aprov = 2023
	AND aproveitamento.nota < 6
	AND (1 - ((aproveitamento.faltas * 1.0) / disciplina.carga_horaria)) >= 0.75
GROUP BY
	disciplina.id, disciplina.nome
HAVING
	COUNT(*) >= 2
ORDER BY
	reprovados DESC
GO

--------------------------------------------------------------------------
-- 16. Consultar a media de cada aluno considerando somente
-- as notas acima de 7. Apresente o RM, nome do aluno  e a media somente
-- dos alunos com media >= 8.5.
-- Ordene a saida pela media em ordem decrescente
--------------------------------------------------------------------------

SELECT 
	aluno.id, aluno.nome, 
	AVG(aproveitamento.nota) AS media
FROM 
	aluno, 
	aproveitamento
WHERE 
	aluno.id = aproveitamento.id_aluno
	AND aproveitamento.nota > 7
GROUP BY
	aluno.id, aluno.nome
HAVING
	AVG(aproveitamento.nota) >= 8.5
ORDER BY
	media DESC
GO