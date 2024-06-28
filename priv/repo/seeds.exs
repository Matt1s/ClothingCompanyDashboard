alias ClothingCompanyDashboard.Repo
alias ClothingCompanyDashboard.Inventory.Product

products = [
  %Product{photo: "photo1.jpg", title: "T-Shirt", description: "Comfortable cotton T-shirt", category: "Tops", price: 19.99, stock: 100},
  %Product{photo: "photo2.jpg", title: "Jeans", description: "Stylish denim jeans", category: "Bottoms", price: 49.99, stock: 50},
  %Product{photo: "photo3.jpg", title: "Jacket", description: "Warm winter jacket", category: "Outerwear", price: 99.99, stock: 30},
  %Product{photo: "photo4.jpg", title: "Sneakers", description: "Sporty sneakers", category: "Footwear", price: 69.99, stock: 75},
  %Product{photo: "photo5.jpg", title: "Hat", description: "Casual hat", category: "Accessories", price: 14.99, stock: 200},
  %Product{photo: "photo6.jpg", title: "Dress", description: "Elegant evening dress", category: "Dresses", price: 59.99, stock: 20},
  %Product{photo: "photo7.jpg", title: "Socks", description: "Warm woolen socks", category: "Accessories", price: 7.99, stock: 300},
  %Product{photo: "photo8.jpg", title: "Scarf", description: "Cozy winter scarf", category: "Accessories", price: 12.99, stock: 150},
  %Product{photo: "photo9.jpg", title: "Shorts", description: "Casual summer shorts", category: "Bottoms", price: 24.99, stock: 60},
  %Product{photo: "photo10.jpg", title: "Blouse", description: "Formal blouse", category: "Tops", price: 29.99, stock: 40}
]

for product <- products do
  Repo.insert!(product)
end
