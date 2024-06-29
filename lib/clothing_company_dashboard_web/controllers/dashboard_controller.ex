defmodule ClothingCompanyDashboardWeb.DashboardController do
  use ClothingCompanyDashboardWeb, :controller
  alias ClothingCompanyDashboard.Statistics

  def index(conn, _params) do
    statistics = Statistics.get_statistics()
    render(conn, "index.html", statistics: statistics)
  end

  def transactions(conn, _params) do
    transactions = Statistics.get_transactions()
    render(conn, "transactions.html", transactions: transactions)
  end

  def inventory(conn, _params) do
    inventory = Statistics.get_inventory()
    render(conn, "inventory.html", inventory: inventory)
  end

  def statistics(conn, _params) do
    stats = Statistics.get_statistics()
    render(conn, "statistics.html", stats: stats)
  end
end
