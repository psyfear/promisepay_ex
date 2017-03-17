defmodule PromisepayEx.Model.Transaction do
  @moduledoc """
  Transaction object.

  ## Reference
  https://reference.assemblypayments.com/#show-transaction
  """

  defstruct account_id: nil,
            account_type: nil,
            amount: nil,
            created_at: nil,
            currency: nil,
            id: nil,
            debit_credit: nil,
            description: nil,
            related: nil,
            type_method: nil,
            state: nil,
            type: nil,
            updated_at: nil,
            user_id: nil,
            user_name: nil

  @type t :: %__MODULE__{}
end
