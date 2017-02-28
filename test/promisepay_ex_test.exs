defmodule PromisepayExTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest PromisepayEx

  alias ExVCR.Config

  setup_all do
    Config.cassette_library_dir(
      "fixture/vcr_cassettes",
      "fixture/custom_cassettes"
    )

    Config.filter_url_params(true)
    Config.filter_request_headers("basic_auth")
    
    PromisepayEx.configure(
      username: "test@promisepay.com",
      password: "test",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

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

  test "no configuration" do
    PromisepayEx.configure(
      username: nil,
      password: nil,
      environment: nil,
      api_domain: nil
    )

    assert_raise PromisepayEx.Error, fn ->
      PromisepayEx.items
    end
  end

  test "gets current configuration" do
    config = PromisepayEx.configure
    assert Keyword.has_key?(config, :username)
    assert Keyword.has_key?(config, :password)
    assert Keyword.has_key?(config, :environment)
    assert Keyword.has_key?(config, :api_domain)
  end

  test "authenticated items request" do
    use_cassette "items_request" do
      items = PromisepayEx.items
      assert length(items) == 10
      assert hd(items).name == "toyota hilux35"
    end
  end

  test "authenticated item request" do
    use_cassette "item_request" do
      item = PromisepayEx.item("6bf802c5e641aeaf28ac4397eb5f42a5")
      assert item.name == "Awesome Websites Domain"
      assert item.id == "6bf802c5e641aeaf28ac4397eb5f42a5"
    end
  end
end
