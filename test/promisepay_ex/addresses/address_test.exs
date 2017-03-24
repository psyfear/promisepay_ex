defmodule GetAddressTest do
  use PromisepayEx.ApiCase

  test "address returns Map (200)" do
    use_cassette "addresses/get/200" do
      address = PromisepayEx.address("1fa89e62-0abe-432c-81f0-10e9f7f15f74")

      assert is_map(address)

      assert address.id == "1fa89e62-0abe-432c-81f0-10e9f7f15f74"
      assert address.addressline1 == "6880 Purdy Forges"
      assert address.country == "United States of America"
      assert address.city == "Norvalmouth"
    end
  end
end
