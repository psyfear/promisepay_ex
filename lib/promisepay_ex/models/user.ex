defmodule PromisepayEx.Model.User do
  @moduledoc """
  User object.

  ## Reference
  https://reference.assemblypayments.com/#show-user
  """

  defstruct color_1: nil,
            color_2: nil,
            created_at: nil,
            custom_descriptor: nil,
            dob: nil,
            id: nil,
            drivers_license: nil,
            email: nil,
            first_name: nil,
            flags: nil,
            full_name: nil,
            government_number: nil,
            held_state: nil,
            last_name: nil,
            links: nil,
            logo_url: nil,
            mobile: nil,
            phone: nil,
            related: nil,
            roles: nil,
            updated_at: nil,
            verification_state: nil

  @type t :: %__MODULE__{}
end
