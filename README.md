# Dio <br>Desafio E-commerce
Dentro da formação **Suzano - Análise de Dados com Power BI**, no módulo *"Introdução a Banco de dados Relacionais"* este é primeiro desafio a ser entregue.
<br><br>**Minimundo**<br>
Devemos criar uma aplicação de venda de produtos on-line, que possui um banco de dados relacional fornecendo dados para o e-commerce. Um cliente faz um 
pedido. Dentro desse pedido tem produtos que podem estar em estoque ou não e normalmente está associado a um fornecedor. Para começar podemos mapear
algunmas entidades: produto, estoque, cliente, pedido, e fornecedor.<br>

**Objetivo do desafio:**
Criar um modelo MER.

## Levantamento de requisitos 
**Produto**
- os produtos são vendidos por uma única plataforma online. Contudo, estes podem ter vendedores distintos (terceiros)
- cada produto possui um fornecedor
- um ou mais produtos podem compor um pedido

**Cliente**
- o cliente pode se cadastrar no site com o seu CPF ou CNPJ
- o endereço do cliente irá determinar o valor do frete
- um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto.

**Pedido**
- os pedidos são criados por clientes e possuem informações de compra, endereço e status da compra
- um produto ou mais compoem o pedido
- o pedido pode ser cancelado

**Fornecedor**
- um fornecedor pode fornecer um ou mais produtos
- cada produto pode ser ofertado por um ou mais fornecedores<br>

**Estoques**
- Além dos vendedores terceirizados, a própria plataforma também vende produtos
- Para isso deve manter um controle de estoque atualizado
