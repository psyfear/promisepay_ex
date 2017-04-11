defmodule PromisepayEx.Model.Fee do
  @moduledoc """
  Fee object.

  ## Reference
  https://reference.promisepay.com/#fees
  """
  defstruct amount: nil,
           cap: nil,
           created_at: nil,
           fee_type_id: nil,
           id: nil,
           links: nil,
           max: nil,
           min: nil,
           name: nil,
           to: nil,
           updated_a: nil

   @type t :: %__MODULE__{}
end
