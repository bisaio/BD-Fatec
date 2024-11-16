SELECT * FROM tb_itens

BEGIN TRANSACTION T0;
PRINT (@@TRANCOUNT)

INSERT INTO tb_itens VALUES ('item da T0', 1)

SELECT * FROM tb_itens

SAVE TRANSACTION T1;
PRINT(@@TRANCOUNT) --continua com 1, pq apenas quebra a primeira transac.

INSERT INTO tb_itens VALUES ('item da T1', 1)

SELECT * FROM tb_itens

SAVE TRANSACTION T2;
PRINT(@@TRANCOUNT) --continua com 1, pq apenas quebra a primeira transac.

INSERT INTO tb_itens VALUES ('item da T2', 1)

SELECT * FROM tb_itens

ROLLBACK TRANSACTION T2; -- cancela a operação feita em T2

SELECT * FROM tb_itens -- tira o item T2 e mantem o T0 e T1 // e transaction continua aberta

COMMIT TRANSACTION T1; -- confirmou a operação feita em T1

SELECT * FROM tb_itens -- mantem as ações da T1 e fecha a TRANSACTION