CALL AdicionarProdutoAoCarrinho(1, 3, 2);
CALL AdicionarProdutoAoCarrinho(4, 7, 4);
CALL AdicionarProdutoAoCarrinho(4, 1, 2);
CALL AdicionarProdutoAoCarrinho(6, 2, 4);
CALL AdicionarProdutoAoCarrinho(2, 4, 2);
CALL AdicionarProdutoAoCarrinho(5, 6, 4);
CALL AdicionarProdutoAoCarrinho(3, 2, 2);
CALL AdicionarProdutoAoCarrinho(3, 5, 4);
CALL AdicionarProdutoAoCarrinho(6, 6, 2);
CALL AdicionarProdutoAoCarrinho(1, 1, 4);
CALL AdicionarProdutoAoCarrinho(8, 10, 1);
-- Adiciona 2 unidades do produto com ID 3 ao carrinho do cliente com ID 1


CALL ProcessarPedido (1);
CALL ProcessarPedido (2);
CALL ProcessarPedido (3);
CALL ProcessarPedido (4);
CALL ProcessarPedido (5);
CALL ProcessarPedido (6);
CALL ProcessarPedido (7);
CALL ProcessarPedido (8);

CALL CalcularTotalPedido(4);
