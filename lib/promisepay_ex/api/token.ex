defmodule PromisepayEx.API.Token do
  @moduledoc """
  Generates token.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  @spec generate_token(Keyword.t) :: Keyword.t
  def generate_token(options) do
    params = Parser.parse_request_params(options)
    %{token_auth: token_auth} = request(:post, "token_auths", params)
    Parser.parse_token(token_auth)
  end
end
