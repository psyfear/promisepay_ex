defmodule PromisepayEx.API.Transactions do
  @moduledoc """
  Provides Transactions API interface.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  def transactions do
    transactions([])
  end

  @spec transactions(Keyword.t) :: Keyword.t
  def transactions(options) do
    params = Parser.parse_request_params(options)
    %{transactions: transaction_list} = request(:get, "transactions/", params)
    Enum.map(transaction_list, &Parser.parse_transaction/1)
  end

  @spec transaction(String.t) :: PromisepayEx.Model.Transaction.t
  def transaction(id) do
    %{transactions: transaction} = request(:get, "/transactions/#{id}", [])
    Parser.parse_transaction(transaction)
  end
end
