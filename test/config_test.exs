defmodule PromisepayEx.ConfigTest do
  use ExUnit.Case

  test "auth initialization global" do
    auth =
      [ username: "username",
        token: "token",
        environment: "environment",
        api_domain: "api_domain" ]
    PromisepayEx.Config.set(auth)

    assert PromisepayEx.Config.current_scope == :global
    assert PromisepayEx.Config.get == auth
  end

  test "auth initialization (process)" do
    test = self()
    test_fun = fn(test_pid, config) ->
      spawn(fn() ->
        PromisepayEx.Config.set(:process, config)
        send(test_pid, {PromisepayEx.Config.current_scope, PromisepayEx.Config.get})
        exit(:normal)
      end)
    end
    test_fun.(test, [conf: :process1])
    test_fun.(test, [conf: :process2])

    assert_receive {:process, [conf: :process1]}
    assert_receive {:process, [conf: :process2]}
  end

  test "get_tuples returns list of tuples" do
    PromisepayEx.Config.set([conf: "value"])
    assert PromisepayEx.Config.get_tuples == [{:conf, "value"}]
  end

  test "get_tuples returns empty list when config is not set" do
    PromisepayEx.Config.set(nil)
    assert PromisepayEx.Config.get_tuples == []
  end
end
