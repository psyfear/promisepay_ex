defmodule TransactionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExVCR.Config

  setup_all do
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
      username: "test@promisepay.com",
      password: "test",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    :ok
  end

  test "transactions request" do
    use_cassette "transactions_request" do
      transactions = PromisepayEx.transactions()
      assert length(transactions) == 10
      assert hd(transactions).id == "f56f85d1-c163-4afc-ab0c-630817c77418"
      assert hd(transactions).account_type == "wallet_account"
      assert hd(transactions).amount == 2425
    end
  end

  test "transaction request" do
    use_cassette "transaction_request" do
      transaction = PromisepayEx.transaction(
        "f56f85d1-c163-4afc-ab0c-630817c77418"
      )

      assert transaction.id == "f56f85d1-c163-4afc-ab0c-630817c77418"
      assert transaction.account_type == "wallet_account"
      assert transaction.amount == 2425
    end
  end

  test "transaction user request" do
    use_cassette "transaction_user_request" do
      user = PromisepayEx.transaction(
        "f56f85d1-c163-4afc-ab0c-630817c77418",
        :user
      )

      assert user.id == "2"
      assert user.email == "test.buyer@promisepay.com"
      assert user.first_name == "Bobby"
      assert user.last_name == "Buyer"
    end
  end

  test "transaction wallet_account request" do
    use_cassette "transaction_wallet_account_request" do
      wallet = PromisepayEx.transaction(
        "f56f85d1-c163-4afc-ab0c-630817c77418",
        :wallet_account
      )

      assert wallet.id == "1696e67c-c717-44bc-8e13-12ace7bda1c8"
      assert wallet.active == true
      assert wallet.balance == 2425
      assert wallet.currency == "AUD"
    end
  end
end
