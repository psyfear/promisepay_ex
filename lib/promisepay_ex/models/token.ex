defmodule PromisepayEx.Model.Token do
  @moduledoc """
  Token object.

  ## Reference
  https://reference.promisepay.com/#token_auth
  """

  defstruct token_type: nil,
            token: nil,
            user_id: nil

  @type t :: %__MODULE__{}
end
