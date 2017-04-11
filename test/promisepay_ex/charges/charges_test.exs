defmodule GetChargesTest do
  use PromisepayEx.ApiCase

  test "charges returns List (200)" do
    use_cassette "charges/list/200" do
      charges = PromisepayEx.charges()

      assert is_list(charges)

      charge = hd(charges)

      assert charge.id
      assert charge.account_id
      assert charge.amount
    end
  end

  test "charges raises error (401)" do
    use_cassette "charges/list/401" do
      try do
        PromisepayEx.charges()
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end
end
