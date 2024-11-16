-- Etapa 1: Criar a tabela no banco de dados 'master' para armazenar os resultados
USE master;
GO

IF OBJECT_ID('dbo.AllTables', 'U') IS NOT NULL
    DROP TABLE dbo.AllTables;

CREATE TABLE dbo.AllTables (
    DatabaseName NVARCHAR(255),
    TableName NVARCHAR(255)
);

-- Etapa 2: Declarar variáveis e o cursor para iterar sobre os bancos de dados
DECLARE @DatabaseName NVARCHAR(255);
DECLARE @SQL NVARCHAR(MAX);

DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE state_desc = 'ONLINE'  -- Apenas bancos de dados online
  AND database_id > 4;       -- Ignora os bancos de dados do sistema (master, tempdb, model, msdb)

-- Abrir o cursor
OPEN db_cursor;

-- Buscar o primeiro banco de dados
FETCH NEXT FROM db_cursor INTO @DatabaseName;

-- Iterar sobre os bancos de dados
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construir o comando SQL dinâmico para selecionar os nomes das tabelas
    SET @SQL = 'USE [' + @DatabaseName + ']; ' +
               'INSERT INTO master.dbo.AllTables (DatabaseName, TableName) ' +
               'SELECT ''' + @DatabaseName + ''', name ' +
               'FROM sys.tables;';

    -- Executar o comando SQL dinâmico
    EXEC sp_executesql @SQL;

    -- Buscar o próximo banco de dados
    FETCH NEXT FROM db_cursor INTO @DatabaseName;
END;

-- Fechar o cursor
CLOSE db_cursor;
-- Desalocar o cursor
DEALLOCATE db_cursor;

-- Exibir os resultados
SELECT * FROM master.dbo.AllTables;


select pokemon_db, name from sys.table_types