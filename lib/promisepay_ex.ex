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

  # -------------- Transactions -------------

  @doc """
  Retrieve an ordered and paginated list of existing transactions.

  GET /transactions
  ## Reference

      https://reference.assemblypayments.com/#list-transactions

  ## Examples

      PromisepayEx.transactions([limit: 10, offset: 1])

  """
  defdelegate transactions, to: PromisepayEx.API.Transactions
  defdelegate transactions(params), to: PromisepayEx.API.Transactions

  @doc """
  Retrieve a transaction.

  GET /transactions/:id
  ## Reference

      https://reference.assemblypayments.com/#show-transaction

  ## Examples

      PromisepayEx.transaction('transaction_id')

  """
  defdelegate transaction(id), to: PromisepayEx.API.Transactions

  @doc """
  Show the associated object with the Transaction using a given :id.

  GET /transactions/:id/:object
  ## Reference

      https://reference.assemblypayments.com/#show-transaction

  ## Examples

      PromisepayEx.transaction('transaction_id', :user)

  """
  defdelegate transaction(id, type), to: PromisepayEx.API.Transactions

  # -------------- Companies -------------

  @doc """
  Retrieve an ordered and paginated list of existing Companies.

  GET /companies
  ## Reference

      https://reference.assemblypayments.com/#list-companies

  ## Examples

      PromisepayEx.companies([limit: 10, offset: 1])

  """
  defdelegate companies, to: PromisepayEx.API.Companies
  defdelegate companies(params), to: PromisepayEx.API.Companies

  @doc """
  Retrieve a company.

  GET /companies/:id
  ## Reference

      https://reference.assemblypayments.com/#show-company

  ## Examples

      PromisepayEx.company('company_id')

  """
  defdelegate company(id), to: PromisepayEx.API.Companies

  @doc """
  Create a company.

  POST /companies/
  ## Reference

      https://reference.assemblypayments.com/#create-company

  ## Examples

      PromisepayEx.create_company(options)

  """
  defdelegate create_company(options), to: PromisepayEx.API.Companies

  @doc """
  Update a company.

  PATCH /companies/
  ## Reference

      https://reference.assemblypayments.com/#update-company

  ## Examples

      PromisepayEx.update_company(options)

  """
  defdelegate update_company(options), to: PromisepayEx.API.Companies

  # -------------- Fees -------------
  @doc """
  Get Fees.

  Get /fees/
  ## Reference

      https://reference.assemblypayments.com/#list-fees

  ## Examples

      PromisepayEx.fees

  """
  defdelegate fees, to: PromisepayEx.API.Fees

  # -------------- Charges -------------
  @doc """
  Get Charges.

  Get /charges/
  ## Reference

      https://reference.assemblypayments.com/#list-charges

  ## Examples

      PromisepayEx.charges([limit: 10, offset: 1])

  """
  defdelegate charges, to: PromisepayEx.API.Charges

  @doc """
  Show Charge.

  Get /charges/:id
  ## Reference

      https://reference.assemblypayments.com/#show-charge

  ## Examples

      PromisepayEx.charge("f4a701cf-2950-4423-a6bf-604bcf846466")

  """
  defdelegate charge(id), to: PromisepayEx.API.Charges

  @doc """
  Create a charge.

  POST /charges/
  ## Reference

      https://reference.assemblypayments.com/#create-charge

  ## Examples

      PromisepayEx.create_charge(options)

  """
  defdelegate create_charge(options), to: PromisepayEx.API.Charges

  @doc """
  Retrieve a marketplace.

  GET /marketplace/:id
  ## Reference

      https://reference.assemblypayments.com/#show-marketplace

  ## Examples

      PromisepayEx.marketplace('marketplace_id')

  """
  defdelegate marketplace(id), to: PromisepayEx.API.Marketplaces
end
