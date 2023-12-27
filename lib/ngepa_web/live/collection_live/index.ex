defmodule NgepaWeb.CollectionLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Products

  def mount(params, _session, socket) do
    products =
      Products.list_products()
      |> Enum.filter(fn product ->
        product.in_stock == true and product.collection == params["collection_name"]
      end)

    collection_images =
      [
        %{
          name: "unisex",
          image_url: "/images/unisex.jpg"
        },
        %{
          name: "men",
          image_url: "/images/men.jpg"
        },
        %{
          name: "women",
          image_url: "/images/woman.jpg"
        }
      ]

    image_to_display =
      Enum.filter(collection_images, fn image ->
        image.name == params["collection_name"]
      end)
      |> List.first()

    {:ok,
     socket
     |> assign(:products, products)
     |> assign(:image_to_display, image_to_display)
     |> assign(:collection_name, params["collection_name"])
     |> assign(:page_title, "Listing Collection Products")}
  end
end
