defmodule ConfigureTest do
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

  test "configure using nils" do
    PromisepayEx.configure(
      username: nil,
      password: nil,
      environment: nil,
      api_domain: nil
    )

    assert_raise PromisepayEx.Error, fn ->
      PromisepayEx.items()
    end
  end

  test "gets current configuration" do
    config = PromisepayEx.configure

    assert Keyword.has_key?(config, :username)
    assert Keyword.has_key?(config, :password)
    assert Keyword.has_key?(config, :environment)
    assert Keyword.has_key?(config, :api_domain)
  end

  test "authenticated api request" do
    use_cassette "items_request" do
      items = PromisepayEx.items()
      assert length(items) == 10
      assert hd(items).name == "toyota hilux35"
    end
  end
end
