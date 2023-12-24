defmodule NgepaWeb.ShopLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Products
  alias Ngepa.ProductOrders
  alias Ngepa.ProductOrders.ProductOrder

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"product_name" => product_name}) do
    product = Products.get_product_by_name!(product_name)

    socket
    |> assign(:product, product)
    |> assign(:page_title, "#{product.name}")
  end

  defp apply_action(socket, :buy, %{"product_name" => product_name}) do
    product = Products.get_product_by_name!(product_name)

    socket
    |> assign(:product, product)
    |> assign(:product_order, %ProductOrder{})
    |> assign(:changeset, ProductOrders.change_product_order(%ProductOrder{}))
    |> assign(:page_title, "#{product.name}")
  end

  def handle_event("validate", %{"product_order" => product_order_params}, socket) do
    changeset =
      socket.assigns.product_order
      |> ProductOrders.change_product_order(product_order_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_order" => product_order_params}, socket) do
    {:noreply,
     socket
     |> put_flash(:info, "Product order created successfully")}
  end
end
