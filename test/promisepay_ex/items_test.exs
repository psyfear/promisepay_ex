defmodule ItemsTest do
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

  test "items request" do
    use_cassette "items_request" do
      items = PromisepayEx.items()
      assert length(items) == 10
      assert hd(items).name == "toyota hilux35"
    end
  end

  test "item request" do
    use_cassette "item_request" do
      item = PromisepayEx.item("6bf802c5e641aeaf28ac4397eb5f42a5")
      assert item.name == "Awesome Websites Domain"
      assert item.id == "6bf802c5e641aeaf28ac4397eb5f42a5"
    end
  end
end
