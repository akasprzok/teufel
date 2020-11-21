defmodule Teufel.Repo do
  use Ecto.Repo,
    otp_app: :teufel,
    adapter: Ecto.Adapters.Postgres
end
