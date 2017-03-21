defmodule PromisepayEx.Parser do
  @moduledoc """
  Provides parser logics for API results.
  """

  @doc """
  Parse address record from the API response json.
  """
  @spec parse_address(Map.t) :: Map.t
  def parse_address(object) do
    struct(PromisepayEx.Model.Address, object)
  end

  @doc """
  Parse item record from the API response json.
  """
  @spec parse_item(Map.t) :: Map.t
  def parse_item(object) do
    struct(PromisepayEx.Model.Item, object)
  end

  @doc """
  Parse request parameters for the API.
  """
  @spec parse_request_params(Map.t) :: Map.t
  def parse_request_params(options) do
    Enum.map(options, fn({k,v}) -> {to_string(k), to_string(v)} end)
  end

  @doc """
  Parse token record from the API response json.
  """
  @spec parse_token(Map.t) :: Map.t
  def parse_token(object) do
    struct(PromisepayEx.Model.Token, object)
  end

  @doc """
  Parse transaction record from the API response json.
  """
  @spec parse_transaction(Map.t) :: Map.t
  def parse_transaction(object) do
    struct(PromisepayEx.Model.Transaction, object)
  end

  @doc """
  Parse user record from the API response json.
  """
  @spec parse_user(Map.t) :: Map.t
  def parse_user(object) do
    struct(PromisepayEx.Model.User, object)
  end

  @doc """
  Parse wallet account record from the API response json.
  """
  @spec parse_wallet_account(Map.t) :: Map.t
  def parse_wallet_account(object) do
    struct(PromisepayEx.Model.WalletAccount, object)
  end

  @doc """
  Parse company record from the API response json.
  """
  @spec parse_company(Map.t) :: Map.t
  def parse_company(object) do
    struct(PromisepayEx.Model.Company, object)
  end
end
