defmodule Base64Example.Repo do
  use Ecto.Repo,
    otp_app: :base64_example,
    adapter: Ecto.Adapters.Postgres
end
