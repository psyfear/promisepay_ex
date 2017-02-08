defmodule PromisepayEx.Config do
  @moduledoc """
  Configuration module
  """

  alias PromisepayEx.Config

  def current_scope do
    if Process.get(:_promisepay_ex_auth, nil), do: :process, else: :global
  end

  @doc """
  Get configuration values.
  """
  def get, do: get(current_scope())

  @spec get(:global) :: Keyword.t
  def get(:global) do
    Application.get_env(:promisepay_ex, :auth, nil)
  end

  def get(:process), do: Process.get(:_promisepay_ex_auth, nil)

  @doc """
  Set configuration values.
  """
  @spec set(String.t) :: :ok
  def set(value), do: set(current_scope(), value)

  @spec set(:global, String.t) :: Map.t
  def set(:global, value), do: Application.put_env(:promisepay_ex, :auth, value)

  def set(:process, value) do
    Process.put(:_promisepay_ex_auth, value)
    :ok
  end

  @doc """
  Get configuration values in tuple format.
  """
  def get_tuples do
    case Config.get do
      nil -> []
      [username: nil, token: nil, environment: nil, api_domain: nil] -> []
      tuples -> tuples
    end
  end
end
