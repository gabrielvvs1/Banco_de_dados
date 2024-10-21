-- 21/10 store procedure (procedimento armazenado) -- funçoes dentro do banco de dados

create database loja2;

create table Cliente(
	idCliente int auto_increment primary key,
    nome varchar(100),
    email varchar(100),
    dataRegistro date
    );

-- criar uma procedure
DELIMITER //
CREATE PROCEDURE Helloworld()
BEGIN
	SELECT "OLA MUNDO!!" as Mensagem;
END //
DELIMITER ;

-- chamar a procedure
CALL Helloworld;

-- ###################################
-- Inserir CLiente
DELIMITER //
CREATE PROCEDURE InserirCliente(
	IN p_nome varchar(100),
    IN p_email varchar(100),
    IN dataRegistro date
)
BEGIN
	INSERT INTO Cliente (nome, email, dataRegistro)
    VALUES(p_nome, p_email, p_dataRegistro);
END //
DELIMITER ;

CALL InserirCliente('Fulano Silva', 'fulano@email.com', '2024/10/21'); -- nao rodou
select *from cliente; 

--#####################################
-- Atualiza os dados dos clientes
DELIMITER //
CREATE PROCEDURE AtualizarCliente(
	IN p_idCliente int,
	IN p_nome varchar(100),
    IN p_email varchar(100)
)
BEGIN
	UPDATE cliente
    SET nome = p_nome, email = p_email
    WHERE idCliente = p_idCliente;
END //
DELIMITER ;

CALL InserirCliente('Ciclano', 'ciclano@email', '2024-10-21');
SELECT * from cliente;

CALL AtualizarCliente(2, 'Ciclano Carvalho', 'ciclano.carvalho@email'); -- atualizando os dados do ciclano pelo ID

-- ##################################
-- Buscar um Cliente
DELIMITER // 
CREATE PROCEDURE BuscarCliente(
	IN p_idCliente int,
    OUT p_nome varchar(100)
)
BEGIN 
	SELECT nome INTO  p_nome
    FROM cliente
    WHERE idCliente = p_idCliente;
END // 
DELIMITER ;

-- chamar a procedure
-- criar variavel 
SET @nomeCliente = ' ';
CALL BuscarCLiente(2, @nome); -- busca o cliente pelo ID 2, e retorna o nome
SELECT @nomeCliente;

-- ###########################
-- Exclui o cliente: O USUARIO PASSE O ID
DELIMITER //
CREATE PROCEDURE ExcluirCliente(
	IN p_idCliente int
)
BEGIN
	Delete from  cliente
    WHERE idCliente = p_idCliente;
END //
DELIMITER ;

-- chamar a procedure
CALL ExcluiCliente(2); -- exclui o cliente 2
select * from cliente;


-- ###########################
-- Exibi a quantidade de clientes -- procedure de saida
DELIMITER //
CREATE PROCEDURE ObterTotalCliente(
	OUT p_totalClientes int
)
BEGIN
	SELECT COUNT(*) INTO p_totalCliente
    FROM cliente;
END //
DELIMITER ;

-- variavel
SET @totalClientes = 0;
CALL ObterTotalCliente(@totalClientes);
select @totalClientes;






















