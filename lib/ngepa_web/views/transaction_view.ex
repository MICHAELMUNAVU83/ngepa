defmodule NgepaWeb.TransactionView do
  use NgepaWeb, :view
  alias NgepaWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      message: transaction.message,
      amount: transaction.amount,
      status: transaction.status,
      success: transaction.success,
      transaction_code: transaction.transaction_code,
      transaction_reference: transaction.transaction_reference,
      product_id: transaction.product_id
    }
  end
end
