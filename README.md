# 🛒 E-Commerce Database Project

---
## 📚 Sobre o Projeto

Este projeto foi desenvolvido como parte do meu processo de aprendizado durante o Bootcamp de Banco de Dados. Nele, simulei a estrutura de um banco de dados para um e-commerce, realizando desde a modelagem relacional até a criação das tabelas e execução de consultas SQL complexas.

O objetivo principal é consolidar conhecimentos práticos em modelagem, manipulação e análise de dados em MySQL, contribuindo com minha evolução como futura profissional da área de dados.

## 📂 Estrutura do Repositório

/imagesconsultas

imagens-consultas: imagens das consultas realizadas no banco de dados.

/queries

consultase-commerce.sql: consultas desenvolvidas para responder perguntas de negócio.

/scripts

e-commerce.sql: contém os scripts de criação das tabelas (clients, product, orders, etc.) e os inserts com dados fictícios inseridos para testes.

/images

modelo-relacional.png: modelo relacional completo em português.


---

## 🎯 Objetivo do Projeto

Criar e popular um banco de dados relacional que simula as operações essenciais de um e-commerce, incluindo:

- Cadastro de clientes (PF e PJ)
- Gestão de pedidos, produtos, pagamentos, entregas
- Relacionamento com fornecedores e vendedores
- Registro de estoque e avaliações de clientes

---

## 🧩 Modelagem Relacional

O modelo relacional foi construído com base nos principais requisitos de um e-commerce, respeitando boas práticas de normalização e clareza entre as entidades.

📌 **Nota técnica:**  
Algumas diferenças foram aplicadas entre o modelo e o código final:
- No diagrama, os campos de endereço (como `bairro`, `cidade`, `cep`) aparecem detalhados para evidenciar a estrutura dos dados.
- No código SQL, eles foram simplificados para um único campo `localAddress`, visando praticidade na escrita e leitura de dados de teste.

---

## 🛠️ Tecnologias Utilizadas

- MySQL Workbench (para modelagem visual)


---

## 📊 Consultas SQL

As consultas SQL foram criadas para responder a perguntas típicas de negócio, como:

- Quais produtos cada cliente comprou, com os respectivos valores, status do pedido, status de estoque e forma de pagamento?
- Como está o status atual de estoque dos produtos, levando em conta a quantidade fornecida pelas empresas parceiras e o nível de disponibilidade em nossos locais de armazenamento?
- Relação de produtos, fornecedores e estoques.
- Quais clientes (PF ou PJ) compraram mais de R$50 em pedidos, e quais produtos eles compraram?
- Quais pedidos estão com o status 'Entregue' e foram pagos com cartão?

✅ Todas as queries estão organizadas no arquivo (consultase-commerce.sql).

---

🧠 Aprendizados e Considerações

Este projeto foi fundamental para consolidar habilidades práticas em:

Modelagem de banco de dados relacional

Escrita de scripts SQL estruturados

Organização e clareza de documentação técnica

Adaptação entre design lógico e implementação prática

Também reforçou a importância de representar os dados de maneira fiel ao domínio do negócio, ao mesmo tempo que simplificações podem ser aplicadas no código para fins práticos.

---
🚀 Próximos passos (possíveis evoluções)

- Adicionar procedimentos armazenados ou triggers

- Criar views para relatórios gerenciais

- Conectar o banco a uma aplicação front-end (ex: dashboard)

- Internacionalizar os campos e dados do modelo

👩‍💻 Autora
Paloma Beker
Estudante de Ciência de Dados 
Contato: [LinkedIn](https://www.linkedin.com/in/paloma-beker/) 


