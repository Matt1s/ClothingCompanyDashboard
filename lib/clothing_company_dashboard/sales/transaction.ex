defmodule ClothingCompanyDashboard.Sales.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :quantity, :integer
    field :total_price, :decimal
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:quantity, :total_price])
    |> validate_required([:quantity, :total_price])
  end
end
