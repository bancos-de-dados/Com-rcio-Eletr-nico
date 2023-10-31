
# COMÉRCIO ELETRÔNICO

![OIP](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/04d14a04-b832-4024-8f7e-40e38399a9f3)


Você foi designado para criar um sistema de comercio eletronico. Aqui estão os detalhes adicionais:

### Criação da tabela Comercio Eletronico 

## Codigo:

```SQL
-- MySQL Workbench Forward Engineering

-- Tabela Produtos
CREATE TABLE Produtos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    Quantidade_Estoque INT
);



-- Tabela Clientes
CREATE TABLE Clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco_de_Entrega TEXT,
    Email VARCHAR(255),
    Celular INT 
);

-- Tabela Pedidos
CREATE TABLE Pedidos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    DataDoPedido DATE,
    ClienteID INT,
    Status_Do_Pedido VARCHAR(50),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

-- Tabela ItensDePedido
CREATE TABLE ItensDePedido (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(ID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ID)
);



SELECT * FROM Clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;
DELETE FROM pedidos;
SELECT * FROM itensdepedido;
DELETE FROM itensdepedido;

```

Produtos: Armazene informações sobre produtos, como nome, descrição, preço e quantidade em estoque.

![Tabela_Produtos](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/e00569fd-7eb0-47b3-acd2-090c6f73dd41)



Pedidos: Registre detalhes de pedidos, incluindo data, cliente e status.

![Tabela_Pedido](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/8cc70536-7036-44d7-8d20-c7ea9afc9b99)



Clientes: Mantenha informações dos clientes, como nome, endereço de entrega e informações de contato.

![Tabela_Clientes](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/f8ab5a1e-f2a9-473f-8ccc-a31e59755b4b)




Itens de Pedido: Registre os produtos incluídos em cada pedido, junto com a quantidade.

![Tabela_Pedido](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/69ddbf39-97e1-48d9-9cfc-4115efc6f781)




# Relacionamentos:

Crie um relacionamento entre "Pedidos" e "Clientes" para rastrear os pedidos de cada cliente.

``` SQL
    -- Tabela Pedidos
CREATE TABLE Pedidos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    DataDoPedido DATE,
    ClienteID INT,
    Status_Do_Pedido VARCHAR(50),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

```

Estabeleça um relacionamento entre "Itens de Pedido" e "Produtos" para associar produtos a pedidos.

``` SQL
-- Tabela ItensDePedido
CREATE TABLE ItensDePedido (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(ID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ID)
);

```

# Stored Procedures:

Implemente uma stored procedure para permitir que os clientes adicionem produtos ao carrinho de compras.


```SQL
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
```
![Tabela_itens_pedidos](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/44895ef6-97ac-4f99-abcb-d7142ba8834e)


Crie uma stored procedure para processar pedidos, atualizando o estoque de produtos e registrando os detalhes do pedido.


```SQL
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

```

![call_ProcessarPedido](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/31c44489-ee03-488f-90b6-421619bd0755)

Desenvolva uma stored procedure para calcular o total de um pedido com base nos produtos incluídos.

```SQL

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

```

![Tabela_Pedido](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/76c71424-2c32-4ff0-ba94-946f95b57d49)


# Views:

Crie uma view que mostre o histórico de pedidos de um cliente específico, incluindo os produtos incluídos em cada pedido.

```SQL

CREATE VIEW HistoricoDePedidosCliente AS
SELECT p.ID AS PedidoID, p.DataDoPedido, pr.ID AS ProdutoID, pr.Nome AS NomeDoProduto, i.Quantidade
FROM Pedidos p
JOIN ItensDePedido i ON p.ID = i.PedidoID
JOIN Produtos pr ON i.ProdutoID = pr.ID
WHERE p.Status_Do_Pedido = 'Processado' AND p.ClienteID = 4 ;

```
![view_clientes](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/f82c4c99-158a-438b-9d64-c1b4373abcd3)


Implemente uma view que forneça uma lista de todos os produtos disponíveis.

```SQL

CREATE VIEW ProdutosDisponiveis AS
SELECT ID, Nome, Descricao, Preco, Quantidade_Estoque
FROM Produtos
WHERE Quantidade_Estoque > 0;

```
![view_clientes](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/68b78324-2937-4b9c-914c-be02587ad61c)


![logo-maker-featuring-aliens-and-robots-2367-el1](https://github.com/bancos-de-dados/Com-rcio-Eletr-nico/assets/127689567/96d142cd-2b5c-409d-9ba1-ce5a2a665972)
