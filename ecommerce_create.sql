SHOW DATABASES;
CREATE DATABASE ecommerce;
USE ecommerce;
SHOW TABLES;
describe cliente;

CREATE TABLE IF NOT EXISTS cliente (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    tipo_cliente 	ENUM('PF', 'PJ'),
    endereco 		VARCHAR(50)
);
ALTER TABLE cliente AUTO_INCREMENT = 1;
-- DROP TABLE cliente; 

CREATE TABLE IF NOT EXISTS cliente_PF (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    nome 			VARCHAR(20),
    sobrenome 		VARCHAR(10),
    endereco 		VARCHAR(50),
    cliente_CPF		CHAR(15),
    telefone 		VARCHAR(18),
    id_cliente		INT,
    CONSTRAINT UNIQUE_cliente_CPF UNIQUE (cliente_CPF),
    CONSTRAINT fk_cliente_PF_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);
ALTER TABLE cliente_PF AUTO_INCREMENT = 1;
-- DROP TABLE cliente_PF;

CREATE TABLE IF NOT EXISTS cliente_PJ (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia 	VARCHAR(50),
    razao_social 	VARCHAR(50),
    cliente_CNPJ 	VARCHAR(30),
    contato 		VARCHAR(30),
    telefone 		VARCHAR(18),
    id_cliente		INT,
    CONSTRAINT UNIQUE_cliente_CNPJ UNIQUE (cliente_CNPJ),
    CONSTRAINT fk_cliente_PJ_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);
ALTER TABLE cliente_PJ AUTO_INCREMENT = 1;
-- DROP TABLE cliente_PJ;
show tables;

CREATE TABLE IF NOT EXISTS produto (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    nome 			VARCHAR(10) NOT NULL,
    descricao 		VARCHAR(25) NOT NULL, 
    preco_unit		DECIMAL(10,2),
    -- classification_kids BOOL DEFAULT FALSE,
    categoria 		ENUM('eletronico', 'vestimenta', 'brinquedo', 'alimento', 'móveis') NOT NULL,
    avaliacao 		INT CHECK (avaliacao BETWEEN 1 and 10) DEFAULT 0,
    tamanho			VARCHAR(10)
);
ALTER TABLE produto AUTO_INCREMENT = 1;
-- DROP TABLE produto;

CREATE TABLE IF NOT EXISTS estoque (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    localizacao 	VARCHAR(255),
    qtde			INT DEFAULT 0 
);
ALTER TABLE estoque AUTO_INCREMENT = 1;
-- DROP TABLE estoque;

CREATE TABLE IF NOT EXISTS	produto_estoque (
	id_produto		INT,
    id_estoque		INT,
    qtde			INT DEFAULT 0,
    CONSTRAINT pk_produto_estoque PRIMARY KEY (id_produto, id_estoque),
    CONSTRAINT fk_produto_estoque_produto FOREIGN KEY (id_produto) REFERENCES produto(id),
    CONSTRAINT fk_produto_estoque_estoque FOREIGN KEY (id_estoque) REFERENCES estoque(id)
);
ALTER TABLE produto_estoque AUTO_INCREMENT = 1;
-- DROP TABLE produto_estoque;

CREATE TABLE IF NOT EXISTS fornecedor (
	id		 		INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia 	VARCHAR(50) NOT NULL, 
    razao_social 	VARCHAR(50) NOT NULL,
    fornecedor_CNPJ CHAR(30) NOT NULL,
    localizacao		VARCHAR(255),
    contato 		VARCHAR(30) NOT NULL,
    telefone		VARCHAR(18), 
    CONSTRAINT UNIQUE_fornecedor UNIQUE (fornecedor_CNPJ)
);
ALTER TABLE fornecedor AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS vendedor_terceirizado (
	id		 		INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia 	VARCHAR(50) NOT NULL, 
    razao_social 	VARCHAR(50) NOT NULL,
    vendedor_CNPJ CHAR(30) NOT NULL,
    localizacao		VARCHAR(255),
    contato 		VARCHAR(30) NOT NULL,
    telefone		VARCHAR(18), 
    CONSTRAINT UNIQUE_vendedor UNIQUE (vendedor_CNPJ)
);
ALTER TABLE vendedor_terceirizado AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS vendedor (
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    nome 			VARCHAR(20),
    sobrenome 		VARCHAR(10),
    endereco 		VARCHAR(50),
    matricula		CHAR(8),
    CONSTRAINT UNIQUE_matricula UNIQUE (matricula)
);
ALTER TABLE vendedor AUTO_INCREMENT = 1;
-- DROP TABLE vendedor;

CREATE	TABLE IF NOT EXISTS pedido (
	id		 		INT AUTO_INCREMENT PRIMARY KEY,
    dt_pedido		DATE,
    frete			DECIMAL(10,2),
    status 			ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
    id_cliente		INT,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
		ON UPDATE CASCADE
        ON DELETE SET NULL
);
ALTER TABLE pedido AUTO_INCREMENT = 1;
-- DROP TABLE pedido;

CREATE TABLE IF NOT EXISTS detalhe_pedido (
	id				INT AUTO_INCREMENT PRIMARY KEY,
    qtde			INT,
    id_pedido		INT,
    id_produto		INT,
    CONSTRAINT fk_detalhe_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    CONSTRAINT fk_detalhe_pedido_produto FOREIGN KEY (id_produto) REFERENCES produto(id)
);
ALTER TABLE detalhe_pedido AUTO_INCREMENT = 1;
-- DROP TABLE detalhe_pedido;

CREATE TABLE IF NOT EXISTS pagamento (
	id				INT AUTO_INCREMENT PRIMARY KEY,
    forma_pgto		ENUM('À vista', 'Cartão Débito', 'Cartão Crédito', 'Boleto', 'Pix'),
    lim_cred_disp	DECIMAL(10,2),
    valor_pgto		DECIMAL(10,2),
    dt_pgto			DATE,
    dt_vecto		DATE,
    desconto_a_vista float,
    min_parc_sem_juros	INT,
    juros_parcelado FLOAT, 
    status			ENUM('atrasado', 'em dia', 'quitado'), 
    id_pedido		INT,
    CONSTRAINT fk_pgto_pedido foreign key (id_pedido) REFERENCES pedido(id)
);
ALTER TABLE pagamento AUTO_INCREMENT = 1;
-- DROP TABLE pagamento;

CREATE TABLE IF NOT EXISTS entrega (
	id				INT AUTO_INCREMENT PRIMARY KEY,
    nome_recebedor	VARCHAR(20),
    cod_rastreio	CHAR(13),
    status			ENUM ('em separacao', 'em trânsito','aguardando retirada', 
                          'devolvido ao remetente', 'extraviado', 'entregue'),
    dt_recebimento	DATETIME,
    id_pedido		INT,
    CONSTRAINT UNIQUE_cod_rastreio UNIQUE (cod_rastreio),
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);
ALTER TABLE entrega AUTO_INCREMENT = 1;
-- DROP TABLE entrega;

CREATE TABLE produto_pedido (
    id_produto		INT,
    id_pedido	    INT,
    CONSTRAINT 		pk_produto_pedido_id PRIMARY KEY (id_produto, id_pedido),
    CONSTRAINT      fk_produto_pedido_produto	FOREIGN KEY (id_produto) REFERENCES produto(id),
    CONSTRAINT      fk_produto_pedido_pedido	FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);
ALTER TABLE produto_pedido AUTO_INCREMENT = 1;
-- DROP TABLE produto_pedido;

CREATE TABLE IF NOT EXISTS fornecedor_produto(
	id_fornecedor 	INT,
    id_produto		INT,
    PRIMARY KEY (id_fornecedor, id_produto),
    CONSTRAINT fk_fornecedor_produto_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id),
    CONSTRAINT fk_fornecedor_produto_produto FOREIGN KEY (id_produto) REFERENCES produto(id)
);
ALTER TABLE fornecedor_produto AUTO_INCREMENT = 1;
-- DROP TABLE fornecedor_produto;