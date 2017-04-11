defmodule CreateChargeTest do
  use PromisepayEx.ApiCase

  test "create_charge returns Map (201)" do
    use_cassette "charges/post/201" do
      options = %{
        account_id: "4901ef9f-3017-419c-88ae-641b232d25ec",
        amount: 100,
        email: "testemail@email.com",
        zip: "90210",
        country: "USA",
      }

      charge = PromisepayEx.create_charge(options)

      assert is_map(charge)

      assert charge.id
      assert charge.account_id
      assert charge.amount
    end
  end

  test "create_charge raises error (401)" do
    use_cassette "charges/post/401" do
      try do
        PromisepayEx.create_charge(%{})
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end

  test "create_charge raises error (422)" do
    use_cassette "charges/post/422" do
      try do
        PromisepayEx.create_charge(%{})
      rescue
        error in [PromisepayEx.Error] ->
          %{amount: ["required field missing"]} = error.message
          assert error.code == 422
      end
    end
  end
end
