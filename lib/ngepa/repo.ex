defmodule Ngepa.Repo do
  use Ecto.Repo,
    otp_app: :ngepa,
    adapter: Ecto.Adapters.MyXQL
end
