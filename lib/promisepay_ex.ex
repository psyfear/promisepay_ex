defmodule PromisepayEx do
  @moduledoc """
  Documentation for PromisepayEx.
  """

  use Application
  @doc false
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
end
