defmodule UpdateCompanyTest do
  use PromisepayEx.ApiCase

  test "update_company returns Map (200)" do
    use_cassette "companies/patch/200" do
      options = %{
        id: "3815ea32-3b6d-4f48-b7a9-92d3f21d2367",
        name: "Samuel's Gardening",
        legal_name: "Samuel's Gardening Pty Ltd",
        user_id: "064d6800-fff3-11e5-86aa-5e5517507c66",
        tax_number: "100200300",
        charge_tax: false,
        address_line1: "500 Garden St",
        address_line2: "",
        city: "Sydney",
        state: "NSW",
        zip: "2000",
        country: "AUS",
        phone: "+61491570156"
      }

      company = PromisepayEx.update_company(options)

      assert is_map(company)

      assert company.id
      assert company.legal_name
      assert company.related
    end
  end

  test "update_company raises error (401)" do
    use_cassette "companies/patch/401" do
      try do
        options = %{id: "7b85aa9c-fc54-4449-afef-f52fc2b94cd3"}
        PromisepayEx.update_company(options)
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end

  test "update_company raises error (422)" do
    use_cassette "companies/patch/422" do
      try do
        options = %{id: "7b85aa9c-fc54-4449-afef-f52fc2b94cd3"}
        PromisepayEx.update_company(options)
      rescue
        error in [PromisepayEx.Error] ->
          %{user_id: ["required field missing"]} = error.message
          assert error.code == 422
      end
    end
  end
end
