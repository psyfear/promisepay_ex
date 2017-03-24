defmodule GetItemsTest do
  use PromisepayEx.ApiCase

  test "items returns List (200)" do
    use_cassette "items/list/200" do
      items = PromisepayEx.items()

      assert is_list(items)

      assert length(items) == 10

      assert hd(items).name == "toyota hilux35"
    end
  end
end
