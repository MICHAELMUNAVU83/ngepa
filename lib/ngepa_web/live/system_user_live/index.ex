defmodule NgepaWeb.SystemUserLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Transactions
  alias Ngepa.Transactions.Transaction
  alias Ngepa.Accounts

  @impl true
  def mount(_params, session, socket) do
    users = Accounts.list_users()

    {:ok,
     socket
     |> assign(:users, users)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing System Users")
  end
end
