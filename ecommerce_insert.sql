use ecommerce;
show tables;
-- desc cliente;
-- table cliente (id, tipo_cliente, endereco)
INSERT INTO cliente (tipo_cliente, endereco) VALUES 
	("PF", "Endereço cliente A"),
    ("PF", "Endereço cliente B"),
    ("PJ", "Endereço cliente C"),
    ("PJ", "Endereço cliente D");
SELECT * FROM cliente;

-- table cliente_PF (id, nome, sobrenome, endereco, cliente_CPF, telefone, id_cliente)
INSERT INTO cliente_PF (nome, sobrenome, endereco, cliente_CPF, telefone) VALUES 
   ("cliente A", "surname", "end. cliente A", " 111.111.111-11","11 (11) 11111.1111"),
   ("cliente B", "surname", "end. cliente B", " 222.222.222-22","22 (22) 22222.2222");
SELECT * FROM cliente_PF;
-- DELETE FROM cliente_PF WHERE id=3 OR id=4;

-- table cliente_PJ (id, nome_fantasia, razao_social, cliente_CNPJ, contato, telefone, id_cliente)
INSERT INTO cliente_PJ (nome_fantasia, razao_social, cliente_CNPJ, contato, telefone, id_cliente) VALUES
	("cliente C", "razão social C", "11.111.111/0001-11", "contato pj 1", "11 (11) 1111-1111", 3),
    ("cliente D", "razão social D", "22.222.222/0002-22", "contato pj 2", "22 (22) 22222-2222", 4);
SELECT * FROM cliente_PJ;

-- table detalhe_pedido (id, qtde, id_pedido, id_produto)
INSERT INTO detalhe_pedido (qtde, id_pedido, id_produto) VALUES 
  (2, 1, 1),
  (1, 1, 2),
  (1, 2, 1),
  (3, 3, 3),
  (2, 4, 5),
  (5, 5, 3);
SELECT * FROM detalhe_pedido;

-- table entrega (id, nome_recebedor, cod_rastreio, status, dt_recebimento, id_pedido)
INSERT INTO entrega(nome_recebedor, cod_rastreio, status, dt_recebimento, id_pedido) VALUES
 ("nome do recebedor 1", "1234567890123", "entregue", "2024-10-24",2),
 (NULL, "2345678901231", "em trânsito", NULL,1),
 (NULL, "3456789012312", "devolvido ao remetente", "2024-10-20",3),
 (NULL, "4567890123123", "em separacao", "2024-12-20",4);
 UPDATE entrega SET dt_recebimento = NULL; 
SELECT * FROM entrega;

-- table estoque(id, localizacao, qtde)
INSERT INTO estoque(localizacao, qtde) VALUES 
   ("Rua A, 123, SP, SP", 200),
   ("Rua A, 123, SP, SP", 250),
   ("Rua B, 45, Campinas, SP", 100),
   ("Rua C, 67, São José dos Campos, SP", 300),
   ("Rua D, 89, Curitiba, PR", 240),
   ("Rua E, 101, Ribeirão Preto, SP", 180),
   ("Rua F, 102, Marilia, SP", 220);
desc estoque;
SELECT * FROM estoque;

-- table fornecedor(id, nome_fantasia, razao_social, fornecedor_CNPJ, localizacao, contato, telefone)
INSERT INTO fornecedor(nome_fantasia, razao_social, fornecedor_CNPJ, localizacao, contato, telefone) VALUES
 --  ("fornecedor nome fantasia 1", "razao social 1", "11.111.111/0001-11", "localização 1", "contato 1", "11(11) 11111.1111");
   ("fornecedor nome fantasia 2", "razao social 2", "22.222.222/0002-22", "localização 2", "contato 2", "22(22) 22222.2222"),
   ("fornecedor nome fantasia 3", "razao social 3", "33.333.333/0003-33", "localização 3", "contato 3", "33(33) 33333.3333");
SELECT * FROM fornecedor;

-- table fornecedor_produto (id_fornecedor, id_produto)
INSERT INTO fornecedor_produto(id_fornecedor, id_produto) VALUES (1,1), (1,2), (1,3), (2,2), (2,3), (2,4), (3, 2), (3,5), (3,6); 
SELECT * FROM fornecedor_produto;

-- table pagamento (id, forma_pgto, lim_cred_disp, valor_pgto, dt_pgto, desconto_a_vista, min_parc_sem_juros, juros_parcelado, status, id_pedido)
INSERT INTO pagamento (forma_pgto, lim_cred_disp, valor_pgto, dt_pgto, desconto_a_vista, min_parc_sem_juros, 
juros_parcelado, status, id_pedido) VALUES
-- ("À vista", 2000,100, "2024-10-10", .05, 3, 0.1, "quitado", 1),
("Boleto", 1000,200, "2024-10-11", .05, 3, 0.1, "quitado", 2),
("Cartão Crédito", 1000,50, "2024-10-20", .05, 3, 0.1, "em dia", 3),
("Cartão Crédito", 1000,50, "2024-11-20", .05, 3, 0.1, "em dia", 3),
("Pix", 2000,20, "2024-10-12", .05, 3, 0.1, "quitado", 1),
("Cartão Débito", 2000,150, "2024-12-10", .05, 3, 0.1, "quitado", 1);
INSERT INTO pagamento (forma_pgto, lim_cred_disp, valor_pgto, dt_pgto, desconto_a_vista, min_parc_sem_juros, 
juros_parcelado, status, id_pedido) VALUES
("Boleto", 1000, 50, "2024-09-11", .05, 3, 0.1, "atrasado", 4);
SELECT * FROM pagamento;
 
-- table pedido (id, dt_pedido, frete, status, id_cliente)
INSERT INTO pedido (dt_pedido, frete, status, id_cliente) VALUES
   ("2000-01-10", 10.00, "Em processamento", 1),
   ("2000-01-11", 10.00, "Confirmado", 1),
   ("2000-02-12", 10.00, "Em processamento", 2),
   ("2000-03-10", 10.00, "Em processamento", 1),
   ("2000-04-10", 20.00, "Confirmado", 2),
   ("2000-04-11", 20.00, "Confirmado", 2);
INSERT INTO pedido (dt_pedido, frete, status, id_cliente) VALUES
	("2000-04-10", 20.00, "Confirmado", 3),
	("2024-12-12", 20.00, "Confirmado", 4);
SELECT * FROM pedido;

-- table produto (id, nome, descricao, preco_unit, categoria, avaliacao, tamanho)
INSERT INTO  produto (nome, descricao, preco_unit, categoria, avaliacao, tamanho) VALUES
   ("produto 1", "descricao produto 1", 100.00, "vestimenta", 8, "M"),
   ("produto 2", "descricao produto 2", 1500.00, "eletronico", 7, NULL),
   ("produto 3", "descricao produto 3", 50.00, "brinquedo", 6, NULL),
   ("produto 4", "descricao produto 4", 80.00, "vestimenta", 8, "G"),
   ("produto 5", "descricao produto 5", 50.00, "alimento", 8, NULL),
   ("produto 6", "descricao produto 6", 150.00, "móveis", 6, NULL);
SELECT * FROM produto;

-- table produto_estoque (id_produto, id_estoque, qtde)
INSERT INTO produto_estoque (id_produto, id_estoque, qtde) VALUES
    (1, 1, 100), (2, 1, 150), (3, 1, 200), (4, 2, 80), (6, 1, 220), (6, 2, 180);
SELECT * FROM produto_estoque;

-- table produto_pedido(id_produto, id_pedido)
INSERT INTO produto_pedido VALUES (1,1), (1,2), (2,2), (3, 4), (5, 5);
SELECT * FROM produto_pedido;

-- table vendedor (id, nome, sobrenome, endereco, matricula)
INSERT INTO vendedor (nome, sobrenome, endereco, matricula) VALUES
   ("vendedor 1", "sobrenome", "endereço vendedor 1", 11111111),
   ("vendedor 2", "sobrenome", "endereço vendedor 2", 22222222),
   ("vendedor 3", "sobrenome", "endereço vendedor 3", 33333333),
   ("vendedor 4", "sobrenome", "endereço vendedor 4", 44444444);
INSERT INTO vendedor (nome, sobrenome, endereco, matricula) VALUES
   ("vendedor 5", "sobrenome", "endereço vendedor 5", 55555555);
SELECT * FROM vendedor;

-- table vendedor_terceirizado (id, nome_fantasia, razao_social, vendedor_CNPJ, localizacao, contato, telefone) 
INSERT INTO vendedor_terceirizado (nome_fantasia, razao_social, vendedor_CNPJ, localizacao, contato, telefone) VALUES
   ("fantasia A", "razao social A", "11.111.111/0001-11", "rua A, Jabaquara, SP, SP", "contato A", "11(11) 1111.1111"),
   ("fantasia B", "razao social B", "22.222.222/0002-22", "rua B, Saúde, SP, SP", "contato B", "22(22) 2222.2222"),
   ("fantasia C", "razao social C", "33.333.333/0003-33", "rua C, Tucuruvi, SP, SP", "contato C", "33(33) 3333.3333"),
   ("fantasia D", "razao social D", "44.444.444/0004-44", "rua D, Bom Retiro, SP, SP", "contato D", "44(44) 4444.4444");

