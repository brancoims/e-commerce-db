# 🛒 E-commerce Database Model

Este repositório contém a modelagem e os scripts de criação para um banco de dados básico de E-commerce. O objetivo principal é demonstrar a estrutura de tabelas, relacionamentos (chaves estrangeiras) e restrições de integridade através de código SQL puro.

## 🛠️ Tecnologias Utilizadas
* *Banco de Dados:* [Insira aqui o seu SGBD, ex: MySQL / PostgreSQL / SQLite]
* *Linguagem:* SQL

## 📐 Diagrama de Entidade-Relacionamento (DER)
O próprio GitHub renderiza o diagrama abaixo com base na estrutura do banco:

mermaid
erDiagram
    CLIENTE ||--o{ PEDIDO : "faz"
    PRODUTO ||--o{ ITEM_PEDIDO : "contem"
    PEDIDO ||--|{ ITEM_PEDIDO : "possui"

    CLIENTE {
        int id PK
        string nome
        string email UK
    }
    PRODUTO {
        int id PK
        string nome
        decimal preco
        int estoque
    }
    PEDIDO {
        int id PK
        int cliente_id FK
        date data_pedido
        decimal total
    }
    ITEM_PEDIDO {
        int pedido_id FK
        int produto_id FK
        int quantidade
        decimal preco_unitario
    }


## 📂 Estrutura do Repositório
* schema.sql: Contém os comandos de criação das tabelas, chaves primárias, chaves estrangeiras e regras (como UNIQUE e NOT NULL).
* seed.sql: Contém dados fictícios de teste (clientes, produtos e pedidos simulados) para popular o banco.

## 🚀 Como Rodar o Projeto

Para replicar este banco de dados localmente, siga os passos abaixo:

1. Abra o terminal ou a ferramenta de gerenciamento do seu banco de dados (ex: DBeaver, pgAdmin, phpMyAdmin).
2. Crie um banco de dados vazio chamado ecommerce.
3. Execute o script de estrutura para criar as tabelas:
   bash
   # Comando de exemplo via terminal (se aplicável)
   # Ou apenas copie e cole o conteúdo do arquivo no seu console SQL
   
   Execute o conteúdo do arquivo *schema.sql*.
4. Execute o script de dados para popular as tabelas com exemplos de teste:
   Execute o conteúdo do arquivo *seed.sql*.

---
Projeto desenvolvido para fins de estudo e portfólio.
