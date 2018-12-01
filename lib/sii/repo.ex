defmodule Sii.Repo do
  use Ecto.Repo,
    otp_app: :sii,
    adapter: Ecto.Adapters.Postgres
end
