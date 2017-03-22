defmodule GenerateTokenTest do
  use PromisepayEx.ApiCase

  test "generate_token returns Map" do
    use_cassette "token_auths_request" do
      options = %{
        token_type: "card",
        user_id: "064d6800-fff3-11e5-86aa-5e5517507c66"
      }

      token = PromisepayEx.generate_token(options)

      assert is_map(token)
      assert token.token == "45393cd06fedd253405eccaa4bd8f10d"
      assert token.user_id == "457dd2d8a401fa19693b0c04f0128eb0"
    end
  end

  test "generate_token raises error when unauthorized" do
    use_cassette "unauthorized_token_auths_request" do
      options = %{
        token_type: "card",
        user_id: "064d6800-fff3-11e5-86aa-5e5517507c66"
      }

      try do
        PromisepayEx.generate_token(options)
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
      end
    end
  end
end
