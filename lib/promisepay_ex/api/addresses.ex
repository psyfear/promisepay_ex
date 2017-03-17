defmodule PromisepayEx.API.Addresses do
  @moduledoc """
  Provides Addresses API interfaces.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  @spec address(String.t) :: PromisepayEx.Model.Address.t
  def address(id) do
    %{addresses: address} = request(:get, "/addresses/#{id}", [])
    Parser.parse_address(address)
  end
end
