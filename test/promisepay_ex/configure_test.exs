defmodule ConfigureTest do
  use PromisepayEx.ApiCase

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
    use_cassette "items/list/200" do
      items = PromisepayEx.items()
      assert length(items) == 10
      assert hd(items).name == "toyota hilux35"
    end
  end
end
