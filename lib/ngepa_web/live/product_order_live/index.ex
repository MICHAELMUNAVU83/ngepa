defmodule NgepaWeb.ProductOrderLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.ProductOrders
  alias Ngepa.ProductOrders.ProductOrder

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:changeset, ProductOrders.change_product_order(%ProductOrder{}))
     |> assign(:product_orders, list_product_orders())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product order")
    |> assign(:product_order, ProductOrders.get_product_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product order")
    |> assign(:product_order, %ProductOrder{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Product orders")
    |> assign(:product_order, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product_order = ProductOrders.get_product_order!(id)
    {:ok, _} = ProductOrders.delete_product_order(product_order)

    {:noreply, assign(socket, :product_orders, list_product_orders())}
  end

  def handle_event("search", params, socket) do
    {:noreply,
     socket
     |> assign(
       :product_orders,
       ProductOrders.list_product_orders_by_search(params["product_order"]["search"])
     )}
  end

  defp list_product_orders do
    ProductOrders.list_product_orders()
  end
end
