defmodule NgepaWeb.ProductOrderLive.Show do
  use NgepaWeb, :live_view

  alias Ngepa.ProductOrders

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product_order, ProductOrders.get_product_order_by_product_id!(id))}
  end

  defp page_title(:show), do: "Show Product order"
  defp page_title(:edit), do: "Edit Product order"
end
