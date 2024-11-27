use p2Marinke;

INSERT INTO cliente (id_cliente, nome_cliente, cpf_cliente)
VALUES
(1, 'João Silva', '123.456.789-00'),
(2, 'Maria Oliveira', '234.567.890-11'),
(3, 'Carlos Souza', '345.678.901-22'),
(4, 'Ana Lima', '456.789.012-33'),
(5, 'Pedro Santos', '567.890.123-44');

INSERT INTO funcionario (id_funcionario, nome_funcionario)
VALUES
(1, 'Fernando Almeida'),
(2, 'Juliana Rocha'),
(3, 'Ricardo Costa'),
(4, 'Paula Ferreira'),
(5, 'Lucas Moreira');

INSERT INTO mesa (id_mesa, numero_mesa, status_mesa, id_cliente)
VALUES
(1, 101, 'Livre', 4),
(2, 102, 'Ocupada', 1),
(3, 103, 'Livre', 5),
(4, 104, 'Sobremesa', 2),
(5, 105, 'Ocupada-Ociosa', 3);

INSERT INTO produto (id_produto, descricao_produto, preco_produto, quantidadeEstoque)
VALUES
(1, 'Hambúrguer', 12.50, 50),
(2, 'Pizza', 30.00, 20),
(3, 'Refrigerante', 5.00, 100),
(4, 'Suco Natural', 7.50, 30),
(5, 'Batata Frita', 10.00, 40);

INSERT INTO pedido (id_pedido, formaPagamento, total_pedido, id_pedido_mesa, id_pedido_cliente)
VALUES
(1, 'Crédito', 50.00, 2, 1),
(2, 'Dinheiro', 75.00, 4, 2),
(3, 'Débito', 35.00, 5, 3),
(4, 'PIX', 20.00, 2, 1),
(5, 'Dinheiro', 15.00, 4, 2);

INSERT INTO itens_pedido (id_item_pedido, quantidade, total, id_itens_pedido, id_itens_produto)
VALUES
(1, 2, 25.00, 1, 1),
(2, 1, 30.00, 1, 2),
(3, 3, 15.00, 2, 3),
(4, 1, 10.00, 3, 5),
(5, 2, 15.00, 5, 3);

INSERT INTO atendimento (id_atendimento, id_atendimento_funcionario, id_atendimento_mesa)
VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 5),
(4, 4, 2),
(5, 5, 4);

-- 2. a-) 

SELECT 
    f.nome_funcionario AS Nome_Funcionario,
    m.numero_mesa AS Numero_Mesa,
    SUM(p.total_pedido) AS Total_Gasto
FROM 
    atendimento a
INNER JOIN funcionario f ON a.id_atendimento_funcionario = f.id_funcionario
INNER JOIN mesa m ON a.id_atendimento_mesa = m.id_mesa
INNER JOIN pedido p ON p.id_pedido_mesa = m.id_mesa
GROUP BY f.nome_funcionario, m.numero_mesa;

-- b-)
SELECT 
    m.numero_mesa AS Numero_Mesa,
    pr.descricao_produto AS Produto,
    ip.quantidade AS Quantidade,
    ip.total AS Total
FROM 
    pedido p
INNER JOIN itens_pedido ip ON p.id_pedido = ip.id_itens_pedido
INNER JOIN produto pr ON ip.id_itens_produto = pr.id_produto
INNER JOIN mesa m ON p.id_pedido_mesa = m.id_mesa
WHERE 
    m.numero_mesa = '102'; 
    
-- c-)
DELIMITER $$

CREATE PROCEDURE RedefinirStatusMesa(IN p_id_mesa INT)
BEGIN
    UPDATE mesa
    SET status_mesa = 'Livre'
    WHERE id_mesa = p_id_mesa;
END$$

DELIMITER ;

CALL RedefinirStatusMesa(3);
select * from mesa;