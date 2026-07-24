create database e_commerce;
use e_commerce;     

-- Criaçao da tabela Cliente --
create table cliente(idCliente int auto_increment,
                     tipoCliente char(2) not null check(tipoCliente in('PF','PJ')),
                     nome varchar(20) not null,
                     sobrenome varchar(20),
                     email varchar(45) not null,
                     rua varchar(20) not null,
                     numero int not null,
                     complemento varchar(15),
                     cep char(8) not null,
                     cidade varchar(20) not null,
                     estado char(2),
                     constraint pk_idCliente primary key(idCliente),
                     constraint unique_email unique(email)
                     );
                     
-- Criaçao tabela Pessoa Fisica --
create table pf(cpf char(11),
                data_nascimento date not null,
                idCliente int,
                constraint unique_cpf unique(cpf),
                constraint pk_idCliente primary key(idCliente),
                constraint fk_cliente_idCliente foreign key(idCliente) references cliente(idCliente)
                );
                
-- Criaçao da tabela Pessoa Juridica --
create table pj(cnpj char(14) not null,
                razao_social varchar(45) not null,
				idCliente int,
                constraint unique_cnpj unique(cnpj),
                constraint pk_idCliente primary key(idCliente),
                constraint fk_cliente_idCliente1 foreign key(idCliente) references cliente(idCliente)
                );
                
-- Criaçao da tabela Pedido --
create table pedido(idPedido int,
                    status_pedido enum('Processando', 'Em separaçao', 'A caminho', 'Entregue') default 'Processando',
                    idCliente int,
                    frete decimal(10,2) not null,
                    constraint pk_idPedido primary key(idPedido),
                    constraint fk_cliente_idCliente2 foreign key(idCliente) references cliente(idCliente)
                    );
                    
-- Criaçao da tabela Pagamento --
create table pagamento(idPagamento int,
                       formaPagamento varchar(20) not null,
                       valor decimal(10,2) not null,
                       status_pagamento varchar(20),
                       idPedido int not null,
                       constraint pk_idPagamento primary key(idPagamento),
                       constraint fk_pedido_idPedido foreign key(idPedido) references pedido(idPedido)
                       );
                       
-- Criaçao da tabela Entrega --
create table entrega(concluida tinyint,
                     obeservaçao varchar(45),
                     idPedido int,
                     constraint pk_idPedido primary key(idPedido),
                     constraint fk_pedido_idPedid foreign key(idPedido) references pedido(idPedido)
                     );
                     
-- Criaçao da tabela Produto --
create table produto(idProduto int,
                     categoria varchar(15) not null,
                     descriçao varchar(45),
                     valor decimal(10,2) not null,
                     constraint pk_idProduto primary key(idProduto)
                     );
                     
-- Criaçao da tabela Relaçao Produto por Pedido --
create table relaçaoProdutoporPedido(idPedido int,
                                     idProduto int,
                                     quantidade int not null,
                                     constraint pk_Ppedido_idPedido_produto_idProduto primary key(idPedido, idProduto),
                                     constraint fk_pedido_idPedido1 foreign key(idPedido) references pedido(idPedido),
                                     constraint fk_produto_idProduto foreign key(idProduto) references produto(idProduto)
                                     );
                     
-- Criaçao de tabela Vendedor --
create table vendedor(idVendedor int,
					  razaoSocial varchar(45),
                      cnpj char(14),
                      local varchar(30) not null,
                      constraint unique_cnpj unique(cnpj),
                      constraint pk_idVendedor primary key(idVendedor)
                      );
                      
-- Criaçao da tabela Quantidade por vendedor --
create table quantidade_por_vendedor(idVendedor int,
                                     idProduto int,
                                     quantidade int not null,
                                     constraint pk_vendedor_idVendedor_produto_idProduto primary key(idVendedor, idProduto),
                                     constraint fk_vendedor_idVendedor foreign key(idVendedor) references vendedor(idVendedor),
                                     constraint fk_produto_idProduto2 foreign key(idProduto) references produto(idProduto)
                                     );
                                     
-- Criaçao da tabela Estoque --
create table estoque(idEstoque int,
                     Local varchar(30) not null,
                     constraint pk_idEstoque primary key(idEstoque)
                     );
                     
-- Criaçao da tabela Produto Local Estoque --
create table produto_loca_estoque(idProduto int,
                                  idEstoque int,
                                  quantidade int not null,
                                  constraint pk_estoque_ProdutoLocalEstoque_idProduto_idEstoque primary key(idProduto, idEstoque),
                                  constraint fk_produto_idProduto1 foreign key(idProduto) references produto(idProduto),
                                  constraint fk_estoque_idEstoque foreign key(idEstoque) references estoque(idEstoque)
                                  );
                                  
-- Criaçao da tabela Fornecedor --
create table fornecedor(idFornecedor int,
                        razaoSocial varchar(45) not null,
                        cnpj char(14) not null,
                        constraint unique_cnpj unique(cnpj),
                        constraint pk_idFornecedor primary key(idFornecedor)
                        );
				
-- Criaçao da tabela Fornecedor Produto --
create table fornecedor_produto(idFornecedor int,
                                idProduto int,
                                constraint pk_fornecedor_idFornecedor_produto_idProduto primary key(idFornecedor, idProduto),
                                constraint fk_fornecedor_idFornecedor foreign key(idFornecedor) references fornecedor(IdFornecedor),
                                constraint fk_produto_idProduto3 foreign key(idProduto) references produto(idProduto)
                                );
                                
-- Inserçao de dados na tabela Cliente -- (id_cliente, tipo_cliente, nome, sobrenome, email, rua, numero, complemento, cep, cidade, estado) --
insert into cliente values('1','PF','Joao','Oliveira','ansb@gmail.com','Natal','101',null,'31401981','Belo Horizonte','MG'),
						  (null,'PF','Natalia','Vasconcelos','nati@gmail.com','do trabalhador','480','Ap-301','20403010','Rio de Janeiro','RJ'),   
						  (null,'PJ','Ipiranga Motos','Isento','ipi@hotmail.com','Brasil','1300','Loja 3','20450091','Rio de Janeiro','RJ'),   
						  (null,'PF','Henrique','Oliveira','rick@icloud.com','Lourival Dantas','27',null,'38401062','Uberlandia','MG'),   
						  (null,'PF','Amanda','Rossini','amanda@gmail.com','Adriano Bailoni','220','Ap-401','38401118','Uberlandia','MG'),   
						  (null,'PF','Rafaela','Araujo','rafinha@hotmail.com','Arnaldo Contursi','600',null,'38401740','Uberlandia','MG'),   
						  (null,'PF','Luana','Araujo','luana@icloud.com','Balaiadas','440','Ap-802','38401108','Uberlandia','MG'),   
						  (null,'PJ','Cabral Som',null,'cabral@gmail.com','Anhanguera','3001',null,'31500660','Belo Horizonte','MG'),   
						  (null,'PJ','Gow games',null,'gow1335@hotmail.com','Presidente Vargas','680',null,'20130808','Rio de Janeiro','RJ'),   
						  (null,'PF','Franciele','Rossini','fran@gmail.com','Cesario Crosara','450','Ap-303','38401001','Uberlandia','MG');
                          
-- Inserçao de dados na tabela Pessoa Fisica -- (cpf, data_nascimento, idCliente) --  
insert into pf values('12345678910','2006-08-13','1'),
					 ('12345678911','1975-03-22','2'),
                     ('12345678912','2008-02-18','4'),
                     ('12345678913','2000-06-19','5'),
                     ('12345678914','2003-11-01','6'),
                     ('12345678915','2002-05-19','7'),
                     ('12345678916','2001-12-12','10');
                     
-- Inserçao de dados na tabela Pessoa Juridica -- (cnpj, razao_social, idCliente) --  
insert into pj values('10235987000120','Ipiranga Motos','3'),
                     ('10235987000121','Cabral Som','8'),
			         ('10235987000122','Gow Games','9');
                          
select * from cliente;
show tables;