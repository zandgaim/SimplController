defmodule Www.Repo do
  use Ecto.Repo,
    otp_app: :www,
    adapter: Ecto.Adapters.Postgres
end
