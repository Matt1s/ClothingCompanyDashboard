defmodule ClothingCompanyDashboard.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :quantity, :integer
      add :total_price, :decimal
      add :product_id, references(:products, on_delete: :delete_all)
      add :processed_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:transactions, [:product_id])
  end

  def down do
    drop table(:transactions)
  end
end
