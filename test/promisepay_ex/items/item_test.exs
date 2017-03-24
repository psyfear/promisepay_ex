defmodule GetItemTest do
  use PromisepayEx.ApiCase

  test "item returns Map (200)" do
    use_cassette "items/get/200" do
      item = PromisepayEx.item("6bf802c5e641aeaf28ac4397eb5f42a5")

      assert is_map(item)

      assert item.name == "Awesome Websites Domain"
      assert item.id == "6bf802c5e641aeaf28ac4397eb5f42a5"
    end
  end
end
