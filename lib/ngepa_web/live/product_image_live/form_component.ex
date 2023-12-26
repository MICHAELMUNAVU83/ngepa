defmodule NgepaWeb.ProductImageLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.ProductImages

  @impl true
  def update(%{product_image: product_image} = assigns, socket) do
    changeset = ProductImages.change_product_image(product_image)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product_image" => product_image_params}, socket) do
    changeset =
      socket.assigns.product_image
      |> ProductImages.change_product_image(product_image_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_image" => product_image_params}, socket) do
    save_product_image(socket, socket.assigns.action, product_image_params)
  end

  defp save_product_image(socket, :edit_product_image, product_image_params) do
    case ProductImages.update_product_image(socket.assigns.product_image, product_image_params) do
      {:ok, _product_image} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product image updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product_image(socket, :add_product_image, product_image_params) do
    case ProductImages.create_product_image(product_image_params) do
      {:ok, _product_image} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product image created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
