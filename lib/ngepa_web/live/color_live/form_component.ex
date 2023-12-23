defmodule NgepaWeb.ColorLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.Colors

  @impl true
  def update(%{color: color} = assigns, socket) do
    changeset = Colors.change_color(color)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"color" => color_params}, socket) do
    changeset =
      socket.assigns.color
      |> Colors.change_color(color_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"color" => color_params}, socket) do
    save_color(socket, socket.assigns.action, color_params)
  end

  defp save_color(socket, :edit_color, color_params) do
    case Colors.update_color(socket.assigns.color, color_params) do
      {:ok, _color} ->
        {:noreply,
         socket
         |> put_flash(:info, "Color updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_color(socket, :add_color, color_params) do
    case Colors.create_color(color_params) do
      {:ok, _color} ->
        {:noreply,
         socket
         |> put_flash(:info, "Color created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
