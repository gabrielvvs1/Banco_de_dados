-- aula 16-9

-- banco de dados da loja
create database loja; 

-- criar tabela cliente com restriçoes
create table Cliente (
	cliente_id int unsigned auto_increment primary key,
    nome varchar(100) not null,
    email varchar(150) not null unique,
    endereco varchar(100) not null,
    data_nascimento date not null check (data_nascimento > '1900-01-01'),
    status enum ('ativo', 'inativo') not null default 'ativo'
    );

select *from cliente;

-- criar tabela pedido com restriçoes
create table Pedido(
	pedido_id int unsigned auto_increment primary key,
    cliente_id int unsigned not null,
    data_pedido date not null check (data_pedido > '1900-01-01'),
    valor_total decimal(10,2) not null default 0,  -- se nao tiver valor, o valor padrao sera '0'
    status enum('pendente', 'processado' , 'enviado', 'entregue') not null default 'pendente',
    foreign key (cliente_id) references Cliente (cliente_id) on delete cascade, -- importa a chave cliente que eh estrangeira, vincula a mesma , e caso o cliente seja excluido o pedido tb, sera feito via 'cascata'
    index (cliente_id) -- para fazer uma busca rapida
);

select *from pedido;

-- realiza as inserçoes de dados
insert into Cliente (nome, email, endereco, data_nascimento, status)
values
('Joao Silva', 'joao.silva@email.com' , 'Rua A', '1985-12-15', 'ativo'),
('Maria Oliveira' , 'mariooliveira@email.com', 'Rua B', '1990-12-22', 'ativo'),
('Carlos Souza', 'carlos.souza@email.com', 'Rua C', '1978-03-30' , 'inativo');
    
insert into Pedido (cliente_id, data_pedido, valor_total, status)
values
(1, '2024-09-10', 150.75, 'processado'),
(2, '2024-09-11', 299.99, 'enviado'),
(3, '2024-09-12' , 50.00, 'pendente');

select *from pedido;

-- consultar todos os cliente cadastrados
select *from Cliente ;

-- consultar os pedidos feitos por um cliente especifico
select pedido_id, data_pedido, valor_total, status
from pedido
where cliente_id = 1;

-- listar todos os clientes que estao com o status ativo
select nome, status 
from cliente
where status = 'ativo';

-- listar todos os pedidos feitos em um intervalo de datas (ex. entre 10 de setembro  de 2024 e 12 de dezembro de 2024
select pedido.pedido_id, pedido.data_pedido, pedido.valor_total, pedido.status,
cliente.nome, cliente.email
from pedido
inner join cliente on pedido.cliente_id = cliente.cliente_id  -- junta as duas tabelas 'pedido e cliente'
where pedido.data_pedido between '2024-09-10' and '2024-12-12';

-- consultar clientes que fizeram pedido de valor total de maior que 200,00
select cliente.nome, pedido.valor_total
from cliente
inner join pedido on cliente.cliente_id = pedido.cliente_id
where pedido.valor_total>200.00;

-- consultar os pedidos mais recentes
select pedido.cliente_id, pedido.data_pedido
from pedido
order by pedido.data_pedido desc -- O desc pega do mais novo para o mais antigo   -- asc pega o mais velho para o mais novo
limit 3; -- o limit pega o mais recente 

-- listar todos os pedidos com informaçoes detalhadas do cliete (nome e email)


-- listar todos os clientes que fizeram pedidos com status 'enviado', retornando o nome e email

SET SQL_SAFE_UPDATES = 0;

-- alterar o status cliente 'Carlos Souza'
update cliente set status = 'ativo' where cliente_id = 3;

-- alterar o status do pedido do cliente 'Carlos Souza' para 'enviado'
update pedido set status = 'enviado' where cliente_id = 3;

-- excluir o pedido de 'Joao Silva' 
delete from pedido where cliente_id = 1;