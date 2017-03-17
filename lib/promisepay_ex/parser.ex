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
  Parse batch transaction record from the API response json.
  """
  @spec parse_batch_transaction(Map.t) :: Map.t
  def parse_batch_transaction(object) do
    struct(PromisepayEx.Model.BatchTransaction, object)
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
end
