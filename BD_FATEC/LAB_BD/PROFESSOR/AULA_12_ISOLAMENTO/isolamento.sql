SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
dbcc useroptions


select * from sys.databases
select * from sys.tables
select * from sys.all_objects where object_id = object_id(??)

exec sp_lock
select @@SPID
exec sp_who

begin tran 
select @@TRANCOUNT

rollback

select * from produtos
insert into produtos values ('CD',1,1,1)
delete from produtos where prd_descricao = 'CD'
update produtos set prd_descricao = 'lapis de cor'
where prd_codigo = 1


ALTER DATABASE vendas
    SET READ_COMMITTED_SNAPSHOT ON;
    
ALTER DATABASE vendas
	SET ALLOW_SNAPSHOT_ISOLATION ON;


select * from produtos (READUNCOMMITTED)
select * from produtos (READCOMMITTED)
select * from produtos (SERIALIZABLE) 
select * from produtos (REPEATABLEREAD)


select * from produtos(nolock)   -- altera para o modo read uncommitted
select * from produtos(Xlock)    -- altera para o modo exclusivo (seriazable)
select * from produtos(readpast) -- visualiza as linhas não bloqueadas
select * from produtos(holdlock) -- altera o isolamento para repeatable read
