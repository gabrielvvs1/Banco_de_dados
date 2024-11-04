-- aula 4/11 trigger

-- tabela de log para registrar todas as alerações feitas na tabela cliente
create table cliente_log (
	logID INT auto_increment primary key,
    clienteID int,
    acao varchar(20), -- insert, update, dalete
    nomeAntigo varchar(100),
    nomeNovo varchar (100),
    dataAlteracao timestamp default current_timestamp -- retorna a data e a hora atual do momento em que foi realizada a açao
);

-- trigger para a inserção de dados
DELIMITER // 
CREATE TRIGGER logInsercaoClientes
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
END //
DELIMITER ;
	-- instruçoes
    INSERT INTO clienteINTO cliente_log (clienteID, acao, nomeAntigo, nomeNovo)
    VALUES (new.idCliente, 'INSERT', NULL, new.nome);
END // 
DELIMITER ;

-- inserir um clinte

CALL InserirCliente('Bob', 'bob@email.com', '2024-11-04');
select * from cliente;
select * from cliente_log;

-- trigger para atualização
DELIMITER //
CREATE TRIGGER LogAtualizacaoClientes
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
	INSERT INTO clienteINTO cliente_log (clienteID, acao, nomeAntigo, nomeNovo)
    VALUES (old.idcliente, 'UPDATE' , old.namecliente_log, new.name);
END // 
DELIMITER ;

-- atualizando um cliente na tabela
CALL AtualizarCliente(4, 'Bob Silva', 'bob@email.com');
SELECT * from cliente;
SELECT * from clente_log;

-- criar trigger para a exclusao de algum registro
DELIMITER //
CREATE TRIGGER LogExclusaoClientes
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
	INSERT INTO clienteINTO cliente_log (clienteID, acao, nomeAntigo, nomeNovo)
    VALUES (old.idcliente, 'DELETE' , old.name, NULL);
END // 
DELIMITER ;
-- remover algum cliente cadastrado
select * from cliente;
CALL ExcluirCliente(4);
SELECT  * from cliente_log; -- registro da tabela cliente_log

-- Before, criar uma triger para validar a inserção, no qual o nome do cliente precisa começar com letra maiuscula
DELIMITER // 
CREATE TRIGGER validarNomeCliente
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
END //
DELIMITER ;
	-- instruçoes
    INSERT INTO clienteINTO cliente_log (clienteID, acao, nomeNovo) -- != UPPER(LEFT(NEW.nome_cliente
    VALUES (new.idCliente, 'INSERT', NULL, new.nome);
END // 
DELIMITER ;








