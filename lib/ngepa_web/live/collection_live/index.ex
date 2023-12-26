defmodule NgepaWeb.CollectionLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Products

  def mount(params, _session, socket) do
    products =
      Products.list_products()
      |> Enum.filter(fn product ->
        product.in_stock == true and product.collection == params["collection_name"]
      end)

    {:ok,
     socket
     |> assign(:products, products)
     |> assign(:collection_name, params["collection_name"])
     |> assign(:page_title, "Listing Collection Products")}
  end
end
