defmodule PromisepayEx.API.Fees do
  @moduledoc """
  Provides fees API interfaces.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  def fees do
    fees([])
  end

  @spec fees(Keyword.t) :: Keyword.t
  def fees(options) do
    params = Parser.parse_request_params(options)
    %{fees: fee_results} = request(:get, "fees/", params)
    Enum.map(fee_results, &Parser.parse_fee/1)
  end
end
