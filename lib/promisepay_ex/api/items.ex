defmodule PromisepayEx.API.Items do
  @moduledoc """
  Provides items API interfaces.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  def items do
    items([])
  end

  @spec items(Keyword.t) :: Keyword.t
  def items(options) do
    params = Parser.parse_request_params(options)
    %{items: item_results} = request(:get, "items/", params)
    Enum.map(item_results, &Parser.parse_item/1)
  end

  @spec item(String.t) :: PromisepayEx.Model.Item.t
  def item(id) do
    %{items: item} = request(:get, "/items/#{id}", [])
    Parser.parse_item(item)
  end
end
