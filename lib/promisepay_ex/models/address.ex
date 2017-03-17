defmodule PromisepayEx.Model.Address do
  @moduledoc """
  Address object.

  ## Reference
  https://reference.assemblypayments.com/#show-address
  """

  defstruct addressline1: nil,
            addressline2: nil,
            postcode: nil,
            city: nil,
            state: nil,
            id: nil,
            country: nil,
            links: nil

  @type t :: %__MODULE__{}
end
