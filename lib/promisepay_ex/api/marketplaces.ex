defmodule PromisepayEx.API.Marketplaces do
  @moduledoc """
  Provides marketplaces API interfaces.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  @spec marketplace(String.t) :: PromisepayEx.Model.Marketplace.t
  def marketplace(id) do
    %{marketplaces: marketplace} = request(:get, "marketplaces/#{id}", [])
    Parser.parse_marketplace(marketplace)
  end
end
