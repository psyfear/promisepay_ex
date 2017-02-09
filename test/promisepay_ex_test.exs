defmodule PromisepayExTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest PromisepayEx

  setup_all do
    ExVCR.Config.cassette_library_dir(
      "fixture/vcr_cassettes", 
      "fixture/custom_cassettes"
    )

    ExVCR.Config.filter_url_params(true)
    ExVCR.Config.filter_request_headers("Authorization")

    PromisepayEx.configure(
      username: "test@promisepay.com",
      token: "TOKEN",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    :ok
  end

  setup do
    PromisepayEx.configure(
      username: "test@promisepay.com",
      token: "TOKEN",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    :ok
  end

  test "no configuration" do
    PromisepayEx.configure(username: nil, token: nil, environment: nil, api_domain: nil)

    assert_raise PromisepayEx.Error, fn ->
      PromisepayEx.items
    end
  end

  test "gets current configuration" do
    config = PromisepayEx.configure
    assert Keyword.has_key?(config, :username)
    assert Keyword.has_key?(config, :token)
    assert Keyword.has_key?(config, :environment)
    assert Keyword.has_key?(config, :api_domain)
  end

  test "authenticated items request" do
    use_cassette "items_request" do
      items = PromisepayEx.items
      assert length(items) == 10
      assert hd(items).name == "Charge 83bfa2cb-78a4-445f-92b2-eea446bfa561"
    end
  end

  test "authenticated item request" do
    use_cassette "item_request" do
      item = PromisepayEx.item("chocoitem1")
      assert item.name == "Sample item for CC payment"
      assert item.id == "chocoitem1"
    end
  end
end
