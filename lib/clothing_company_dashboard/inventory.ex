defmodule ClothingCompanyDashboard.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias ClothingCompanyDashboard.Repo

  alias ClothingCompanyDashboard.Inventory.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  def list_products_by_attributes(category \\ nil, price_min \\ nil, price_max \\ nil, name \\ nil, in_stock \\ nil) do


    # First, check for empty values and set them to nil
    category = if category == "" do nil else category end
    price_min = if price_min == "" do nil else price_min end
    price_max = if price_max == "" do nil else price_max end
    name = if name == "" do nil else name end
    in_stock = if in_stock == "" do true else in_stock end

    Product
    |> maybe_filter_by_category(category)
    |> maybe_filter_by_price_min(price_min)
    |> maybe_filter_by_price_max(price_max)
    |> maybe_filter_by_name(name)
    |> maybe_filter_by_in_stock(in_stock)
    |> Repo.all()
  end

  defp maybe_filter_by_category(query, nil), do: query
  defp maybe_filter_by_category(query, category), do: (from p in query, where: p.category == ^category)

  defp maybe_filter_by_price_min(query, nil), do: (from p in query, where: p.price >= 0)
  defp maybe_filter_by_price_min(query, price_min), do: (from p in query, where: p.price >= ^Decimal.new(price_min))

  defp maybe_filter_by_price_max(query, nil), do: (from p in query, where: p.price <= 999999999)
  defp maybe_filter_by_price_max(query, price_max), do: (from p in query, where: p.price <= ^Decimal.new(price_max))

  defp maybe_filter_by_name(query, nil), do: query
  defp maybe_filter_by_name(query, name), do: (from p in query, where: fragment("LOWER(?) LIKE LOWER(?)", p.title, ^"%#{name}%"))

  defp maybe_filter_by_in_stock(query, nil), do: query
  defp maybe_filter_by_in_stock(query, _in_stock), do: (from p in query, where: p.stock > 0)

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
