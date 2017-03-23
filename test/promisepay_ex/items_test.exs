defmodule ItemsTest do
  use PromisepayEx.ApiCase

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
