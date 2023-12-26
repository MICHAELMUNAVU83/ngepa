defmodule NgepaWeb.TransactionLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Transactions
  alias Ngepa.Transactions.Transaction

  @impl true
  def mount(_params, session, socket) do
    transactions = Transactions.list_transactions()

    IO.inspect(transactions)

    changeset =
      Transactions.change_transaction(%Transaction{})

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:transactions, transactions)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Transactions")
  end

  def handle_event("search", %{"transaction" => %{"search" => search}}, socket) do
    transactions =
      Transactions.list_transactions_by_search(search)

    {:noreply,
     socket
     |> assign(:transactions, transactions)}
  end
end
