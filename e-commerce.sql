-- =======================================
-- BANCO DE DADOS E-COMMERCE 
-- Autora: Paloma Beker
-- =======================================

-- 1. Criação do Banco de Dados-- 
create database ecommerce;
use ecommerce;

-- 2. Tabelas principais
-- 2.1. Clientes 
create table clients(
       idClient int auto_increment primary key,
       Fname varchar(10),
       Lname varchar(20),
       CPF char(11) null,
       companyName VARCHAR(150) NULL,
       tradeName varchar (100),
       CNPJ char(14) null,
       personType enum('PF', 'PJ') NOT NULL DEFAULT 'PF',          -- 'PF = Pessoa Física, PJ= Pessoa Jurídica' --
       address varchar (30),
       neighborhood varchar(50),
       city varchar(50),
       postalCode char(8),
       constraint unique_cpf_client unique (CPF),
       constraint unique_cnpj unique (CNPJ),
       constraint chk_personType
	CHECK (
    (personType = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL AND companyName IS NULL) OR
    (personType = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL AND companyName IS NOT NULL))
);

-- Inserção de dados (dados de teste)
-- Cliente PF
INSERT INTO clients (Fname, Lname, CPF, address, neighborhood, city, postalCode)
VALUES ('Paloma', 'Beker', '12345678901', 'Rua das Flores, 123', 'Centro', 'Salvador', '40000000'),
('João', 'Silva', '23456789012', 'Rua Nova, 100', 'Bela Vista', 'São Paulo', '01000001'),
('Maria', 'Oliveira', '34567890123', 'Av. Central, 200', 'Centro', 'Rio de Janeiro', '20000002'),
('Lucas', 'Costa', '45678901234', 'Rua das Palmeiras, 300', 'Zona Sul', 'Belo Horizonte', '30000003'),
('Fernanda', 'Souza', '56789012345', 'Travessa Azul, 400', 'Boa Vista', 'Curitiba', '40000004'),
('Carlos', 'Pereira', '67890123456', 'Rua Verde, 500', 'Jardim América', 'Porto Alegre', '50000005'),
('Juliana', 'Lima', '78901234567', 'Av. Paulista, 600', 'Paulista', 'São Paulo', '60000006'),
('Diego', 'Rocha', '89012345678', 'Rua Leste, 700', 'Leste', 'Recife', '70000007');

-- Cliente PJ
INSERT INTO clients (tradeName, companyName, CNPJ, personType, address, neighborhood, city, postalCode)
VALUES ('Beker Chocolates', 'Beker Barros LTDA', '98865432000186', 'PJ', 'Av. Francisco Peixoto, 105', 'Campos do Jordão', 'São Paulo', '03300000'),
('Loja', 'Comercial Silva LTDA', '98765432000188', 'PJ', 'Av. Brasil, 456', 'Comércio', 'São Paulo', '01000000');


-- 2.2. Produtos
-- Size = dimensão do produto
create table product(
       idProduct int auto_increment primary key,
       Pname varchar(50) not null,
       productDescription varchar(30),
       category enum('Eletrônico', 'Vestuário','Alimentício','Brinquedos','Móveis') not null,
       classification_kids bool default false,
	   valueProduct decimal(8,2),
       rating decimal(3,2) default 0.00,
       size varchar(10),
       color varchar(20)
); 

-- Inserção de dados para teste na tabela products -- 
INSERT INTO product (Pname, productDescription, category, classification_kids, valueProduct, rating, size, color) VALUES
('Smartphone Galaxy S23', 'Tela AMOLED 6.1", 128GB', 'Eletrônico', false, 3499.99, 4.7, '6x14cm', 'Preto'),
('Camiseta Básica', '100% algodão', 'Vestuário', false, 49.90, 4.5, 'M', 'Branca'),
('Cadeira Gamer', 'Ergonômica e reclinável', 'Móveis', false, 899.90, 4.8, '120x60x60', 'Vermelha'),
('Boneca Barbie', 'Edição Praia 2023', 'Brinquedos', true, 79.99, 4.6, '30cm', 'Rosa'),
('Biscoito Recheado', 'Sabor chocolate', 'Alimentício', true, 3.99, 4.2, '15x8cm', 'Marrom'),
('Notebook Dell Inspiron', 'Intel i5, 8GB RAM', 'Eletrônico', false, 3999.90, 4.4, '35x24cm', 'Prata'),
('Vestido Floral', 'Tecido leve, verão', 'Vestuário', false, 139.90, 4.7, 'G', 'Azul'),
('Carrinho Hot Wheels', 'Coleção 2024', 'Brinquedos', true, 12.99, 4.3, '7cm', 'Azul'),
('Mesa de Jantar', 'Madeira maciça 6 lugares', 'Móveis', false, 1799.00, 4.9, '200x90x75', 'Madeira'),
('Suco de Laranja', 'Natural, 1L', 'Alimentício', false, 7.50, 4.1, '1L', 'Laranja'),
('Estante de Livros', 'Estante 5 prateleiras em MDF', 'Móveis', false, 599.90, 4.6, '180x80x30', 'Branca'),
('Granola Integral', '500g com mix de cereais e mel', 'Alimentício', true, 15.90, 4.3, '500g', 'Bege');

-- 2.3. Pedidos 
create table orders(
       idOrder int auto_increment primary key,
       idOrderClient int,
       orderName varchar(100),
       orderDescription varchar(255),
       dateOrder date,
       statusOrder ENUM('Em andamento','Processando','Enviado','Entregue') default 'Processando',
       freight float default 10,
       valueTotal decimal(10,2),
       paymentCash bool default false,
       constraint fk_orders_clients foreign key (idOrderClient) references clients (idClient)
);

-- Inserção de pedidos na tabela orders --
INSERT INTO orders 
(idOrderClient, orderName, orderDescription, dateOrder, statusOrder, freight, valueTotal, paymentCash) 
VALUES
(1, 'Smartphone Galaxy S23', 'Tela AMOLED 6.1", 128GB', '2025-07-25', 'Entregue', 19.90, 3499.99, true),
(2, 'Camiseta Básica', '100% algodão, cor branca, tamanho M', '2025-07-25', 'Em andamento', 9.90, 49.90, false),
(3, 'Cadeira Gamer', 'Ergonômica, reclinável, com apoio lombar', '2025-07-25', 'Enviado', 29.90, 899.90, true),
(4, 'Boneca Barbie', 'Edição Praia 2023, loira com acessórios', '2025-07-25', 'Processando', 14.90, 79.99, false),
(5, 'Biscoito Recheado', 'Sabor chocolate, pacote com 130g', '2025-07-25', 'Entregue', 4.99, 3.99, true),
(6, 'Notebook Dell Inspiron', 'Intel i5, 8GB RAM, SSD 256GB', '2025-07-25', 'Enviado', 39.90, 3999.90, false),
(7, 'Vestido Floral', 'Tecido leve, ideal para o verão', '2025-07-25', 'Processando', 14.90, 139.90, true),
(8, 'Carrinho Hot Wheels', 'Coleção 2024, modelo esportivo', '2025-07-25', 'Em andamento', 5.90, 12.99, false),
(9, 'Mesa de Jantar', 'Madeira maciça, 6 lugares', '2025-07-25', 'Entregue', 99.90, 1799.00, true),
(10, 'Suco de Laranja', 'Natural, 1L, sem conservantes', '2025-07-25', 'Processando', 4.90, 7.50, false);

-- 2.4. Estoque
create table productStorage(
       idProductStorage int auto_increment primary key,
       idProduct int,
       localAddress varchar(255) not null,
       availableQuantity int default 0
);

-- Inserção de dados para teste na tabela estoque --
INSERT INTO productStorage (idProduct, localAddress, availableQuantity)
VALUES
(1, 'Galpão A - Prateleira 1', 100),
(2, 'Galpão A - Prateleira 2', 50),
(3, 'Galpão B - Prateleira 3', 75),
(4, 'Loja Física - Estoque 1', 20),
(5, 'Centro de Distribuição ZN', 150),
(6, 'Galpão C - Prateleira 5', 30),     -- Notebook Dell
(7, 'Loja Física - Estoque 2', 60),     -- Vestido Floral
(8, 'Centro de Distribuição ZS', 120),  -- Carrinho Hot Wheels
(9, 'Galpão D - Área de Móveis', 15),   -- Mesa de Jantar
(10, 'Galpão A - Prateleira 4', 200);   -- Suco de Laranja


-- 2.5. Fornecedor
create table supplier(
       idSupplier int auto_increment primary key,
       companyName varchar(100),
       CNPJ char(15) not null,
       contact varchar(15) not null,
       localAddress varchar (255),
       constraint unique_supplier unique (CNPJ)
);
-- Inserção de dados para teste na tabela fornecedor --
INSERT INTO supplier (companyName, CNPJ, contact, localAddress)
VALUES
('Têxtil Bahia Ltda', '12345678000195', '7199999999', 'Av. Industrial, 1000 - Salvador/BA'),
('Distribuidora Sul Roupas', '23456789000188', '5198888888', 'Rua da Moda, 456 - Porto Alegre/RS'),
('Alpha Confecções', '34567890000177', '1197777777', 'Rua São Jorge, 123 - São Paulo/SP'),
('Moda Rápida Express', '45678900000166', '3196666666', 'Av. das Indústrias, 567 - Belo Horizonte/MG'),
('Central de Calçados', '56789000000155', '2195555555', 'Rua Nova, 789 - Rio de Janeiro/RJ'),
('MoveLar Móveis', '67890000000144', '3193333333', 'Av. Móveis Planejados, 300 - Curitiba/PR'),
('Natural Sabor Alimentos', '78900000000133', '1192222222', 'Rua dos Alimentos, 77 - Campinas/SP'),
('Brinque Mais Distribuidora', '67890000000145', '11944443333', 'Rua das Crianças, 321 - São Paulo/SP');


-- 2.6. Vendedor
create table seller(
       idSeller int auto_increment primary key,
       companyName varchar(100) not null,
       socialName varchar (100) not null,
       CNPJ char(15) not null,
       CPF char(11) not null,
       contact char(10),
       localAddress varchar(255),
       constraint unique_cnpj_seller unique (CNPJ),
       constraint unique_cpf_seller unique (CPF)
);

-- Inserção de dados para teste na tabela vendedor --
INSERT INTO seller (companyName, socialName, CNPJ, CPF, contact, localAddress)
VALUES
('Mundo Fashion', 'Mundo Fashion Comércio de Roupas Ltda', '12345678000195', '12345678901', '7199999999', 'Av. Central, 1000 - Salvador/BA'),
('Estilo Urbano', 'Estilo Urbano Confecções ME', '23456789000188', '23456789012', '1198888888', 'Rua Nova, 200 - São Paulo/SP'),
('Roupas & Cia', 'Roupas e Cia Ltda', '34567890000177', '34567890123', '3197777777', 'Rua das Palmeiras, 321 - Belo Horizonte/MG'),
('Trends BR', 'Trends do Brasil LTDA', '45678900000166', '45678901234', '5196666666', 'Av. da Moda, 456 - Porto Alegre/RS'),
('Modarte', 'Modarte Comércio de Vestuário', '56789000000155', '56789012345', '2195555555', 'Rua do Comércio, 789 - Rio de Janeiro/RJ');

       
-- 2.7. Entrega
create table delivery(
       idDelivery int auto_increment primary key,
       deliveryAddress varchar(255) not null,
       trackingCode varchar(45) not null,
       deliveryStatus enum('Entregue','Em andamento','Atrasado','Devolvido')
);

-- Inserção de dados para teste na tabela entrega --
INSERT INTO delivery (deliveryAddress, trackingCode, deliveryStatus)
VALUES
('Rua das Acácias, 101 - Salvador/BA', 'BR1234567890BR', 'Entregue'),
('Av. Paulista, 1500 - São Paulo/SP', 'SP9876543210BR', 'Em andamento'),
('Rua da Paz, 250 - Porto Alegre/RS', 'RS1239874560BR', 'Atrasado'),
('Rua do Comércio, 456 - Belo Horizonte/MG', 'MG4567891230BR', 'Entregue'),
('Av. das Flores, 789 - Rio de Janeiro/RJ', 'RJ7894561230BR', 'Devolvido'),
('Rua Esperança, 321 - Recife/PE', 'PE3216549870BR', 'Entregue'),
('Av. Independência, 654 - Curitiba/PR', 'PR6547893210BR', 'Em andamento'),
('Rua Aurora, 147 - Brasília/DF', 'DF1472583690BR', 'Entregue'),
('Av. Central, 369 - Fortaleza/CE', 'CE3692581470BR', 'Atrasado'),
('Rua Vitória, 753 - Manaus/AM', 'AM7539514560BR', 'Devolvido');

-- 2.8. Pagamento
create table payment(
       idPayment int auto_increment primary key,
       idClient int,
       idOrder int,
       idDelivery int,
       datePayment varchar (10),
       typePayment enum('Boleto','Cartoes','Dinheiro','Dois cartoes'),
	   statusPayment enum('pago', 'pendente', 'cancelado'),
       invoice varchar (100),
       paymentReceipt varchar (100),
       constraint fk_payment_clients foreign key (idClient) references clients(idClient),
       constraint fk_payment_order foreign key (idOrder) references orders(idOrder),
       constraint fk_payment_delivery foreign key (idDelivery) references delivery(idDelivery)
);

-- Inserção de dados para teste na tabela pagamento --
INSERT INTO payment (idClient, idOrder, idDelivery, datePayment, typePayment, statusPayment, invoice, paymentReceipt)
VALUES
(1, 56, 1, '2025-07-01', 'Cartoes', 'pago', 'NF001.pdf', 'comprovante001.jpg'),
(2, 57, 2, '2025-07-03', 'Boleto', 'pago', 'NF002.pdf', 'comprovante002.jpg'),
(3, 58, 3, '2025-07-05', 'Dinheiro', 'pendente', 'NF003.pdf', 'comprovante003.jpg'),
(4, 59, 4, '2025-07-07', 'Cartoes', 'cancelado', 'NF004.pdf', 'comprovante004.jpg'),
(5, 60, 5, '2025-07-09', 'Dois cartoes', 'pago', 'NF005.pdf', 'comprovante005.jpg'),
(6, 61, 6, '2025-07-10', 'Dinheiro', 'pago', 'NF006.pdf', 'comprovante006.jpg'),
(7, 62, 7, '2025-07-12', 'Cartoes', 'pendente', 'NF007.pdf', 'comprovante007.jpg'),
(8, 63, 8, '2025-07-14', 'Boleto', 'pago', 'NF008.pdf', 'comprovante008.jpg'),
(9, 64, 9, '2025-07-15', 'Cartoes', 'pago', 'NF009.pdf', 'comprovante009.jpg'),
(10, 65, 10, '2025-07-16', 'Dois cartoes', 'pago', 'NF010.pdf', 'comprovante010.jpg');


-- =======================================
-- 3. TABELAS DE ASSOCIAÇÃO
-- =======================================

-- 3.1 PRODUTO x FORNECEDOR (N:N)
create table productSupplier(
       idProduct int,
       idSupplier int,
       availableQuantity int not null,
       primary key (idProduct, idSupplier),
       constraint fk_product_supplier_product foreign key (idProduct) references product(idProduct),
       constraint fk_product_supplier_supplier foreign key (idSupplier) references supplier(idSupplier)
);

UPDATE productSupplier SET idSupplier = 3 WHERE idProduct = 1;  -- Galaxy S23 → Alpha Confecções
UPDATE productSupplier SET idSupplier = 1 WHERE idProduct = 2;  -- Camiseta Básica → Têxtil Bahia Ltda
UPDATE productSupplier SET idSupplier = 6 WHERE idProduct = 3;  -- Cadeira Gamer → MoveLar Móveis
UPDATE productSupplier SET idSupplier = 9 WHERE idProduct = 4;  -- Boneca Barbie → BrinqueBem
UPDATE productSupplier SET idSupplier = 7 WHERE idProduct = 5;  -- Biscoito Recheado → Natural Sabor
UPDATE productSupplier SET idSupplier = 3 WHERE idProduct = 6;  -- Notebook Dell → Alpha Confecções
UPDATE productSupplier SET idSupplier = 2 WHERE idProduct = 7;  -- Vestido Floral → Distrib. Sul Roupas
UPDATE productSupplier SET idSupplier = 9 WHERE idProduct = 8;  -- Carrinho Hot Wheels → BrinqueBem
UPDATE productSupplier SET idSupplier = 6 WHERE idProduct = 9;  -- Mesa de Jantar → MoveLar Móveis
UPDATE productSupplier SET idSupplier = 7 WHERE idProduct = 10; -- Suco de Laranja → Natural Sabor


-- 3.2 PRODUTO x VENDEDOR (N:N)
create table productSeller(
       idProduct int,
       idSeller int,
       availableQuantity int not null,
       primary key (idProduct, idSeller),
       constraint fk_product_seller foreign key (idSeller) references Seller(idSeller),
       constraint fk_product_product foreign key (idProduct) references Product(idProduct)
);

insert into productSeller (idProduct, idSeller, availableQuantity) values
(2, 1, 150),  -- Camiseta Básica vendida por Mundo Fashion
(7, 2, 80),   -- Vestido Floral por Estilo Urbano
(4, 3, 60),   -- Boneca Barbie por Roupas & Cia
(8, 4, 100),  -- Carrinho Hot Wheels por Trends BR
(1, 5, 30),   -- Smartphone Galaxy S23 por Modarte
(6, 5, 20);   -- Notebook Dell Inspiron por Modarte


-- 3.3 PRODUTO x PEDIDO (N:N)
create table productOrders(
       idProduct int,
       idOrder int,
       availableQuantity int not null,
       stockStatus ENUM('Disponivel','Sem estoque') default 'Disponivel',
       price decimal(10,2),
       subtotal decimal(10,2),
       primary key (idProduct, idOrder),
       constraint fk_product_orders_product foreign key (idProduct) references product(idProduct),
       constraint fk_product_orders_order foreign key (idOrder) references Orders(idOrder)
);
INSERT INTO productOrders (idProduct, idOrder, availableQuantity, stockStatus, price, subtotal)
VALUES
(1, 56, 1, 'disponível', 3499.99, 3499.99),  -- Galaxy S23
(2, 57, 1, 'disponível', 49.90, 49.90),      -- Camiseta
(3, 58, 1, 'disponível', 899.90, 899.90),    -- Cadeira Gamer
(4, 59, 1, 'disponível', 79.99, 79.99),      -- Boneca Barbie
(5, 60, 1, 'disponível', 3.99, 3.99),        -- Biscoito
(6, 61, 1, 'disponível', 3999.90, 3999.90),  -- Notebook Dell
(7, 62, 1, 'disponível', 139.90, 139.90),    -- Vestido Floral
(8, 63, 1, 'disponível', 12.99, 12.99),      -- Carrinho Hot Wheels
(9, 64, 1, 'disponível', 1799.00, 1799.00),  -- Mesa de Jantar
(10, 65, 1, 'disponível', 7.50, 7.50);       -- Suco de Laranja




