CREATE DATABASE ecommerce;
SHOW DATABASES;
-- criar tabela cliente
CREATE TABLE IF NOT EXISTS clients(
    idclient 		INT AUTO_INCREMENT PRIMARY KEY,
    firstName 		VARCHAR(20),
    middleName 		CHAR(3),
    lastName		VARCHAR(20),
    CPF			CHAR(11) NOT NULL,
    address 		VARCHAR(100),
    bdate		DATE,
    CONSTRAINT UNIQUE_cpf_client UNIQUE (CPF)
);
-- DROPT TABLE client;
DESC clients;

-- criar tabela product
--   size = dimensão do produto
CREATE TABLE IF NOT EXISTS product(
    idproduct 		INT AUTO_INCREMENT PRIMARY KEY,
    productName 	VARCHAR(20) NOT NULL,
    classification_kids BOOL DEFAULT false, 
    category 		ENUM('Eletronicos', 'Vestimentas', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    avaliacao 		INT DEFAULT 0,
    size 		VARCHAR(10),
    brand		VARCHAR(30),
    weight		FLOAT
);
DESC product;

-- tabela com tipo de pagamento
CREATE TABLE IF NOT EXISTS paymentTypes (
    idPaymentType 	INT AUTO_INCREMENT PRIMARY KEY,
    typeName 		VARCHAR(50) NOT NULL UNIQUE -- Ex: 'Boleto', 'Cartão Débito', 'Cartão Crédito', 'Pix'
);

-- criar tabela payments
CREATE TABLE IF NOT EXISTS payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    idPaymentType INT,
    idOrder INT, -- Novo campo para vincular ao pedido
    paymentAmount DECIMAL(10, 2), -- Valor do pagamento
    paymentDate DATETIME, -- Data e hora do pagamento
    CONSTRAINT fk_payments_client FOREIGN KEY (idClient) REFERENCES clients(idclient)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_payments_paymentType FOREIGN KEY (idPaymentType) REFERENCES paymentTypes(idPaymentType)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_payments_order FOREIGN KEY (idOrder) REFERENCES orders(idOrders)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
DESC payments;


-- criar tabela order
CREATE TABLE IF NOT EXISTS orders(
    idOrders 		INT AUTO_INCREMENT PRIMARY KEY,
    idOrdersClient 	INT,
    ordersStatus 	ENUM('Cancelado', 'confirmado','em processamento') DEFAULT 'em processamento',
    ordersDescription 	VARCHAR(255),
    freight 		FLOAT DEFAULT 10,
    orderDate		DATETIME,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrdersClient)REFERENCES clients(idclient)
);
SHOW TABLES;

-- criar tabela estoque
CREATE TABLE IF NOT EXISTS productStorage(
    idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    location 		VARCHAR(255),
    quantity		INT DEFAULT 0,
    price_unit		DECIMAL(10,2),
    lastUpdate		DATETIME,
    minQuantity		INT DEFAULT 10
);
-- criar tabela fornecedor
CREATE TABLE IF NOT EXISTS supplier(
    idSupplier 		INT AUTO_INCREMENT PRIMARY KEY,
    socialName 		VARCHAR(255) NOT NULL,
    CNPJ		CHAR(14) NOT NULL,
    contact		VARCHAR(15) NOT NULL,
    CONSTRAINT  UNIQUE_supplier	UNIQUE (CNPJ) 
);
-- criar tabela vendedor
CREATE TABLE IF NOT EXISTS seller(
    idSeller 		INT AUTO_INCREMENT PRIMARY KEY,
    socialName 		VARCHAR(255) NOT NULL,
    abstName		VARCHAR(255) NOT NULL,
    CNPJ		CHAR(14) NOT NULL,
    CPF			CHAR(11) NOT NULL,
    location		VARCHAR(255),
    contact		VARCHAR(15) NOT NULL,
    CONSTRAINT  UNIQUE_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT  UNIQUE_cpf_seller  UNIQUE (CPF)
);
-- tabela produto_fornecedor
CREATE TABLE productSeller(
    idPseller 		INT,
    idProduct 		INT,
    prodQuantity	INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idseller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
-- tabela produto_pedido
CREATE TABLE productOrder(
    idPOproduct 	INT,
    idPOorder		INT,
    poQuantity		INT DEFAULT 1,
    poStatus 		ENUM('Disponivel','Sem estoque') DEFAULT 'Disponivel',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productOrder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrders)
);
-- tabela produto_localizacao
CREATE TABLE storageLocation(
    idLproduct		INT,
    idLstorage		INT,
    location 		VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storageLocation_product FOREIGN KEY (idLproduct) REFERENCES product (idProduct),
    CONSTRAINT fk_storageLocation_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProductStorage)
);
-- tabela de relacionamento entre produto e fornecedor
CREATE TABLE IF NOT EXISTS productSupplier (
    idSupplier INT,
    idProduct INT,
    supplyPrice DECIMAL(10, 2), -- Preço de fornecimento
    PRIMARY KEY (idSupplier, idProduct),
    CONSTRAINT fk_productSupplier_supplier FOREIGN KEY (idSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_productSupplier_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);