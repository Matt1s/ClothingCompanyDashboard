defmodule ClothingCompanyDashboard.SalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ClothingCompanyDashboard.Sales` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        quantity: 42,
        total_price: "120.5"
      })
      |> ClothingCompanyDashboard.Sales.create_transaction()

    transaction
  end
end
