defmodule NgepaWeb.ColorLive.FormComponent do
  use NgepaWeb, :live_component

  alias Ngepa.Colors

  @impl true
  def update(%{color: color} = assigns, socket) do
    changeset = Colors.change_color(color)

    all_colors = [
      {"black", "black"},
      {"white", "white"},
      {"light gray", "gray-200"},
      {"dark gray", "gray-400"},
      {"light red", "red-200"},
      {"dark red", "red-500"},
      {"light yellow", "yellow-200"},
      {"dark yellow", "yellow-500"},
      {"light green", "green-200"},
      {"dark green", "green-400"},
      {"light blue", "blue-200"},
      {"dark blue", "blue-500"},
      {"light purple", "purple-200"},
      {"dark purple", "purple-500"},
      {"light pink", "pink-200"},
      {"dark pink", "pink-500"},
      {"light indigo", "indigo-200"},
      {"dark indigo", "indigo-500"}
    ]

    product_colors =
      assigns.product.colors
      |> Enum.map(fn color -> color.name end)

    colors = all_colors |> Enum.map(fn {name, _} -> name end)

    colors_to_display =
      colors
      |> Enum.filter(fn color ->
        !Enum.member?(product_colors, color)
      end)

    IO.inspect(colors_to_display)

    {:ok,
     socket
     |> assign(:colors, colors_to_display)
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
