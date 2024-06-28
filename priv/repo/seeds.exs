alias ClothingCompanyDashboard.Repo
alias ClothingCompanyDashboard.Inventory.Product

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

for product <- products do
  Repo.insert!(product)
end
