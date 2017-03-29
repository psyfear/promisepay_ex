defmodule GetFeesTest do
  use PromisepayEx.ApiCase

  test "fees returns List (200)" do
    use_cassette "fees/list/200" do
      fees = PromisepayEx.fees()

      assert is_list(fees)

      fee = hd(fees)

      assert fee.id
      assert fee.amount
      assert fee.created_at
    end
  end

  test "fees raises error (401)" do
    use_cassette "fees/list/401" do
      try do
        PromisepayEx.fees()
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end
end
