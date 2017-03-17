defmodule PromisepayEx.Model.WalletAccount do
  @moduledoc """
  User object.

  ## Reference
  https://reference.assemblypayments.com/#show-user
  """

  defstruct active: nil,
            balance: nil,
            created_at: nil,
            currency: nil,
            dob: nil,
            id: nil,
            links: nil,
            updated_at: nil

  @type t :: %__MODULE__{}
end
