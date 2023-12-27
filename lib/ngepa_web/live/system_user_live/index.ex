defmodule NgepaWeb.SystemUserLive.Index do
  use NgepaWeb, :admin_live_view

  alias Ngepa.Transactions
  alias Ngepa.Transactions.Transaction
  alias Ngepa.Accounts

  @impl true
  def mount(_params, session, socket) do
    current_user = Accounts.get_user_by_session_token(session["user_token"])

    users =
      Accounts.list_users()
      |> Enum.filter(fn user -> user.id != current_user.id end)

    {:ok,
     socket
     |> assign(:current_user, current_user)
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

  def handle_event("make_admin", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.update_user(user, %{role: "admin"})

    {:noreply,
     socket
     |> assign(
       :users,
       Accounts.list_users()
       |> Enum.filter(fn user -> user.id != socket.assigns.current_user.id end)
     )
     |> put_flash(:info, "User promoted to admin")}
  end

  def handle_event("make_user", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.update_user(user, %{role: "user"})

    {:noreply,
     socket
     |> assign(
       :users,
       Accounts.list_users()
       |> Enum.filter(fn user -> user.id != socket.assigns.current_user.id end)
     )
     |> put_flash(:info, "User made a normal user")}
  end

  def handle_event("make_delivery_agent", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.update_user(user, %{role: "delivery_agent"})

    {:noreply,
     socket
     |> assign(
       :users,
       Accounts.list_users()
       |> Enum.filter(fn user -> user.id != socket.assigns.current_user.id end)
     )
     |> put_flash(:info, "User given delivery fulfilment rights")}
  end

  def handle_event("delete_user", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    {:noreply,
     socket
     |> assign(
       :users,
       Accounts.list_users()
       |> Enum.filter(fn user -> user.id != socket.assigns.current_user.id end)
     )
     |> put_flash(:info, "User deleted")}
  end
end
