defmodule PromisepayEx.Model.Company do
  @moduledoc """
  Company object.

  ## Reference
  https://reference.promisepay.com/#companies
  """

  defstruct id: nil,
            legal_name: nil,
            links: nil,
            name: nil,
            related: nil

  @type t :: %__MODULE__{}
end
