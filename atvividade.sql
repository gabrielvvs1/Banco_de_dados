create database Loja;

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY, 
    nome_categoria VARCHAR(100) NOT NULL
);


CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY, 
    nome_produto VARCHAR(100) NOT NULL, 
    preco DECIMAL(8, 2) CHECK (preco >= 0), 
    quantidade_estoque INT CHECK (quantidade_estoque >= 0), 
    id_categoria INT, 
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria) 
);

INSERT INTO Categoria (nome_categoria) 
VALUES
('Roupas Esportivas'),
('Equipamentos de Futebol'),
('Acessórios de Treino');

INSERT INTO Produto (nome_produto, preco, quantidade_estoque, id_categoria) 
VALUES
('Camisa de Futebol', 89.90, 100, 2), 
('Tênis de Corrida', 299.99, 50, 1),
('Faixa de Cabeça', 25.00, 200, 3); 

SELECT p.nome_produto, p.preco, p.quantidade_estoque, c.nome_categoria
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria;

SELECT p.nome_produto, p.preco, p.quantidade_estoque
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria
WHERE c.nome_categoria = 'Equipamentos de Futebol';

SELECT c.nome_categoria
FROM Produto p
JOIN Categoria c ON p.id_categoria = c.id_categoria
GROUP BY c.nome_categoria
HAVING SUM(p.quantidade_estoque) > 50;

UPDATE Produto
SET preco = 279.99
WHERE nome_produto = 'Tênis de Corrida';


INSERT INTO Categoria (nome_categoria) VALUES ('Calçados Esportivos');

UPDATE Produto
SET id_categoria = (SELECT id_categoria FROM Categoria WHERE nome_categoria = 'Calçados Esportivos')
WHERE nome_produto = 'Tênis de Corrida';

DELETE FROM Produto
WHERE nome_produto = 'Faixa de Cabeça';










