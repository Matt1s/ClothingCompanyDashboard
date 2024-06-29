alias ClothingCompanyDashboard.Repo
alias ClothingCompanyDashboard.Inventory.Product
alias ClothingCompanyDashboard.Sales.Transaction
import Ecto.Query
require Logger


categories = ["Tops", "Bottoms", "Outerwear", "Footwear", "Accessories", "Dresses"]
price_min = 0
price_max = 150
products = []

products = [
  %Product{photo: "/images/dummy100x100.png", title: "T-Shirt", description: "Cotton T-shirt", category: "Tops", price: 19.99, stock: 100},
  %Product{photo: "/images/dummy100x100.png", title: "Jeans", description: "Stylish denim jeans", category: "Bottoms", price: 49.99, stock: 50},
  %Product{photo: "/images/dummy100x100.png", title: "Jacket", description: "Warm winter jacket", category: "Outerwear", price: 99.99, stock: 30},
  %Product{photo: "/images/dummy100x100.png", title: "Sneakers", description: "Sporty sneakers", category: "Footwear", price: 69.99, stock: 75},
  %Product{photo: "/images/dummy100x100.png", title: "Hat", description: "Casual hat", category: "Accessories", price: 14.99, stock: 200},
  %Product{photo: "/images/dummy100x100.png", title: "Dress", description: "Elegant evening dress", category: "Dresses", price: 59.99, stock: 20},
  %Product{photo: "/images/dummy100x100.png", title: "Socks", description: "Warm woolen socks", category: "Accessories", price: 7.99, stock: 300},
  %Product{photo: "/images/dummy100x100.png", title: "Scarf", description: "Cozy winter scarf", category: "Accessories", price: 12.99, stock: 150},
  %Product{photo: "/images/dummy100x100.png", title: "Shorts", description: "Casual summer shorts", category: "Bottoms", price: 24.99, stock: 60},
  %Product{photo: "/images/dummy100x100.png", title: "Blouse", description: "Formal blouse", category: "Tops", price: 29.99, stock: 40}
]


# First, remove all existing products
Repo.delete_all(Product)

# Add random products
for _ <- 1..100 do
  category = Enum.random(categories)
  price = Enum.random(price_min..price_max)
  stock = Enum.random(1..100)
  product = %Product{
    photo: "/images/dummy100x100.png",
    title: "Random Product #{Enum.random(1000..9999)}",
    description: "",
    category: category,
    price: Decimal.new(price),
    stock: stock
  }
  # Insent product into products list
  Repo.insert!(product)
  Logger.info("Inserted product: #{product.title}")
end

for product <- products do
  Repo.insert!(product)
end

# Remove all transactions
Repo.delete_all(Transaction)

# Add random transactions
for _ <- 1..100 do
  product = Repo.one(from p in Product, order_by: fragment("RANDOM()"), limit: 1)
  quantity = Enum.random(1..10)
  total_price = Decimal.mult(product.price, quantity)

  # processed_at should be random date in the last year
  processed_at = DateTime.utc_now() |> DateTime.add(-Enum.random(1..365) * 24 * 60 * 60)

  # remove microseconds from the timestamp
  processed_at = processed_at |> DateTime.truncate(:second)
  transaction = %Transaction{
    quantity: quantity,
    total_price: total_price,
    product_id: product.id,
    processed_at: processed_at
  }
  Repo.insert!(transaction)
  Logger.info("Inserted transaction: #{transaction.id}")
end

Logger.info("Seeds inserted successfully!")
