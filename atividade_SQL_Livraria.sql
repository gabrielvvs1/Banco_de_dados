create database Livraria;
create table livros (
	id_livro int,
    titulo varchar(50),
    autor varchar(30),
    ano_publicacao int,
    preco int,
    quantidade_estoque int
    );

insert into livros (id_livro, titulo, autor, ano_publicacao, preco, quantidade_estoque)
values (1, 'Introducao ao SQL', 'Joao silva', 2015, 50, 10); -- passando os valores do livro1

insert into livros (id_livro, titulo, autor, ano_publicacao, preco, quantidade_estoque)
values (2, 'Mastering SQL', 'Maria Souza', 2018, 120, 10); -- passando os valores do livro2

insert into livros (id_livro, titulo, autor, ano_publicacao, preco, quantidade_estoque)
values (3, 'SQL para Iniciantes', 'Paulo Santos', 2020, 75, 8); -- passando os valores do livro3

select  titulo, autor, preco from livros;
select titulo, ano_publicacao from livros where ano_publicacao >= 2018;
select titulo, preco from livros where preco >60 and preco <100;
select titulo, quantidade_estoque from livros where quantidade_estoque <10;

SET SQL_SAFE_UPDATES = 0; -- desabilita o modo de segurança para que o update possa ser realizado
update livros set preco = 80  where titulo = 'SQL para Iniciantes';
update livros set quantidade_estoque = 15  where titulo = 'Introducao ao SQL';

delete from livros where titulo = 'Mastering SQL';

select sum(quantidade_estoque * preco)
from livros;

select max(preco)
from livros;


