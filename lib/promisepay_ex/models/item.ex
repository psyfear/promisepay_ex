defmodule PromisepayEx.Model.Item do
  @moduledoc """
  Item object.

  ## Reference
  https://reference.promisepay.com/#items
  """

  defstruct amount: nil,
            buyer_country: nil,
            buyer_email: nil,
            buyer_fees: nil,
            buyer_name: nil,
            buyer_url: nil,
            chargedback_amount: nil,
            created_at: nil,
            credit_card_fee: nil,
            currency: nil,
            custom_descriptor: nil,
            deposit_reference: nil,
            description: nil,
            direct_debit_fee: nil,
            due_date: nil,
            dynamic_descriptor: nil,
            id: nil,
            links: nil,
            name: nil,
            net_amount: nil,
            payment_credit_card_enabled: nil,
            payment_direct_debit_enabled: nil,
            payment_method: nil,
            payment_type_id: nil,
            paypal_fee: nil,
            pending_release_amount: nil,
            promisepay_fee: nil,
            refunded_amount: nil,
            related: nil,
            released_amount: nil,
            remaining_amount: nil,
            requested_release_amount: nil,
            seller_country: nil,
            seller_email: nil,
            seller_fees: nil,
            seller_name: nil,
            seller_url: nil,
            state: nil,
            status: nil,
            total_amount: nil,
            total_outstanding: nil,
            updated_at: nil

  @type t :: %__MODULE__{}
end
