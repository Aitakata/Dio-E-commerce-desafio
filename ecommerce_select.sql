use ecommerce;

-- clientes pessoa física
SELECT c.id, c.tipo_cliente, c.endereco, pf.nome, pf.sobrenome, pf.cliente_CPF, pf.telefone
FROM cliente c
JOIN cliente_PF pf ON c.id = pf.id_cliente
WHERE c.tipo_cliente = 'PF';

-- clientes pessoa jurídica
SELECT c.id, c.tipo_cliente, c.endereco, pj.nome_fantasia, pj.razao_social, pj.cliente_CNPJ, pj.contato, pj.telefone
FROM cliente c
JOIN cliente_PJ pj ON c.id = pj.id_cliente
WHERE c.tipo_cliente = 'PJ';

-- produtos com avaliaçao acima de 7
SELECT id, nome, descricao, preco_unit, categoria, avaliacao
FROM produto
WHERE avaliacao > 7;

-- pedidos feitos nos ultimos 30 dias
SELECT id, dt_pedido, frete, status, id_cliente
FROM pedido
WHERE dt_pedido >= DATE_SUB(CURDATE(), INTERVAL 1200 DAY);

-- produtos por categoria: eletronico
SELECT id, nome, descricao, preco_unit, avaliacao, tamanho
FROM produto
WHERE categoria = 'eletronico';

-- clientes e qtde de pedidos que fizeram
SELECT c.id, c.tipo_cliente, c.endereco, COUNT(p.id) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente 
GROUP BY c.id, c.tipo_cliente, c.endereco;

-- localidades com estoque abaixo de 100, ordenado por quantide de produto
SELECT id, localizacao AS localizacao_estoque, qtde
FROM estoque
WHERE qtde < 250
ORDER BY qtde;

-- produtos que possuem mais de um fornecedor
SELECT 
    p.id AS produto_id, 
    p.nome AS nome_produto,
    COUNT(f.id) AS total_fornecedores
FROM 
    produto p
JOIN 
    fornecedor_produto fp ON p.id = fp.id_produto
JOIN 
    fornecedor f ON fp.id_fornecedor = f.id
GROUP BY 
    p.id, p.nome
HAVING 
    COUNT(f.id) > 1;


-- pedidos com pagamento quitado
SELECT p.id, p.dt_pedido, p.frete, p.status, pg.forma_pgto, pg.valor_pgto, pg.dt_pgto, pg.status AS status_pagamento
FROM pedido p
JOIN pagamento pg ON p.id = pg.id_pedido
WHERE pg.status = 'atrasado';

-- pedidos em processamento
SELECT 
    id AS pedido_id,
    dt_pedido,
    frete,
    status,
    id_cliente
FROM 
    pedido
WHERE 
    status = 'Em processamento';


-- todos os pedidos agrupados por status e ordenados por codigo de rastreio
SELECT 
    p.id AS pedido_id,
    p.dt_pedido,
    p.frete,
    p.status,
    e.cod_rastreio,
    e.nome_recebedor,
    e.status AS status_entrega,
    e.dt_recebimento
FROM 
    pedido p
LEFT JOIN 
    entrega e ON p.id = e.id_pedido 
    WHERE e.cod_rastreio IS NOT NULL
GROUP BY 
    p.id, p.dt_pedido, p.frete, p.status, e.cod_rastreio, e.nome_recebedor, e.status, e.dt_recebimento
ORDER BY 
    p.status, e.cod_rastreio;


-- entregas de produtos em transito
SELECT e.id, e.nome_recebedor, e.cod_rastreio, e.status, e.dt_recebimento, p.dt_pedido, p.status AS status_pedido
FROM entrega e
JOIN pedido p ON e.id_pedido = p.id
WHERE e.status = 'em trânsito';

-- consulta de fornecedor por produto (produto 1)
SELECT f.id, f.nome_fantasia, f.razao_social, f.fornecedor_CNPJ, f.localizacao, f.contato, f.telefone
FROM fornecedor f
JOIN fornecedor_produto fp ON f.id = fp.id_fornecedor
JOIN produto p ON fp.id_produto = p.id
WHERE p.nome = 'produto 1';

-- produto e todos os fornecedores associados, agrupados por produto
SELECT 
    p.id AS produto_id, 
    p.nome AS nome_produto,
    GROUP_CONCAT(f.nome_fantasia SEPARATOR ', ') AS fornecedores
FROM 
    produto p
JOIN 
    fornecedor_produto fp ON p.id = fp.id_produto
JOIN 
    fornecedor f ON fp.id_fornecedor = f.id
GROUP BY 
    p.id, p.nome;

-- clientes que fizeram mais de uma compra
SELECT 
    c.id AS cliente_id,
    c.tipo_cliente,
    c.endereco,
    COUNT(p.id) AS total_pedidos
FROM 
    cliente c
JOIN 
    pedido p ON c.id = p.id_cliente
GROUP BY 
    c.id, c.tipo_cliente, c.endereco
HAVING 
    COUNT(p.id) > 1;

-- contato do vendedor terceirizado "fantasia A"
SELECT 
    nome_fantasia AS nome_empresa,
    contato,
    telefone
FROM 
    vendedor_terceirizado
WHERE 
    nome_fantasia = 'fantasia A';



