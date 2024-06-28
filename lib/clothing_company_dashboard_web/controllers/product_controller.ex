defmodule ClothingCompanyDashboardWeb.ProductController do
  use ClothingCompanyDashboardWeb, :controller

  alias ClothingCompanyDashboard.Inventory
  alias ClothingCompanyDashboard.Inventory.Product


  def index(conn, params) do
    changeset = Inventory.change_product(%Product{})


    # Extract the parameters from the query string
    category = Map.get(params, "category")
    price_min = Map.get(params, "price_min")
    price_max = Map.get(params, "price_max")
    name = Map.get(params, "name")
    in_stock = Map.get(params, "in_stock")
    products =
      Inventory.list_products_by_attributes(
        category,
        price_min,
        price_max,
        name,
        in_stock
      )

    # Define all possible categories (manually for now, but could be extracted from the database in the future)
    all_categories = ["Tops", "Bottoms", "Outerwear", "Footwear", "Accessories", "Dresses"]
    render(conn, :index, products: products, changeset: changeset, category: category, price_min: price_min, price_max: price_max, name: name, in_stock: in_stock, all_categories: all_categories)
  end

  def new(conn, _params) do
    changeset = Inventory.change_product(%Product{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Inventory.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    render(conn, :show, product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    changeset = Inventory.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Inventory.get_product!(id)

    case Inventory.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    {:ok, _product} = Inventory.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end
end
