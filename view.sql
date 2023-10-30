CREATE VIEW HistoricoDePedidosCliente AS
SELECT p.ID AS PedidoID, p.DataDoPedido, pr.ID AS ProdutoID, pr.Nome AS NomeDoProduto, i.Quantidade
FROM Pedidos p
JOIN ItensDePedido i ON p.ID = i.PedidoID
JOIN Produtos pr ON i.ProdutoID = pr.ID
WHERE p.Status_Do_Pedido = 'Processado' AND p.ClienteID = 4 ;

SELECT * FROM HistoricoDePedidosCliente;

CREATE VIEW ProdutosDisponiveis AS
SELECT ID, Nome, Descricao, Preco, Quantidade_Estoque
FROM Produtos
WHERE Quantidade_Estoque > 0;

SELECT * FROM ProdutosDisponiveis;