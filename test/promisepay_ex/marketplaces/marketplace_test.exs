defmodule GetMarketplaceTest do
  use PromisepayEx.ApiCase

  test "marketplace returns Map (200)" do
    use_cassette "marketplaces/get/200" do
      marketplace_id = "7871c10a-a457-4cc6-91f5-a49c147d7c9f"
      marketplace = PromisepayEx.marketplace(marketplace_id)

      assert is_map(marketplace)

      assert marketplace.name == "Awesome Websites"
      assert marketplace.short_name == "awesome"
    end
  end
end
