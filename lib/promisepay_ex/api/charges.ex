defmodule PromisepayEx.API.Charges do
  @moduledoc """
  Provides charges API interfaces.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  def charges do
    charges([])
  end

  @spec charges(Keyword.t) :: Keyword.t
  def charges(options) do
    params = Parser.parse_request_params(options)
    %{charges: charge_results} = request(:get, "charges/", params)
    Enum.map(charge_results, &Parser.parse_charge/1)
  end

  @spec charge(String.t) :: PromisepayEx.Model.Charge.t
  def charge(id) do
    %{charges: charge} = request(:get, "/charges/#{id}", [])
    Parser.parse_charge(charge)
  end

  @spec create_charge(Keyword.t) :: Keyword.t
  def create_charge(options) do
    params = Parser.parse_request_params(options)
    %{charges: charge} = request(:post, "charges", params)
    Parser.parse_charge(charge)
  end
end
