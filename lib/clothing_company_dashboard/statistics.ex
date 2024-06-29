defmodule ClothingCompanyDashboard.Statistics do
  import Ecto.Query
  alias ClothingCompanyDashboard.Repo
  alias ClothingCompanyDashboard.Inventory.Product
  alias ClothingCompanyDashboard.Sales.Transaction

  def get_statistics do
    %{
      total_products_in_stock: total_products_in_stock(),
      best_selling_product: best_selling_product(),
      transactions_per_month: transactions_per_month()
    }
  end

  def total_products_in_stock do
    Repo.aggregate(Product, :sum, :stock)
  end

  def best_selling_product do
    Repo.one(
      from t in Transaction,
      join: p in Product, on: t.product_id == p.id,
      group_by: p.id,
      order_by: [desc: sum(t.quantity)],
      limit: 1,
      select: p.title
    )
  end

  def transactions_per_month do
    Repo.all(
      from t in Transaction,
      group_by: [fragment("date_trunc('month', ?)", t.inserted_at)],
      select: %{month: fragment("date_trunc('month', ?)", t.inserted_at), count: count(t.id)}
    )
  end

  def get_inventory do
    Repo.all(Product)
  end

  def get_transactions do
    query =
      from t in Transaction,
        join: p in Product, on: t.product_id == p.id,
        select: %{product_title: p.title, quantity: t.quantity, date: t.inserted_at}

    Repo.all(query)
  end
end
