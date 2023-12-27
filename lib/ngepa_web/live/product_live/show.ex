defmodule NgepaWeb.ProductLive.Show do
  use NgepaWeb, :live_view

  alias Ngepa.Products
  alias Ngepa.Accounts
  alias Ngepa.Colors.Color
  alias Ngepa.Colors
  alias Ngepa.ProductImages
  alias Ngepa.ProductImages.ProductImage

  @impl true
  def mount(params, session, socket) do
    current_user = Accounts.get_user_by_session_token(session["user_token"])
    product = Products.get_product!(params["id"])

    slides = [
      product.primary_image
      | product.product_images |> Enum.map(fn product_image -> product_image.image_url end)
    ]

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

    {:ok,
     socket
     |> assign(:product, product)
     |> assign(:slides, slides)
     |> assign(:all_colors, all_colors)
     |> assign(:current_user, current_user)}
  end

  @impl true
  def handle_params(params, _, socket) do
    product = Products.get_product!(params["id"])

    colors =
      product.colors
      |> Enum.map(fn color ->
        %{
          id: color.id,
          name: color.name,
          color:
            "bg-" <>
              elem(
                Enum.find(socket.assigns.all_colors, fn {bg_color, _class} ->
                  bg_color == color.name
                end),
                1
              ) <> " h-[20px] w-[20px] rounded-full"
        }
      end)

    product_images = product.product_images

    color =
      case params["color_id"] do
        nil ->
          %Color{}

        color_id ->
          Colors.get_color!(color_id)
      end

    product_image =
      case params["product_image_id"] do
        nil ->
          %ProductImage{}

        product_image_id ->
          ProductImages.get_product_image!(product_image_id)
      end

    {:noreply,
     socket
     |> assign(:color, color)
     |> assign(:product_image, product_image)
     |> assign(:product_images, product_images)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, product)
     |> assign(:colors, colors)}
  end

  def handle_event("delete_color", %{"id" => id, "product-id" => product_id}, socket) do
    color = Colors.get_color!(id)
    {:ok, _} = Colors.delete_color(color)

    product = Products.get_product!(product_id)
    colors = product.colors

    {:noreply,
     socket
     |> assign(:colors, colors)}
  end

  def handle_event("delete_product_image", %{"id" => id, "product-id" => product_id}, socket) do
    product_image = ProductImages.get_product_image!(id)
    {:ok, _} = ProductImages.delete_product_image(product_image)

    product = Products.get_product!(product_id)
    product_images = product.product_images

    slides = [
      product.primary_image
      | product_images |> Enum.map(fn product_image -> product_image.image_url end)
    ]

    {:noreply,
     socket
     |> assign(:product_images, product_images)
     |> assign(:slides, slides)}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:add_color), do: "Add Color"
  defp page_title(:edit_color), do: "Edit Color"
  defp page_title(:add_product_image), do: "Add Product Image"
  defp page_title(:edit_product_image), do: "Edit Product Image"
  defp page_title(:edit), do: "Edit Product"
end
