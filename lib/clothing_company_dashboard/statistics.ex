defmodule ClothingCompanyDashboard.Statistics do
  import Ecto.Query
  alias ClothingCompanyDashboard.Repo
  alias ClothingCompanyDashboard.Inventory.Product
  alias ClothingCompanyDashboard.Sales.Transaction

  def get_statistics do
    %{
      total_products_in_stock: total_products_in_stock(),
      best_selling_product: best_selling_product(),
      transactions_per_month: transactions_per_month(),
      sales_per_month_last_year: sales_per_month_last_year(),
      total_price_of_products_in_stock: total_price_of_products_in_stock()
    }
  end

  def total_products_in_stock do
    Repo.aggregate(Product, :sum, :stock, [])
  end

  def total_price_of_products_in_stock do
    query =
      from p in Product,
      select: %{total_price: sum(p.price * p.stock)}

    Repo.one(query)
    |> Map.get(:total_price, Decimal.new("0.0"))  # Default to 0.0 if no products are found
  end


  def best_selling_product do
    # Get the product with the highest total quantity sold during last 12 months

    Repo.one(
      from t in Transaction,
      join: p in Product, on: t.product_id == p.id,
      where: t.processed_at > fragment("NOW() - INTERVAL '1 year'"),
      group_by: p.id,
      order_by: [desc: sum(t.quantity)],
      limit: 1,
      select: [p.title, sum(t.quantity)]
    )
  end

  def transactions_per_month do
    Repo.all(
      from t in Transaction,
      group_by: [fragment("date_trunc('month', CAST(? AS timestamp))", t.processed_at)],
      select: %{month: fragment("date_trunc('month', CAST(? AS timestamp))", t.processed_at), count: count(t.id)},
      order_by: [asc: fragment("date_trunc('month', CAST(? AS timestamp))", t.processed_at)]
    )
    |> Enum.map(fn %{month: month, count: count} ->
      %{month: format_month(month), count: count}
    end)
  end

  defp format_month(month) do
    # Show only the month and year like "June 2024"
    NaiveDateTime.to_date(month) # 2024-06-01
    |> Date.to_string # "2024-06-01"
    |> String.split("-") # ["2024", "06", "01"]
    |> Enum.take(2) # ["2024", "06"]
    |> Enum.join("-") # "2024-06"
  end

  def sales_per_month_last_year do
    Repo.all(
      from t in Transaction,
      group_by: [fragment("date_trunc('month', CAST(? AS timestamp))", t.processed_at)],
      select: %{month: fragment("date_trunc('month', CAST(? AS timestamp))", t.processed_at), count: count(t.id), total_price: sum(t.total_price)},
      order_by: [asc: fragment("date_trunc('month', CAST(? AS timestamp))", t.processed_at)]
    )
    |> Enum.map(fn %{month: month, count: count, total_price: total_price} ->
      %{month: format_month(month), count: count, total_price: total_price}
    # Sort by
    end)
  end

  def get_inventory do
    Repo.all(Product)
  end

  def get_transactions do
    query =
      from t in Transaction,
        join: p in Product, on: t.product_id == p.id,
        select: %{product_title: p.title, quantity: t.quantity, date: t.processed_at}

    Repo.all(query)
  end
end
