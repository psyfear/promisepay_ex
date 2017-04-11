require IEx

defmodule GetChargeTest do
  use PromisepayEx.ApiCase

  test "charge returns Map (200)" do
    use_cassette "charges/get/200" do
      charge = PromisepayEx.charge("f4a701cf-2950-4423-a6bf-604bcf846466")

      assert is_map(charge)

      assert charge.id
      assert charge.account_id
      assert charge.amount
    end
  end

  test "charge raises error (401)" do
    use_cassette "charges/get/401" do
      try do
        PromisepayEx.charge("7b85aa9c-fc54-4449-afef-f52fc2b94cd3")
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end

  test "charge raises error (404)" do
    use_cassette "charges/get/404" do
      try do
        PromisepayEx.charge("f4318485-6291-46de-a331-7e94da56efd5")
      rescue
        error in [PromisepayEx.Error] ->
          assert error.code == 422
      end
    end
  end
end
