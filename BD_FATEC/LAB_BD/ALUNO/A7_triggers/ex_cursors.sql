DROP TABLE tb_coordenadas
CREATE TABLE tb_coordenadas
(
	id INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(MAX),
	x FLOAT,
	y FLOAT
);

DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
	DECLARE @nome VARCHAR(MAX) = 'particula' + CONVERT(VARCHAR(MAX), @i),
			@x    FLOAT = RAND()*50 + 50,
			@y	  FLOAT = RAND()*50 + 50
	
	INSERT INTO tb_coordenadas
	VALUES (@nome, @x, @y)
	
	SET @i = @i + 1;
END;

SELECT * FROM tb_coordenadas

-- Ex 3. lista de cursores
DECLARE @min_dist FLOAT = 50*SQRT(2),
		@id_1_min INT,
		@id_2_min INT,
		@n INT = (SELECT COUNT(*) FROM tb_coordenadas);

DECLARE cursor_ex3 CURSOR
FOR
SELECT * FROM tb_coordenadas;

OPEN cursor_ex3;

DECLARE @j INT = 1;
WHILE @j <= @n
BEGIN
	DECLARE @id_1 INT, @nome_1 VARCHAR(MAX), @x_1 FLOAT, @y_1 FLOAT;
	FETCH NEXT FROM cursor_ex3 INTO @id_1, @nome_1, @x_1, @y_1;

	DECLARE cursor_ex3_2 CURSOR
	FOR
	SELECT * FROM tb_coordenadas;

	OPEN cursor_ex3_2

	DECLARE @k INT = 1;
	WHILE @k <= @n
	BEGIN
		DECLARE @id_2 INT, @nome_2 VARCHAR(MAX), @x_2 FLOAT, @y_2 FLOAT;
		FETCH NEXT FROM cursor_ex3_2 INTO @id_2, @nome_2, @x_2, @y_2;

		IF (@id_2 != @id_1)
		BEGIN
			DECLARE @dist FLOAT;
			SET @dist = SQRT((POWER(@x_1 - @x_1, 2.0)) + POWER(@y_1 - @y_2, 2.0))

			IF @dist < @min_dist
			BEGIN
				SET @min_dist = @dist;
				SET @id_1_min = @id_1;
				SET @id_2_min = @id_2;
			END;
		END;
		SET @k = @k + 1; 
	END;

	CLOSE cursor_ex3_2;
	DEALLOCATE cursor_ex3_2;
	
	SET @j = @j + 1;
END;

CLOSE cursor_ex3;
DEALLOCATE cursor_ex3;

PRINT(CONCAT('Menor distancia: ', @min_dist,CHAR(13), 'id_1 = ', @id_1_min,CHAR(13), 'id_2 = ', @id_2_min ))