require IEx;

defmodule PromisepayEx.API.Items do
  @moduledoc """
  Provides items API interfaces.
  """

  import PromisepayEx.API.Base

  def items do
    items([])
  end

  def items(options) do
    params = PromisepayEx.Parser.parse_request_params(options)
    %{items: items} = request(:get, "items/", params)
    Enum.map(items, &PromisepayEx.Parser.parse_item/1)
  end

  def item(id) do
    %{items: item} = request(:get, "/items/#{id}", [])
    PromisepayEx.Parser.parse_item(item)
  end
end
