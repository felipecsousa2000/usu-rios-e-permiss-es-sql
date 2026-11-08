SELECT VERSION();

SHOW VARIABLES LIKE 'validate_passwprd%';

-- Banco da farmácia (rode como root)
CREATE DATABASE farmacia_seg;
USE farmacia_seg;
 
-- Produtos: todos os funcionários podem ver
CREATE TABLE produto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  preco DECIMAL(7,2) NOT NULL,
  estoque INT NOT NULL
);
 
-- Funcionários: tem salário, é dado sensível
CREATE TABLE funcionario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  cargo VARCHAR(30) NOT NULL,
  salario DECIMAL(8,2) NOT NULL
);
 
INSERT INTO produto (nome, preco, estoque) VALUES
  ('Dipirona 500mg', 12.90, 40),
  ('Protetor solar FPS 50', 59.90, 15),
  ('Vitamina C', 24.50, 30),
  ('Álcool em gel', 9.90, 60),
  ('Termômetro digital', 34.00, 8);
 
INSERT INTO funcionario (nome, cargo, salario) VALUES
  ('Renata Lopes', 'Gerente', 6200.00),
  ('Caio Mendes', 'Atendente', 2300.00),
  ('Paula Reis', 'Farmacêutica', 5100.00);
  
  SELECT * FROM produto;
  
  SELECT * FROM funcionario;
  
  -- Passo 1 · Ver quem já existe
  SELECT user, host FROM mysql.user;
  
  -- Passo 2 · Quem sou eu agora?
  SELECT CURRENT_USER();
  
  -- Passo 3 · Criar o usuário atendente
  -- Cria o usuário e define a senha dele
CREATE USER 'atendente'@'localhost'
IDENTIFIED BY 'Atend@2026';

-- Passo 4 · O que o atendente pode fazer?
-- Lista as permissões de um usuário
SHOW GRANTS FOR 'atendente'@'localhost';

-- Passo 5 · Dar permissão: GRANT
-- GRANT permissão ON onde TO quem
GRANT SELECT ON farmacia_seg.produto
TO 'atendente'@'localhost';
 
SHOW GRANTS FOR 'atendente'@'localhost';


-- Passo 6 · Um usuário com mais permissões: o gerente
-- Gerente: consulta, cadastra e altera, mas não apaga
CREATE USER 'gerente'@'localhost'
IDENTIFIED BY 'Geren@2026';
 
-- Várias permissões: separe com vírgula
GRANT SELECT, INSERT, UPDATE ON farmacia_seg.*
TO 'gerente'@'localhost';
 
SHOW GRANTS FOR 'gerente'@'localhost';



-- Só depois
-- Passo 7 · Tirar uma permissão: REVOKE
-- REVOKE permissão ON onde FROM quem
REVOKE UPDATE ON farmacia_seg.*
FROM 'gerente'@'localhost';


-- Passo 8 · Trocar a senha
-- Senha vazou? Troque na hora
ALTER USER 'atendente'@'localhost'
IDENTIFIED BY 'Nova@Senha26';

-- Passo 9 · Bloquear sem apagar
-- Funcionário de férias: bloqueia a conta
ALTER USER 'atendente'@'localhost' ACCOUNT LOCK;
 
-- Voltou: desbloqueia
ALTER USER 'atendente'@'localhost' ACCOUNT UNLOCK;



  
