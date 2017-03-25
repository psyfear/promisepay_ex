defmodule TransactionsTest do
  use PromisepayEx.ApiCase

  test "transactions returns List (200)" do
    use_cassette "transactions/transactions" do
      transactions = PromisepayEx.transactions()

      assert length(transactions) == 10

      transaction = hd(transactions)

      assert transaction.id == "f56f85d1-c163-4afc-ab0c-630817c77418"
      assert transaction.account_type == "wallet_account"
      assert transaction.amount == 2425
    end
  end

  test "transaction returns Map (200)" do
    use_cassette "transactions/transaction" do
      transaction = PromisepayEx.transaction(
        "f56f85d1-c163-4afc-ab0c-630817c77418"
      )

      assert is_map(transaction)

      assert transaction.id == "f56f85d1-c163-4afc-ab0c-630817c77418"
      assert transaction.account_type == "wallet_account"
      assert transaction.amount == 2425
    end
  end

  test "transaction user returns Map (200)" do
    use_cassette "transactions/transaction_user" do
      user = PromisepayEx.transaction(
        "f56f85d1-c163-4afc-ab0c-630817c77418",
        :user
      )

      assert is_map(user)

      assert user.id == "2"
      assert user.email == "test.buyer@promisepay.com"
      assert user.first_name == "Bobby"
      assert user.last_name == "Buyer"
    end
  end

  test "transaction wallet_account returns Map (200)" do
    use_cassette "transactions/transaction_wallet_account" do
      wallet = PromisepayEx.transaction(
        "f56f85d1-c163-4afc-ab0c-630817c77418",
        :wallet_account
      )

      assert is_map(wallet)

      assert wallet.id == "1696e67c-c717-44bc-8e13-12ace7bda1c8"
      assert wallet.active == true
      assert wallet.balance == 2425
      assert wallet.currency == "AUD"
    end
  end
end
