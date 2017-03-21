defmodule GetCompaniesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExVCR.Config

  setup_all do
    Config.cassette_library_dir(
      "fixture/vcr_cassettes",
      "fixture/custom_cassettes"
    )

    Config.filter_url_params(true)
    Config.filter_request_headers("basic_auth")

    :ok
  end

  setup do
    PromisepayEx.configure(
      username: "test.test@test.com",
      password: "test",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    :ok
  end

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
