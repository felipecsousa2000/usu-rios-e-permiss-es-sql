-- Teste 6 · Agora como gerente

-- Permitido: o gerente tem UPDATE
UPDATE produto SET preco = 13.50 WHERE id = 1;
 
-- Permitido: farmacia_seg.* inclui funcionario
SELECT nome, cargo, salario FROM funcionario;
 
-- Bloqueado: o gerente não tem DELETE
DELETE FROM produto WHERE id = 5;

