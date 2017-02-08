defmodule PromisepayEx.Parser do
  @moduledoc """
  Provides parser logics for API results.
  """

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
end
