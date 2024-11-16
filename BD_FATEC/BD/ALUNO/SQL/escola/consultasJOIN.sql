USE escola
GO

---------------------------------------------------------------------------------------------
-- INNER JOIN faz quase a mesma coisa do where, faz a intersecção das duas tabelas comparadas
---------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- 1. Consultar todos os cursos e suas disciplinas
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
	curso
	INNER JOIN disciplina 
		ON curso.id = disciplina.id_curso
ORDER BY
	curso.nome ASC
GO

--------------------------------------------------------------------------
-- 2. Consultar todas as disciplinas cursadas pelo aluno com id = 1
--    Apresente: nome da disciplina, nome do professor, nome do aluno, nota e frequencia
--------------------------------------------------------------------------
SELECT
	disciplina.id,
	disciplina.nome,
	professor.id,
	professor.nome,
	aluno.id,
	aluno.nome,
	aproveitamento.nota,
	aproveitamento.faltas,
	CONVERT(VARCHAR(7), CONVERT(DECIMAL(5,2),
	((1 - ((aproveitamento.faltas * 1.0))/disciplina.carga_horaria) * 100.0))) + '%' AS frequencia
FROM
	aproveitamento
	INNER JOIN disciplina
		ON aproveitamento.id_disciplina = disciplina.id
	INNER JOIN professor
		ON disciplina.id_professor = professor.id
	INNER JOIN aluno
		ON aproveitamento.id_aluno = aluno.id
		AND aluno.id = 1
GO

--------------------------------------------------------------------------
-- 3. Consultar todos os alunos aprovados
--    Saida deve mostrar o nome do curso, nome da disciplina, nome do aluno, nota, frequencia
--------------------------------------------------------------------------
SELECT
	curso.id,
	curso.nome,
	disciplina.id,
	disciplina.nome,
	aluno.id,
	aluno.nome,
	aproveitamento.nota,
	aproveitamento.faltas,
	CONVERT(VARCHAR(7), 
		CONVERT(DECIMAL(5,2),
			((1 - ((aproveitamento.faltas * 1.0)/disciplina.carga_horaria)) * 100.0)
		)
	) + '%' AS frequencia
FROM
	curso
	INNER JOIN disciplina
		ON curso.id = disciplina.id_curso
	INNER JOIN aproveitamento
		ON disciplina.id = aproveitamento.id_disciplina
	INNER JOIN aluno
		ON aproveitamento.id_aluno = aluno.id
	AND aproveitamento.nota >= 6.0
	AND (1 - ((aproveitamento.faltas * 1.0)/disciplina.carga_horaria)) >= 0.75
GO

--------------------------------------------------------------------------
-- 4. Consultar todos os alunos reprovados por falta
--    Saida deve mostrar o nome do curso, nome da disciplina, nome do aluno, nota, frequencia
--------------------------------------------------------------------------
SELECT
	curso.id,
	curso.nome,
	disciplina.id,
	disciplina.nome,
	aluno.id,
	aluno.nome,
	aproveitamento.nota,
	aproveitamento.faltas,
	CONVERT(VARCHAR(7), 
		CONVERT(DECIMAL(5,2),
			((1 - ((aproveitamento.faltas * 1.0)/disciplina.carga_horaria)) * 100.0)
		)
	) + '%' AS frequencia
FROM
	curso
	INNER JOIN disciplina
		ON curso.id = disciplina.id_curso
	INNER JOIN aproveitamento
		ON disciplina.id = aproveitamento.id_disciplina
	INNER JOIN aluno
		ON aproveitamento.id_aluno = aluno.id
	AND (1 - ((aproveitamento.faltas * 1.0)/disciplina.carga_horaria)) < 0.75
GO

--------------------------------------------------------------------------
-- 5. Consultar a media de cada disciplina no segundo semestre de 2023
--    Apresente o codigo, nome da disciplina, e a media
--	  Ordene a saida pelo nome da disciplina em ordem crescente
--------------------------------------------------------------------------
SELECT
	disciplina.id,
	disciplina.nome,
	CONVERT(DECIMAL(5,2), AVG(aproveitamento.nota)) AS media
FROM
	disciplina
	INNER JOIN aproveitamento
		ON disciplina.id = aproveitamento.id_disciplina
	AND aproveitamento.ano_aprov = 2023
	AND aproveitamento.semestre_aprov = 2
GROUP BY
	disciplina.id,
	disciplina.nome
ORDER BY
	disciplina.nome
GO
		
---------------------------------------------------------------------------------------------
-- LEFT JOIN
---------------------------------------------------------------------------------------------