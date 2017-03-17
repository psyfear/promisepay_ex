defmodule PromisepayEx do
  @moduledoc """
  Documentation for PromisepayEx.
  """

  use Application
  @doc false
  @spec start(String.t, Keyword.t) :: :ok
  def start(_type, _args) do
    PromisepayEx.Supervisor.start_link
  end

  # -------------- PromisepayEx Settings -------------

  @doc """
  Provides configuration settings for accessing Promisepay API.

  The specified configuration applies globally. Use `PromisepayEx.configure/2`
  for setting different configurations on each processes.

  ## Examples

      PromisepayEx.configure(
        username: System.get_env("PROMISEPAY_USERNAME"),
        token: System.get_env("PROMISEPAY_TOKEN"),
        environment: System.get_env("PROMISEPAY_ENVIRONMENT"),
        api_domain: System.get_env("PROMISEPAY_API_DOMAIN"),
      )

  """
  @spec configure(Keyword.t) :: :ok
  defdelegate configure(auth), to: PromisepayEx.Config, as: :set

  @doc """
  Provides configuration settings for accessing Promisepay API.

  ## Options

    The `scope` can have one of the following values.

    * `:global` - configuration is shared for all processes.

    * `:process` - configuration is isolated for each process.

  ## Examples

      PromisepayEx.configure(
        :process,
        username: System.get_env("PROMISEPAY_USERNAME"),
        token: System.get_env("PROMISEPAY_TOKEN"),
        environment: System.get_env("PROMISEPAY_ENVIRONMENT"),
        api_domain: System.get_env("PROMISEPAY_API_DOMAIN"),
      )

  """
  @spec configure(:global | :process, Keyword.t) :: :ok
  defdelegate configure(scope, auth), to: PromisepayEx.Config, as: :set

  @doc """
  Returns current configuration settings for accessing promisepay server.
  """
  @spec configure :: Keyword.t | nil
  defdelegate configure, to: PromisepayEx.Config, as: :get

  @doc """
  Provides generic Promisepay API Access

  This method simply returns parsed json in Map structure.

  ## Examples

      PromisepayEx.request(:get, "users/", [limit: 10, offset: 1])

  """
  @spec request(:get | :post, String.t, Keyword.t) :: Map
  defdelegate request(method, path, params), to: PromisepayEx.API.Base

  # -------------- Addresses -------------

  @doc """
  Show details of a specific Address using a given :id.

  GET /addresses/:id
  ## Reference

      https://reference.assemblypayments.com/#addresses

  ## Examples

      PromisepayEx.address('address_id')

  """
  defdelegate address(id), to: PromisepayEx.API.Addresses

  # -------------- Items -------------

  @doc """
  Retrieve an ordered and paginated list of existing Items.

  GET /items
  ## Reference

      https://reference.promisepay.com/#list-items

  ## Examples

      PromisepayEx.items([limit: 10, offset: 1])

  """
  defdelegate items, to: PromisepayEx.API.Items
  defdelegate items(params), to: PromisepayEx.API.Items

  @doc """
  Retrieve an item.

  GET /items/:id
  ## Reference

      https://reference.promisepay.com/#show-item

  ## Examples

      PromisepayEx.item('itemid')

  """
  defdelegate item(id), to: PromisepayEx.API.Items

  @doc """
  Generates token.

  POST /token_auths
  ## Reference

      https://reference.assemblypayments.com/#token-auth

  ## Examples

      options = %{token_type: "card", user_id: "user_id"}
      PromisepayEx.generate_token(options)

  """
  defdelegate generate_token(params), to: PromisepayEx.API.Token
end
