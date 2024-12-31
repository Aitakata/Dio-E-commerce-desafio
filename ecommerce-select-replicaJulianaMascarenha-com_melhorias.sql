/* **************************************************************
	testes funcionais 

 ***************************************************************** */
-- consultar pedidos de um cliente
SELECT * FROM orders WHERE idOrdersClient = 1;

-- listar produtos de um pedido
SELECT p.productName, po.poQuantity
FROM productOrder po
JOIN product p ON po.idPOproduct = p.idproduct
WHERE po.idPOorder = 1;

-- verificar estoque de um produto
SELECT ps.location, ps.quantity
FROM productStorage ps
JOIN storageLocation sl ON ps.idProductStorage = sl.idLstorage
WHERE sl.idLproduct = 1;

-- listar fornecedores de um produto
SELECT s.socialName, ps.supplyPrice
FROM productSupplier ps
JOIN supplier s ON ps.idSupplier = s.idSupplier
WHERE ps.idProduct = 1;

-- verificar métodos de pagamento de um cliente
SELECT pt.typeName, p.paymentAmount
FROM payments p
JOIN paymentTypes pt ON p.idPaymentType = pt.idPaymentType
WHERE p.idClient = 1;

-- total de pedidos por cliente
SELECT 
    c.idclient, 
    CONCAT(c.firstName, ' ', c.lastName) AS clientName, 
    COUNT(o.idOrders) AS totalOrders
FROM clients c
JOIN orders o ON c.idclient = o.idOrdersClient
GROUP BY c.idclient
ORDER BY totalOrders DESC;

-- valor total gasto por cliente
SELECT 
    c.idclient, 
    CONCAT(c.firstName, ' ', c.lastName) AS clientName, 
    SUM(p.paymentAmount) AS totalSpent
FROM clients c
JOIN payments p ON c.idclient = p.idClient
GROUP BY c.idclient
HAVING totalSpent > 100
ORDER BY totalSpent DESC;

-- produtos mais vendidos
SELECT 
    p.idproduct, 
    p.productName AS Produto, 
    SUM(po.poQuantity) AS Total_Vendido
FROM product p
JOIN productOrder po ON p.idproduct = po.idPOproduct
GROUP BY p.idproduct
HAVING Total_Vendido > 2
ORDER BY Total_Vendido DESC;

-- média de avaliação por categoria de produto
SELECT 
    category, 
    AVG(avaliacao) AS "Taxa avaliacao"
FROM product
GROUP BY category
ORDER BY "Taxa avaliacao" DESC;

-- fornecedores com maior número de produtos fornecidos
SELECT 
    s.idSupplier, 
    s.socialName, 
    COUNT(ps.idProduct) AS totalProductsSupplied
FROM supplier s
JOIN productSupplier ps ON s.idSupplier = ps.idSupplier
GROUP BY s.idSupplier
HAVING totalProductsSupplied > 1
ORDER BY totalProductsSupplied DESC;

-- pedidos com frete acima da média
SELECT 
    idOrders, 
    ordersDescription AS Descricao, 
    freight AS Frete
FROM orders
WHERE freight > (SELECT AVG(freight) FROM orders)
ORDER BY freight DESC;

-- total de pagamento por tipo
SELECT 
    pt.typeName, 
    SUM(p.paymentAmount) AS "Total pago"
FROM payments p
JOIN paymentTypes pt ON p.idPaymentType = pt.idPaymentType
GROUP BY pt.typeName
ORDER BY "Total pago" DESC;

-- produtos com estoque abaixo do mínimo
SELECT 
    p.idproduct, 
    p.productName, 
    ps.quantity, 
    ps.minQuantity
FROM product p
JOIN productStorage ps ON p.idproduct = ps.idProductStorage
WHERE ps.quantity < ps.minQuantity
ORDER BY p.idproduct;

-- vendedores com maior número de produtos vendidos
SELECT 
    s.idSeller, 
    s.socialName, 
    SUM(ps.prodQuantity) AS totalProdutoVendido
FROM seller s
JOIN productSeller ps ON s.idSeller = ps.idPseller
GROUP BY s.idSeller
HAVING totalProdutoVendido > 1
ORDER BY totalProdutoVendido DESC;

-- pedidos com status "em processamento"
SELECT 
    idOrders, 
    ordersDescription AS Descricao, 
    orderDate AS "Data do pedido"
FROM orders
WHERE ordersStatus = 'em processamento'
ORDER BY "Data do pedido";

-- total de pagamentos por cliente e tipo
SELECT 
    c.idclient, 
    CONCAT(c.firstName, ' ', c.lastName) AS cliente, 
    pt.typeName AS Tipo, 
    SUM(p.paymentAmount) AS "Total Pago"
FROM clients c
JOIN payments p ON c.idclient = p.idClient
JOIN paymentTypes pt ON p.idPaymentType = pt.idPaymentType
GROUP BY c.idclient, pt.typeName
ORDER BY c.idclient, "Total Pago" DESC;

-- produtos com maior valor total em estoque
SELECT 
    p.idproduct, 
    p.productName AS Produto, 
    SUM(ps.quantity * ps.price_unit) AS totalValue
FROM product p
JOIN productStorage ps ON p.idproduct = ps.idProductStorage
GROUP BY p.idproduct
HAVING totalValue > 500
ORDER BY totalValue DESC;
