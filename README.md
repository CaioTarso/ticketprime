# 🎫 TicketPrime – Sistema de Venda de Ingressos e Eventos

TicketPrime é uma aplicação Ruby on Rails projetada para gerenciamento de eventos, permitindo a criação, listagem e organização de eventos com funcionalidades de carrinho de compras e emissão de pedidos.

🔗 **Sistema em Produção:**
[https://ticketprime.onrender.com](https://ticketprime.onrender.com)

-----

## 🚀 Funcionalidades Principais

### ✅ Área Pública (Catálogo e Vendas)

  * Listagem de eventos disponíveis (nome, categoria, data e preço).
  * Visualização detalhada do evento.
  * Funcionalidade de **Carrinho de Compras** (`carts` e `cart_items`).
  * Registro e autenticação de usuários.
  * Geração de pedidos (`orders`) e itens de pedido (`order_items`).

### ✅ Área Administrativa (Gerenciamento de Conteúdo)

  * Cadastro de eventos (com controle de ingressos disponíveis).
  * Edição e exclusão de eventos.
  * Associação de eventos a usuários (gerenciamento por usuário).
  * Validações server-side robustas.

### 🔧 Recursos Técnicos

  * Backend MVC robusto com Ruby on Rails 7.1.
  * Estrutura otimizada para PostgreSQL em produção.
  * Containerização com Docker + Docker Compose.
  * Uso de Active Storage para futuros uploads (imagens de eventos).

-----

## 📊 Estrutura e Banco de Dados (PostgreSQL)

O banco de dados PostgreSQL é a espinha dorsal do sistema, suportando uma estrutura transacional de e-commerce e ticketing.

### Modelos Principais

A arquitetura do banco é centrada nos seguintes modelos:

  * **Usuários (`users`):** Gerencia autenticação e é a base para todos os relacionamentos de compra e ticketing.
  * **Eventos (`events`):** O item principal à venda, contendo detalhes como preço e disponibilidade de ingressos.
  * **Carrinho (`carts` e `cart_items`):** Implementa a lógica de carrinho de compras, ligando itens (`cart_items`) aos eventos e ao usuário.
  * **Pedidos (`orders` e `order_items`):** Registra as transações finalizadas e os detalhes do evento comprado.
  * **Tickets (`tickets`):** Representa o ingresso final, com associações a um evento e um usuário.
  * **Active Storage:** Tabelas dedicadas (`active_storage_attachments`, etc.) para gerenciamento futuro de arquivos.

A estrutura permite que um usuário tenha vários pedidos e ingressos, e cada evento possa ser associado a múltiplos itens de carrinho e pedidos.

-----

## 🛠️ Stack Tecnológica

  * **Backend:** Ruby on Rails 7.1
  * **Banco de Dados (Prod):** PostgreSQL
  * **Banco de Dados (Dev):** SQLite
  * **Frontend:** ERB, HTML5, CSS e Bootstrap
  * **Containerização:** Docker + Docker Compose
  * **Processos:** Puma
  * **Assets:** Pipeline padrão do Rails

-----

## 📋 Pré-requisitos (para desenvolvimento local)

  * Ruby 3.3.x
  * Rails 7.1.x
  * Docker e Docker Compose (opcional, porém recomendado)
  * SQLite3

-----

## 🔧 Instalação e Configuração

### ▶️ Opção 1 — Rodar localmente (sem Docker)

1.  **Clone o repositório**

    ```bash
    git clone https://github.com/SEU_USUARIO/ticketprime.git
    cd ticketprime
    ```

2.  **Instale dependências**

    ```bash
    bundle install
    ```

3.  **Crie o banco e rode as migrações**

    ```bash
    rails db:create db:migrate db:seed
    ```

4.  **Suba o servidor**

    ```bash
    rails server
    ```

A aplicação estará disponível em **[http://localhost:3000](https://www.google.com/search?q=http://localhost:3000)**

-----

## 🐳 ▶️ Opção 2 — Rodar com Docker (recomendado)

1.  **Suba os containers**

    ```bash
    docker compose up --build
    ```

2.  **Acesse a aplicação**

      * App: [http://localhost](https://www.google.com/search?q=http://localhost)

3.  **Primeiro uso (configuração do BD)**

    ```bash
    docker compose exec web rails db:create db:migrate db:seed
    ```

-----


## 🎯 Roadmap Futuro

  * [ ] Painel administrativo completo para visualização de pedidos e ingressos.
  * [ ] Implementação de pagamento (Stripe/PagSeguro).
  * [ ] Envio de tickets por e-mail.
  * [ ] Busca e filtragem avançada de eventos.

-----