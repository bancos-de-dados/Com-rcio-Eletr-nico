-- Inserir dados na tabela Clientes com o mesmo domínio de e-mail para todos (@raffael.com)
INSERT INTO Clientes (ID, Nome, Endereco_de_Entrega, Email, Celular) VALUES
(1, 'Naruto Uzumaki', '123 Rua da Folha, Aldeia da Folha', 'naruto@raffael.com', 999999999),
(2, 'Sakura Haruno', '456 Rua das Flores, Aldeia da Folha', 'sakura@raffael.com', 999999998),
(3, 'Goku Son', '789 Kame House, Ilha de Kame', 'goku@raffael.com', 999999997),
(4, 'Vegeta Prince', '1 Royal Street, Planeta Vegeta', 'vegeta@raffael.com', 999999996),
(5, 'Natsu Dragneel', 'Fire Dragon Guild, Magnolia Town', 'natsu@raffael.com', 999999995),
(6, 'Erza Scarlet', 'Fairy Tail Guild, Magnolia Town', 'erza@raffael.com', 999999994),
(7, 'Monkey D. Luffy', 'Thousand Sunny, Grand Line', 'luffy@raffael.com', 999999993),
(8, 'Saitama', 'Apt. 303, Z-City', 'saitama@raffael.com', 999999992),
(9, 'Narancia Ghirga', 'Gang Passione Headquarters, Napoli', 'narancia@raffael.com', 999999991),
(10, 'Todoroki Shoto', '1-A Classroom, U.A. High School', 'todoroki@raffael.com', 999999990);

SELECT * FROM Clientes;

-- Inserir dados na tabela Produtos
INSERT INTO Produtos (ID, Nome, Descricao, Preco, Quantidade_Estoque) VALUES
(1, 'Espada Zangetsu', 'Uma espada lendária usada por Ichigo Kurosaki em Bleach.', 500.00, 10),
(2, 'Varinha das Varinhas', 'A varinha mais poderosa do universo mágico de Harry Potter.', 1000.00, 5),
(3, 'Death Note', 'Um caderno que permite que o usuário mate qualquer pessoa apenas escrevendo o nome.', 1500.00, 3),
(4, 'Capsula do Tempo', 'Uma cápsula que pode viajar no tempo no mundo de Dragon Ball.', 2000.00, 2),
(5, 'Chapéu de Palha', 'O icônico chapéu de palha usado por Monkey D. Luffy em One Piece.', 300.00, 15),
(6, 'Colar do Invencível', 'Um colar que confere invencibilidade ao usuário no mundo de RPG.', 800.00, 8),
(7, 'Bala de Goma Gigante', 'Uma bala de goma doce que cresce até o tamanho gigante em segundos.', 50.00, 20),
(8, 'Lança do Destino', 'Uma lança lendária usada por diversos heróis em várias mitologias.', 1200.00, 4),
(9, 'Poção da Invisibilidade', 'Uma poção que torna o usuário invisível por um curto período de tempo.', 700.00, 6),
(10, 'Anel da Vida Eterna', 'Um anel que concede imortalidade a quem o usa, segundo a lenda.', 2000.00, 1);


SELECT * FROM Produtos;