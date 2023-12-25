defmodule NgepaWeb.TransactionController do
  use NgepaWeb, :controller

  alias Ngepa.Transactions
  alias Ngepa.Transactions.Transaction
  alias Ngepa.TransactionAlgorithim

  action_fallback NgepaWeb.FallbackController

  def index(conn, _params) do
    transactions = Transactions.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, transaction_params) do
    phone_number =
      TransactionAlgorithim.decode_phone_number_from_product_order(
        transaction_params["transaction_reference"]
      )

    product_id =
      TransactionAlgorithim.decode_product_id_from_product_order(
        transaction_params["transaction_reference"]
      )

    new_transaction_params = %{
      "message" => transaction_params["Message"],
      "success" => transaction_params["Success"],
      "status" => transaction_params["Status"],
      "amount" => transaction_params["Amount"],
      "transaction_code" => transaction_params["transaction_code"],
      "phone_number" => phone_number,
      "product_id" => product_id,
      "transaction_reference" => transaction_params["transaction_reference"]
    }

    IO.inspect(new_transaction_params)

    with {:ok, %Transaction{} = transaction} <-
           Transactions.create_transaction(new_transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <-
           Transactions.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transactions.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
