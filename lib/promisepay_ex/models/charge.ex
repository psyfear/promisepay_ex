defmodule PromisepayEx.Model.Charge do
  @moduledoc """
  Charge object.

  ## Reference
  https://reference.promisepay.com/#charges
  """

  defstruct id: nil,
            account_id: nil,
            account_type: nil,
            amount: nil,
            buyer_country: nil,
            buyer_email: nil,
            buyer_fees: nil,
            buyer_name: nil,
            currency: nil,
            custom_data: nil,
            custom_descriptor: nil,
            dynamic_descriptor: nil,
            links: nil,
            name: nil,
            payment_method: nil,
            promisepay_fee: nil,
            seller_country: nil,
            seller_email: nil,
            seller_fees: nil,
            seller_name: nil,
            state: nil,
            status: nil,
            updated_at: nil

  @type t :: %__MODULE__{}
end
