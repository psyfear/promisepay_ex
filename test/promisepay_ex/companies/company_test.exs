defmodule GetCompanyTest do
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

  test "company returns Map (200)" do
    use_cassette "companies/get/200" do
      company = PromisepayEx.company("7b85aa9c-fc54-4449-afef-f52fc2b94cd3")

      assert is_map(company)

      assert company.id
      assert company.legal_name
      assert company.related
    end
  end

  test "company raises error (401)" do
    use_cassette "companies/get/401" do
      try do
        PromisepayEx.company("7b85aa9c-fc54-4449-afef-f52fc2b94cd3")
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end

  test "company raises error (404)" do
    use_cassette "companies/get/404" do
      try do
        PromisepayEx.company("f4318485-6291-46de-a331-7e94da56efd5")
      rescue
        error in [PromisepayEx.Error] ->
          %{user_id: ["required field missing"]} = error.message
          assert error.code == 404
      end
    end
  end
end
