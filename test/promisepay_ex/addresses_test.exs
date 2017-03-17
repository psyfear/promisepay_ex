defmodule AddressesTest do
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
      username: "test@promisepay.com",
      password: "test",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    :ok
  end

  test "address request" do
    use_cassette "address_request" do
      address = PromisepayEx.address("1fa89e62-0abe-432c-81f0-10e9f7f15f74")
      assert address.id == "1fa89e62-0abe-432c-81f0-10e9f7f15f74"
      assert address.addressline1 == "6880 Purdy Forges"
      assert address.country == "United States of America"
      assert address.city == "Norvalmouth"
    end
  end
end
