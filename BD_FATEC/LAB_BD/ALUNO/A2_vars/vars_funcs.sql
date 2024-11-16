
--CONCAT--------------------------------------------------

--Ex 1.
DECLARE @msg VARCHAR(8000);
SET @msg = CONCAT('VAR1', 10, 1.2, ' = ' , ';');

PRINT(@msg);

--Ex 2.
DECLARE @x FLOAT = 1.0,
		@i INT = 1;

DECLARE @z FLOAT = @x + @i;
PRINT(CONCAT('x = ', @x, ' y = ', @i, ' z = ', @z));

--SUBSTRING---------------------------------------------

DECLARE @str VARCHAR(8000);
SET @str = '123456789';

DECLARE @substr VARCHAR(8000);
SET @substr = SUBSTRING(@str, 3, 4);

PRINT(@substr);

DECLARE @left  VARCHAR(8000),
		@right VARCHAR(8000);
SET @left = LEFT(@str, 4);
SET @right = RIGHT(@str, 4);

PRINT(CONCAT('LEFT = ', @left));
PRINT(CONCAT('RIGHT = ', @right));

PRINT(CONCAT('Tamanho da STR: ', LEN(@str)))

--NEWID---------------------------------------------------
PRINT(NEWID());

-- Gerando uma string aleatoria com 100 caracteres
DECLARE @str CHAR(100);
SET @str = CONCAT(NEWID(), NEWID(), NEWID(), NEWID());
SET @str = LEFT(@str, 100)
PRINT(@str)

SET @str = REPLACE(@str, '-', '');
PRINT(@str)

--DATE-----------------------------------------------------

PRINT(GETDATE());
PRINT(DATEPART(NANOSECOND, GETDATE()));

PRINT('Mes Atual: ' + DATENAME(MONTH, GETDATE()));
PRINT('Dia Atual: ' + DATENAME(WEEKDAY, GETDATE()));

DECLARE @dia_do_nascimento DATE = '1992-04-12';
DECLARE @hoje DATETIME = GETDATE();
DECLARE @datafutura DATE = '2067-04-12';

DECLARE @distancia INT = DATEDIFF(YEAR, @dia_do_nascimento, @hoje);
DECLARE @dias_restantes INT = DATEDIFF (DAY, @hoje, @datafutura);

PRINT(CONCAT('Anos vividos; ', @distancia));
PRINT(CONCAT('Dias restantes: ', @dias_restantes));

PRINT(DAY(GETDATE()));
PRINT(MONTH(GETDATE()));
PRINT(YEAR(GETDATE()));

--RAND-----------------------------------------------------

PRINT(RAND());

PRINT(10 * RAND());

PRINT(5 * RAND() + 5);

PRINT(ROUND(6 * RAND() + 5 , 0));
PRINT(FLOOR(6 * RAND() + 5));
PRINT(CEILING(6 * RAND() + 5));