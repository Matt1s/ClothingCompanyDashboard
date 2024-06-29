defmodule ClothingCompanyDashboardWeb.ProductController do
  use ClothingCompanyDashboardWeb, :controller

  alias ClothingCompanyDashboard.Inventory
  alias ClothingCompanyDashboard.Inventory.Product

  def index(conn, params) do
    changeset = Inventory.change_product(%Product{})


    # Extract the parameters from the query string
    categories = Map.get(params, "categories")
    price_min = Map.get(params, "price_min")
    price_max = Map.get(params, "price_max")
    name = Map.get(params, "name")
    in_stock = Map.get(params, "in_stock")
    products =
      Inventory.list_products_by_attributes(
        categories,
        price_min,
        price_max,
        name,
        in_stock
      )

    # Define all possible categories (manually for now, but could be extracted from the database in the future)
    all_categories = ["Tops", "Bottoms", "Outerwear", "Footwear", "Accessories", "Dresses"]
    render(conn, :index, products: products, changeset: changeset, categories: categories, price_min: price_min, price_max: price_max, name: name, in_stock: in_stock, all_categories: all_categories)
  end

  def new(conn, _params) do
    changeset = Inventory.change_product(%Product{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    ensure_uploads_directory_exists()

    # Extract the photo from the parameters
    photo = product_params["photo"]

    # If no photo is provided, create the product without a photo
    if photo == nil do
      case Inventory.create_product(product_params) do
        {:ok, product} ->
          conn
          |> put_flash(:info, "Product created successfully.")
          |> redirect(to: ~p"/products/#{product}")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :new, changeset: changeset)
      end
    end
    # Define the uploads path
    upload_path = Path.join(["priv", "static", "images", photo.filename])

    # Save the photo to the uploads directory
    case File.cp(photo.path, upload_path) do
      :ok ->
        # Update product_params to include the photo path
        updated_product_params = Map.put(product_params, "photo", "/images/" <> photo.filename)

        case Inventory.create_product(updated_product_params) do
          {:ok, product} ->
            conn
            |> put_flash(:info, "Product created successfully.")
            |> redirect(to: ~p"/products/#{product}")

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, :new, changeset: changeset)
        end

      {:error, reason} ->
        conn
        |> put_flash(:error, "Failed to upload photo: #{reason}")
        |> render(:new, changeset: Inventory.change_product(%Product{}))
    end
  end

  defp ensure_uploads_directory_exists do
    uploads_path = Path.join(["priv", "static", "images"])
    unless File.dir?(uploads_path) do
      File.mkdir_p!(uploads_path)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    render(conn, :show, product: product)
  end

  # Support for editing a product with photo upload
  def edit(conn, %{"id" => id}) do
    product = Inventory.get_product!(id)
    changeset = Inventory.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Inventory.get_product!(id)

    # Extract the photo from the parameters
    photo = product_params["photo"]

    # If no photo is provided, update the product without a photo
    if photo == nil do
      case Inventory.update_product(product, product_params) do
        {:ok, product} ->
          conn
          |> put_flash(:info, "Product updated successfully.")
          |> redirect(to: ~p"/products")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :edit, product: product, changeset: changeset)
      end
    end

    # Define the uploads path
    upload_path = Path.join(["priv", "static", "images", photo.filename])

    # Save the photo to the uploads directory
    case File.cp(photo.path, upload_path) do
      :ok ->
        # Update product_params to include the photo path
        updated_product_params = Map.put(product_params, "photo", "/images/" <> photo.filename)

        case Inventory.update_product(product, updated_product_params) do
          {:ok, product} ->
            conn
            |> put_flash(:info, "Product updated successfully.")
            |> redirect(to: ~p"/products/#{product.id}")

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, :edit, product: product, changeset: changeset)
        end

      {:error, reason} ->
        conn
        |> put_flash(:error, "Failed to upload photo: #{reason}")
        |> render(:edit, product: product, changeset: Inventory.change_product(product))
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
