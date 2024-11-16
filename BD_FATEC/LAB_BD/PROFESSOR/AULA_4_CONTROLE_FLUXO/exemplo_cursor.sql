DECLARE @DatabaseName NVARCHAR(255);
DECLARE @SQL NVARCHAR(MAX);

-- Declaração do cursor para iterar sobre os nomes dos bancos de dados
DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE state_desc = 'ONLINE' -- Somente bancos de dados online
	   AND database_id > 4; -- Ignora os bancos de dados do sistema (master, tempdb, model, msdb)

-- Abrir o cursor
OPEN db_cursor;

-- Buscar o primeiro banco de dados
FETCH NEXT FROM db_cursor INTO @DatabaseName;

-- Iniciar a iteração
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construir o comando SQL para listar as tabelas do banco de dados atual
    SET @SQL = 'USE [' + @DatabaseName + ']; ' +
               'SELECT ''' + @DatabaseName + ''' AS DatabaseName, name AS TableName ' +
               'FROM sys.tables;';

    -- Executar o comando SQL
    EXEC sp_executesql @SQL;

    -- Buscar o próximo banco de dados
    FETCH NEXT FROM db_cursor INTO @DatabaseName;
END;

-- Fechar o cursor
CLOSE db_cursor;

-- Liberar o cursor
DEALLOCATE db_cursor;
