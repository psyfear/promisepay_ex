defmodule PromisepayEx.Model.Marketplace do
  @moduledoc """
  Marketplace object.

  ## Reference
  https://reference.promisepay.com/#marketplaces
  """

  defstruct id: nil,
            name: nil,
            short_name: nil,
            color_1: nil,
            color_2: nil,
            color_3: nil,
            color_4: nil,
            color_5: nil,
            website: nil,
            payment_frequency: nil,
            alt_marketplace_id: nil,
            state: nil,
            logo: nil,
            active: nil,
            alt_marketplace_auth: nil,
            business_information: nil,
            marketplace_addons: nil,
            currency: nil,
            email: nil,
            seller_white_labeled: nil,
            partial_refunds: nil,
            related: nil,
            links: nil

  @type t :: %__MODULE__{}
end
