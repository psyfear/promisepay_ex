defmodule PromisepayEx.ConfigTest do
  use ExUnit.Case, async: true
  alias PromisepayEx.Config

  test "auth initialization global" do
    auth =
      [
        username: "username",
        password: "password",
        environment: "environment",
        api_domain: "api_domain",
      ]
    Config.set(auth)

    assert Config.current_scope == :global
    assert Config.get == auth
  end

  test "auth initialization (process)" do
    test = self()
    test_fun = fn(test_pid, config) ->
      spawn(fn() ->
        Config.set(:process, config)
        send(
          test_pid,
          {
            Config.current_scope,
            Config.get,
          }
        )
        exit(:normal)
      end)
    end
    test_fun.(test, [conf: :process1])
    test_fun.(test, [conf: :process2])

    assert_receive {:process, [conf: :process1]}
    assert_receive {:process, [conf: :process2]}
  end

  test "get_tuples returns list of tuples" do
    Config.set([conf: "value"])
    assert Config.get_tuples == [{:conf, "value"}]
  end

  test "get_tuples returns empty list when config is not set" do
    Config.set(nil)
    assert Config.get_tuples == []
  end
end
