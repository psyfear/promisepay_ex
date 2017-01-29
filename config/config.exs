use Mix.Config

config :promisepay_ex, :auth, [
   username: System.get_env("PROMISEPAY_USERNAME"),
   token: System.get_env("PROMISEPAY_TOKEN"),
   environment: System.get_env("PROMISEPAY_ENVIRONMENT"),
   api_domain: System.get_env("PROMISEPAY_API_DOMAIN"),
]
