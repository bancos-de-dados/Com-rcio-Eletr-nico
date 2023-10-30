DELIMITER $

CREATE PROCEDURE AdicionarProdutoAoCarrinho(
    IN cliente_id INT,
    IN produto_id INT,
    IN quantidade INT
)
BEGIN
    DECLARE pedido_id INT;
    
    -- Verificar se o cliente já tem um carrinho ativo
    SELECT ID INTO pedido_id
    FROM Pedidos
    WHERE ClienteID = cliente_id AND Status_Do_Pedido = 'Carrinho';
    
    -- Se não houver um carrinho ativo, criar um novo
    IF pedido_id IS NULL THEN
        INSERT INTO Pedidos (ClienteID, DataDoPedido, Status_Do_Pedido)
        VALUES (cliente_id, NOW(), 'Carrinho');
        SET pedido_id = LAST_INSERT_ID();
    END IF;
    
    -- Adicionar produto ao carrinho (tabela ItensDePedido)
    INSERT INTO ItensDePedido (PedidoID, ProdutoID, Quantidade)
    VALUES (pedido_id, produto_id, quantidade);
    
END$

DELIMITER ;

DELIMITER $

CREATE PROCEDURE ProcessarPedido(
    IN pedido_id INT
)
BEGIN
    -- Atualizar status do pedido para "Processado" e definir a data do pedido
    UPDATE Pedidos
    SET Status_Do_Pedido = 'Processado', DataDoPedido = NOW()
    WHERE ID = pedido_id;
    
    -- Atualizar o estoque de produtos com base nos itens do pedido
    UPDATE Produtos AS p
    JOIN ItensDePedido AS i ON p.ID = i.ProdutoID
    SET p.Quantidade_Estoque = p.Quantidade_Estoque - i.Quantidade
    WHERE i.PedidoID = pedido_id;
    
END$

DELIMITER ;

DELIMITER $

CREATE PROCEDURE CalcularTotalPedido(
    IN pedido_id INT,
    OUT total DECIMAL(10, 2)
)
BEGIN
    -- Calcular o total do pedido com base nos produtos incluídos
    SELECT SUM(p.Preco * i.Quantidade) INTO total
    FROM Produtos AS p
    JOIN ItensDePedido AS i ON p.ID = i.ProdutoID
    WHERE i.PedidoID = pedido_id;
    
END$

DELIMITER ;

DELIMITER $

CREATE PROCEDURE CalcularTotalPedido(
    IN pedido_id INT
)
BEGIN
    SELECT SUM(p.Preco * i.Quantidade) AS TotalPedido
    FROM Produtos AS p
    JOIN ItensDePedido AS i ON p.ID = i.ProdutoID
    WHERE i.PedidoID = pedido_id;
END$

DELIMITER ;


