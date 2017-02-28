use Mix.Config

config :promisepay_ex, :auth, [
   username: System.get_env("PROMISEPAY_USERNAME"),
   password: System.get_env("PROMISEPAY_PASSWORD"),
   environment: System.get_env("PROMISEPAY_ENVIRONMENT"),
   api_domain: System.get_env("PROMISEPAY_API_DOMAIN"),
]

import_config "#{Mix.env}.exs"
