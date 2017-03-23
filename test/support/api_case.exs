defmodule PromisepayEx.ApiCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require authentication.

  Such tests rely on `ExUnit.Case` and ExVCR.Mock.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
    end
  end

  setup_all do
    alias ExVCR.Config

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
      username: "test.test@example.com",
      password: "test",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    :ok
  end
end
