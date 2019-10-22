defmodule Takemefrom.Repo do
  use Ecto.Repo,
    otp_app: :takemefrom,
    adapter: Ecto.Adapters.Postgres
end
