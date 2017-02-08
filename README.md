# PromisepayEx [![Build Status](https://circleci.com/gh/psyfear/promisepay_ex.svg?style=shield&circle-token=:circle-token "Build Status")](https://circleci.com/gh/psyfear/promisepay_ex)

Promisepay SDK for elixir.

It only supports very limited set of functions yet. A wrapper to authenticate and perform request methods to Promisepay

### Usage
1. Add `promisepay_ex` to deps section in the `mix.exs`.
2. Use `PromisepayEx.configure` to Promisepay Authentication Parameters. See PromisePay <a href="https://reference.promisepay.com/" target="_blank">documentation</a> for more information.
3. Call functions in PromisepayEx module (ex. `PromisepayEx.request(:get, "/users/", [limit: 10, offset: 1])`).

#### Configuration

The default behaviour is to configure using the application environment:

In `config/config.exs`, add:

```elixir
config :promisepay_ex, :auth, [
   username: "",
   token: "",
   environment: "",
   api_domain: ""
]
```

Or manually at runtime:

```elixir
PromisepayEx.configure([username: "", ...])
```

#### mix.exs
```elixir
defp deps do
  [
    {:promisepay_ex, "~> 0.1.0"}
  ]
end

...

def application do
  [applications: [:logger, :promisepay_ex]]
end
```

### Sample
Sample execution on iex.

#### configure
```Elixir
$ iex -S mix
Interactive Elixir - press Ctrl+C to exit (type h() ENTER for help)
```
```Elixir
PromisepayEx.configure(
   username: System.get_env("PROMISEPAY_USERNAME"),
   token: System.get_env("PROMISEPAY_TOKEN"),
   environment: System.get_env("PROMISEPAY_ENVIRONMENT"),
   api_domain: System.get_env("PROMISEPAY_API_DOMAIN"),
)

:ok
```

#### request
Example for getting the marketplace.
```Elixir
iex(27)>  PromisepayEx.request(:get, "/marketplace", [])
%{marketplaces: %{active: true, alt_marketplace_auth: nil,
    alt_marketplace_id: nil, color_1: nil, color_2: nil, color_3: nil,
    color_4: nil, color_5: nil, currency: "AUD",
    email: "test@promisepay.com",
    id: "16788ce2-7d4d-46b3-a7f4-d06b320565fd",
    links: %{company: "/company/10ac7b8a-04d4-42c8-a5fc-6702c9b89bee",
      principal: "/users/1c3db92af5a3cf962c7c029086f693fb",
      self: "/marketplace?limit=10&offset=1"}, logo: nil,
    name: "Awesome Websites", partial_refunds: true,
    payment_frequency: "weekly",
    related: %{company: "10ac7b8a-04d4-42c8-a5fc-6702c9b89bee",
      users: "1c3db92af5a3cf962c7c029086f693fb"}, seller_white_labeled: false,
    short_name: "awesome", state: "pending", website: nil}}
```
