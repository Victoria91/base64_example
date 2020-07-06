use Mix.Config

config :base64_example, ecto_repos: [Base64Example.Repo]

# Configure your database
config :base64_example, Base64Example.Repo,
  username: "postgres",
  password: "postgres",
  database: "base64_example_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  ownership_timeout: 120_000

config :waffle,
  storage: Waffle.Storage.S3,
  bucket: System.get_env("AWS_S3_BUCKET"),
  asset_host: System.get_env("ASSET_HOST", "")

config :ex_aws,
  json_codec: Jason,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  s3: [
    scheme: System.get_env("AWS_SCHEME", "https://")
  ],
  region: System.get_env("AWS_REGION", "us-west-1")
