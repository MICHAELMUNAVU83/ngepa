defmodule NgepaWeb.ProductOrderMessageLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.ProductOrderMessages

  @impl true
  def update(%{product_order_message: product_order_message} = assigns, socket) do
    changeset = ProductOrderMessages.change_product_order_message(product_order_message)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product_order_message" => product_order_message_params}, socket) do
    changeset =
      socket.assigns.product_order_message
      |> ProductOrderMessages.change_product_order_message(product_order_message_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_order_message" => product_order_message_params}, socket) do
    save_product_order_message(socket, socket.assigns.action, product_order_message_params)
  end

  defp save_product_order_message(socket, :new_message, product_order_message_params) do
    case ProductOrderMessages.create_product_order_message(product_order_message_params) do
      {:ok, _product_order_message} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product order message created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
