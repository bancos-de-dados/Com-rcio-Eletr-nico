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