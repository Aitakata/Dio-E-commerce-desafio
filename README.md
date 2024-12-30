# Dio <br>Desafio E-commerce - etapa 1
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

## Refinamentos realizados
1) Cliente PF e PF - Para tratamento de clientes PF e PJ foi criado uma tabela auxiliar **tipo_cliente** e seu id entrou como FK em cliente. Adotamos essa prática para
   facilitar a normalizaçao do banco de dados, especialmente se no futuro tivermos que escalar a aplicação, considerando adicionar novas funcionalidades e
   houver a necessidade de termos mais atributos específicos para cada tipo de cliente.
   tipo_cliente (1) --- (N) cliente

3) Pagamento - para acompanhar as diversas formas de pagamento e suas especificidades criamos uma tabela **forma_de_pagamento**. Dessa forma conseguimos maior
   flexibilidade e organização especialmente quando há diferentes condições e taxas associadas a cada método de pagamento.
   forma de pagamento - define as diferentes opçoes de pagamento disponíveis: dinheiro vivo, PIX, cartão de crédito, boleto bancário, débito automático em conta, carteiras
   digitais (PayPal, Mercado Pago etc).
   desconto a vista - porcentagem de desconto para pagamento à vista
   mínimo de parcelas sem juros - número mínimo de parcelas que a compra pode ser realizada sem que haja cobrança de juros
   juros parcelado - especifíca a porcentagem de juros que é acrescida quando o pagamento é parcelado (se aplicável)
   também foi criada uma tabela **pagamento**, assim conseguimos controlar, por exemplo, no caso de pagamento parcelado se a parcela foi paga, quando foi paga,
   se a parcela está vencida, quando vence a parcela, status do pagamento da parcela etc.
   pedido (1) --- (N) pagamento
   forma_pagamento (1) --- (N) pagamento
   
4) Entrega - Para capturar os detalhes de status da entrega e informações adicionais sobre o recebimento do pedido, como nome de quem recebeu, data e hora, criamos uma tabela
   adicional **entrega**, isso garante uma estrutura mais organizada e facilitará consultas e atualizações específicas sobre o processo de entrega.
   Exemplos de status de entrega: aguardando pagamento, pagamento aprovado, pagamento não aprovado, pagamento cancelado, faturado, produto em separação, pronto para envio,
   em transporte, entregue, destinatário ausente, etc.
   código de rastreio - permite acompanhar o trajeto do produto identificando os diferentes estágios do processo de entrega.
   nome do recebedor - é opcional e deve ser preenchido, quando o produto for entregue, identificando a pessoa que recebeu o pacote.
   data-hora do recebimento - é opcional e deve ser preenchido com a data e hora da entrega do produto
   pedido (1) --- (N) entrega

5) Categoria de produtos - Como na mesma plataforma vão existir vendas da própria plataforma e vendas de terceiros (inclusive podendo ser diversos terceiros vendendo o
   mesmo produto) estou considerando que é um marketplace. Portanto a diversidade de produtos deve ser grande, então, criamos uma categorização dos produtos de maneira
   a facilitar a busca dentro da plataforma. Assim podemos ter categorias como: eletroeletrônicos (televisores, computadores, smartphones, acessórios), moda (roupa, calçado, bolsas,
   moda íntima), perfumaria e cosméticos (perfumes, maquiagem, cuidados com a pele, cabelos, higiene pessoal), alimentos e bebidas (bebidas, congelados, mercearia, produtos
   naturais e orgânicos, doces e snacks), pet shop (alimentos, brinquedos, acessórios, higiene e saúde), acessórios automotivos (peças, som e vídeo, ferramentas, acessórios
   internos e externos), brinquedos (jogos educativos, de montar, bonecas e acessórios ao ar livre) móveis (sala de estar, quarto, cozinha, escritório, área externa),
   esporte e lazer (equipamentos esportivos, roupas esportivas, acessórios, camping & pesca, bicicletas), livros, música e filmes (livros, e-books, CDs/DVDs/Blue-rays),
   casa e jardim (decoração, utentílios domésticos, cama, mesa e banho, ferramentas de jardinagem, iluminação, etc.
   criamos a tabela **categoria** para identificar essas separações (cada categoria pode ter vários produtos 1:N).
   categoria (1) ---- (N) produto

6) Cada pedido pode ter varios produtos (1:N) e cada produto pode pertencer a diversos pedidos (1:N), portanto (N;M), então criamos a tabela auxiliar **produto-pedido**
   pedido (1) --- (N) produto-pedido (N) --- (1) produto
   
8) O mesmo ocorre entre produto e fornecedor, criamos a tabela **fornecedor-produto**
   fornecedor (1) --- (N) fornecedor-produto (N) --- (1) produto
   
# Desafio ecommerce - etapa 2: projeto lógico
## remodelagem do MER
Quando do projeto lógico para criacao do banco de dados, nos deparamos com alguns novos desafios e refinamentos, por isso, o MER foi alterado para refletir esta nova realidade
## criação dos scripts 
ecommerce_create.sql - criação do banco de dados e das tabelas<br>
ecommerce_insert.sql - inserção dos dados nas diversas tabelas para teste do banco de dados<br>
ecommerce_select.sql - exemplos de selects para buscar dados, usando having, group by, order by, join, etc.
