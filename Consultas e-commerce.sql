-- ==================== --
-- Consultas E-commerce --
-- ==================== --

USE ecommerce;

-- Perguntas utilizando Join, Group by, Order by, Case, Having e Where --
-- Quais produtos cada cliente comprou, com os respectivos valores, status do pedido, status de estoque e forma de pagamento?"
SELECT 
    CASE 
        WHEN c.personType = 'PF' THEN CONCAT(c.Fname, ' ', c.Lname)
        ELSE c.tradeName
    END AS nomeCliente,
    p.Pname AS nomeProduto,
    po.price AS precoUnitario,
    po.subtotal AS subtotalProduto,
    po.stockStatus AS statusEstoque,
    o.statusOrder,
    pay.typePayment
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient
JOIN productOrders po ON o.idOrder = po.idOrder
JOIN product p ON po.idProduct = p.idProduct
JOIN payment pay ON o.idOrder = pay.idOrder
ORDER BY nomeCliente, nomeProduto;

-- Relação de produtos, fornecedores e estoques
SELECT 
    p.Pname AS NomeProduto,
    ps.availableQuantity AS QuantidadeFornecedor,
    s.localAddress AS LocalEstoque,
    s.availableQuantity AS QuantidadeEstoque,
    CASE
        WHEN s.availableQuantity = 0 THEN 'Indisponível'
        WHEN s.availableQuantity < 50 THEN 'Baixo Estoque'
        ELSE 'Disponível'
    END AS StatusEstoque,
    f.companyName AS NomeFornecedor
FROM 
    product p
JOIN 
    productSupplier ps ON p.idProduct = ps.idProduct
JOIN 
    supplier f ON ps.idSupplier = f.idSupplier
LEFT JOIN 
    productStorage s ON p.idProduct = s.idProduct;

-- Relação de nomes dos fornecedores e nomes dos produtos
-- Relação direta usando a tabela N:N productSupplier
SELECT 
    f.companyName AS NomeFornecedor,
    p.Pname AS NomeProduto
FROM 
    supplier f
JOIN 
    productSupplier ps ON f.idSupplier = ps.idSupplier
JOIN 
    product p ON ps.idProduct = p.idProduct
ORDER BY 
    f.companyName, p.Pname;

-- Quais clientes (PF ou PJ) compraram mais de R$50 em pedidos, e quais produtos eles compraram?
SELECT 
    CASE 
        WHEN c.personType = 'PF' THEN CONCAT(c.Fname, ' ', c.Lname)
        WHEN c.personType = 'PJ' THEN c.tradeName
        ELSE 'Cliente sem nome'
    END AS nomeCliente,
    GROUP_CONCAT(DISTINCT p.Pname SEPARATOR ', ') AS produtosComprados,
    SUM(o.valueTotal) AS totalCompras
FROM orders o
JOIN clients c ON o.idOrderClient = c.idClient
JOIN productOrders op ON o.idOrder = op.idOrder
JOIN product p ON op.idProduct = p.idProduct
GROUP BY c.idClient
HAVING SUM(o.valueTotal) > 50;

-- Quais pedidos estão com o status 'Entregue' e foram pagos com cartão?
SELECT 
    o.idOrder AS NumeroPedido,
    o.statusOrder AS StatusPedido,
    pay.typePayment AS FormaPagamento,
    pay.statusPayment AS StatusPagamento,
    pay.datePayment AS DataPagamento
FROM orders o
JOIN payment pay ON o.idOrder = pay.idOrder
WHERE o.statusOrder = 'Entregue'
  AND pay.typePayment = 'Cartoes';




