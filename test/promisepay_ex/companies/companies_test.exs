defmodule GetCompaniesTest do
  use PromisepayEx.ApiCase

  test "companies returns List (200)" do
    use_cassette "companies/list/200" do
      companies = PromisepayEx.companies()

      assert is_list(companies)

      company = hd(companies)

      assert company.id
      assert company.legal_name
      assert company.related
    end
  end

  test "companies raises error (401)" do
    use_cassette "companies/list/401" do
      try do
        PromisepayEx.companies()
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end
end
