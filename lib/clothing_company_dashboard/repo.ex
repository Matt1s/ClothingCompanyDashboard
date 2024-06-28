defmodule ClothingCompanyDashboard.Repo do
  use Ecto.Repo,
    otp_app: :clothing_company_dashboard,
    adapter: Ecto.Adapters.Postgres
end
