# How to install

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Checklist
Task 1: Create a simple dashboard interface for a manager of a clothing company. This dashboard should display all products that are available for sale, manager should be able to add, edit and delete the items.

Specifications:

- Use Phoenix framework and Tailwind (Flowbite) ✅
- Use PostgresDB ✅
- Generate seeds for at least 10 products ✅
Each product should have at least these mandatory fields:
- Photo ✅
- Title ✅
- Description ✅
- Category ✅
- Price ✅
- Stock ✅
User must be able to:
- add / edit / delete a product ✅
Implement a filter over the products ✅

Task 2: Create dashboard with statistics/inventory/transactions over the products.

Specifications:

- Use Phoenix framework and Tailwind (Flowbite) ✅
- Use PostgresDB ✅
- Generate seeds for at least 10 transactions ✅
Dashboard should visualize:
- How many products are in stock ✅
- Best selling product ✅
- Number of transactions for the whole month (with filter for months) ✅


Bonus:
- User login screen ✅
- LiveFeed for multiple users ❌
- Using the PubSub module ❌
- Using tags as categories (multiple tags per item) ❌
- Implementation of the filter over multiple tags ✅

# Documentation
## Users (Login/Register)
Web application uses Login/Register generated (and edited) via phx generator, all router (/statistics /products, /transactions, /inventory) are inaccessible before register/login

## Products <code>localhost:4000/products</code>
Products page shows all listings generated via seeders + those already added via "New Product" button.
- On the left side, product filter is included, that allows you to filter by name (prefixes only), by categories (multiple select is implemented), by min/max price as well as In-stock items only
- By clicking onto product or "Edit" button beside product, you are able to change specific attributes of selected product
- Similar to edit, you can add new product by clicking on black button at the top-right side.

- *When adding/editing product, you have to specify all attributes except Photo, specifically Title, Description, Category, Price, Stock

## Statistics <code>localhost:4000/statistics</code>
Statistics dashboard shows useful data about shop
- Total Products in Stock
- Total Value of Stock
- Best Selling Product during last 12 months (data are provided by Transaction Seeder)
- Amount of how much the Best Selling Product sold
- Chart showing Sales during last 12 months
- Chart showing Transactions during last 12 months

## Transactions <code>localhost:4000/transactions</code>
Transactions dashboard shows made transactions (data are provided by Transaction Seeder)
- Table shows latest transactions (currently only one product per transaction, but one product could be included multiple times in single transaction)
- Filter by Month is included

## Inventory <code>localhost:4000/inventory</code>
Inventory dashboard shows stock of the items
- Quantity on Stock
- Price for a single piece
- Whole value of Product Stock (Stock * Price)
