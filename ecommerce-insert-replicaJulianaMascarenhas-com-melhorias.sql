/* **************************************************************
	criando registros para as tabelas

 ***************************************************************** */

INSERT INTO clients (firstName, middleName, lastName, CPF, address, bdate)
VALUES
('João', 'A', 'Silva', '12345678901', 'Rua A, 123', '1990-01-01'),
('Maria', 'B', 'Santos', '23456789012', 'Rua B, 456', '1985-05-15'),
('Pedro', 'C', 'Oliveira', '34567890123', 'Rua C, 789', '2000-10-20'),
('Ana', 'D', 'Costa', '45678901234', 'Rua D, 101', '1995-03-25');

INSERT INTO product (productName, classification_kids, category, avaliacao, size, brand, weight)
VALUES
('Smartphone X', false, 'Eletronicos', 4.5, 'M', 'Marca A', 0.2),
('Camiseta Branca', false, 'Vestimentas', 4.0, 'G', 'Marca B', 0.3),
('Boneco de Ação', true, 'Brinquedos', 4.7, 'P', 'Marca C', 0.5),
('Arroz Integral', false, 'Alimentos', 4.2, '1kg', 'Marca D', 1.0),
('Sofá de Couro', false, 'Móveis', 4.8, 'Grande', 'Marca E', 50.0);

INSERT INTO paymentTypes (typeName)
VALUES
('Boleto'),
('Cartão Débito'),
('Cartão Crédito'),
('Pix');

INSERT INTO orders (idOrdersClient, ordersStatus, ordersDescription, freight, orderDate)
VALUES
(1, 'confirmado', 'Pedido de eletrônicos', 15.00, '2023-10-01 10:00:00'),
(2, 'em processamento', 'Pedido de roupas', 10.00, '2023-10-02 11:00:00'),
(3, 'Cancelado', 'Pedido de brinquedos', 5.00, '2023-10-03 12:00:00'),
(4, 'confirmado', 'Pedido de alimentos', 20.00, '2023-10-04 13:00:00');

INSERT INTO payments (idClient, idPaymentType, idOrder, paymentAmount, paymentDate)
VALUES
(1, 3, 1, 500.00, '2023-10-01 10:30:00'), -- Cartão Crédito
(2, 2, 2, 100.00, '2023-10-02 11:30:00'), -- Cartão Débito
(3, 1, 3, 50.00, '2023-10-03 12:30:00'),  -- Boleto
(4, 4, 4, 200.00, '2023-10-04 13:30:00'); -- Pix

INSERT INTO productStorage (location, quantity, price_unit, lastUpdate, minQuantity)
VALUES
('Estoque A', 100, 500.00, '2023-10-01 09:00:00', 10),
('Estoque B', 200, 50.00, '2023-10-02 09:00:00', 20),
('Estoque C', 50, 30.00, '2023-10-03 09:00:00', 5),
('Estoque D', 300, 10.00, '2023-10-04 09:00:00', 50);

INSERT INTO supplier (socialName, CNPJ, contact)
VALUES
('Fornecedor A', '12345678901234', '11987654321'),
('Fornecedor B', '23456789012345', '21987654321'),
('Fornecedor C', '34567890123456', '31987654321');

INSERT INTO seller (socialName, abstName, CNPJ, CPF, location, contact)
VALUES
('Vendedor A', 'VendA', '12345678901234', '12345678901', 'Local A', '11987654321'),
('Vendedor B', 'VendB', '23456789012345', '23456789012', 'Local B', '21987654321'),
('Vendedor C', 'VendC', '34567890123456', '34567890123', 'Local C', '31987654321');

INSERT INTO productSeller (idPseller, idProduct, prodQuantity)
VALUES
(1, 1, 10), -- Vendedor A vende Smartphone X
(2, 2, 20), -- Vendedor B vende Camiseta Branca
(3, 3, 15); -- Vendedor C vende Boneco de Ação

INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
VALUES
(1, 1, 1, 'Disponivel'), -- Smartphone X no Pedido 1
(2, 2, 2, 'Disponivel'), -- Camiseta Branca no Pedido 2
(3, 3, 3, 'Sem estoque'); -- Boneco de Ação no Pedido 3

INSERT INTO storageLocation (idLproduct, idLstorage, location)
VALUES
(1, 1, 'Estoque A'), -- Smartphone X no Estoque A
(2, 2, 'Estoque B'), -- Camiseta Branca no Estoque B
(3, 3, 'Estoque C'); -- Boneco de Ação no Estoque C

INSERT INTO productSupplier (idSupplier, idProduct, supplyPrice)
VALUES
(1, 1, 450.00), -- Fornecedor A fornece Smartphone X
(2, 2, 40.00),  -- Fornecedor B fornece Camiseta Branca
(3, 3, 25.00);  -- Fornecedor C fornece Boneco de Ação

