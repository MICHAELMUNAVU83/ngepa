defmodule NgepaWeb.ProductLive.Show do
  use NgepaWeb, :live_view

  alias Ngepa.Products
  alias Ngepa.Accounts
  alias Ngepa.Colors.Color
  alias Ngepa.Colors

  @impl true
  def mount(_params, session, socket) do
    current_user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:current_user, current_user)}
  end

  @impl true
  def handle_params(params, _, socket) do
    product = Products.get_product!(params["id"])

    colors = product.colors

    color =
      case params["color_id"] do
        nil ->
          %Color{}

        color_id ->
          Colors.get_color!(color_id)
      end

    {:noreply,
     socket
     |> assign(:color, color)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, product)
     |> assign(:colors, colors)}
  end

  def handle_event("delete", %{"id" => id, "product-id" => product_id}, socket) do
    color = Colors.get_color!(id)
    {:ok, _} = Colors.delete_color(color)

    product = Products.get_product!(product_id)
    colors = product.colors

    {:noreply,
     socket
     |> assign(:colors, colors)}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:add_color), do: "Add Color"
  defp page_title(:edit_color), do: "Edit Color"
  defp page_title(:edit), do: "Edit Product"
end
