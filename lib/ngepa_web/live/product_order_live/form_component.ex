defmodule NgepaWeb.ProductOrderLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.ProductOrders

  @impl true
  def update(%{product_order: product_order} = assigns, socket) do
    changeset = ProductOrders.change_product_order(product_order)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product_order" => product_order_params}, socket) do
    changeset =
      socket.assigns.product_order
      |> ProductOrders.change_product_order(product_order_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_order" => product_order_params}, socket) do
    save_product_order(socket, socket.assigns.action, product_order_params)
  end

  defp save_product_order(socket, :edit, product_order_params) do
    case ProductOrders.update_product_order(socket.assigns.product_order, product_order_params) do
      {:ok, _product_order} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product order updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product_order(socket, :new, product_order_params) do
    case ProductOrders.create_product_order(product_order_params) do
      {:ok, _product_order} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product order created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
