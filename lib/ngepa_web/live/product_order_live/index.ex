defmodule NgepaWeb.ProductOrderLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.ProductOrders
  alias Ngepa.ProductOrders.ProductOrder
  alias Ngepa.Products
  alias Ngepa.Notify

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
    products =
      Products.list_products()
      |> Enum.filter(fn product -> product.in_stock == true end)
      |> Enum.map(fn product -> {product.name, product.id} end)

    socket
    |> assign(:page_title, "Edit Product order")
    |> assign(:products, products)
    |> assign(:product_order, ProductOrders.get_product_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    products =
      Products.list_products()
      |> Enum.filter(fn product -> product.in_stock == true end)
      |> Enum.map(fn product -> {product.name, product.id} end)

    socket
    |> assign(:products, products)
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

  def handle_event("send_sms", params, socket) do
    product_order = ProductOrders.get_product_order!(params["id"])

    Notify.send_product_order_as_sms(
      product_order.customer_phone_number,
      product_order.customer_name,
      product_order.product.name,
      product_order.color,
      product_order.quantity,
      product_order.location,
      "https://mwambarugby.com/tickets/#{product_order.product_order_id}"
    )

    {:noreply,
     socket
     |> put_flash(:info, "SMS sent successfully")}
  end

  def handle_event("send_email", params, socket) do
    product_order = ProductOrders.get_product_order!(params["id"])

    Notify.send_product_order_as_email(
      product_order.customer_email,
      product_order.customer_name,
      product_order.product.name,
      product_order.color,
      product_order.quantity,
      product_order.location,
      "https://mwambarugby.com/tickets/#{product_order.product_order_id}"
    )

    {:noreply,
     socket
     |> put_flash(:info, "Email sent successfully")}
  end

  defp list_product_orders do
    ProductOrders.list_product_orders()
  end
end
