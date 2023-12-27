defmodule NgepaWeb.PageLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Products

  def mount(_params, _session, socket) do
    products =
      Products.list_products()
      |> Enum.filter(fn product -> product.in_stock == true end)

    {:ok,
     socket
     |> assign(:products, products)
     |> assign(:page_title, "Headwear Solutions")}
  end
end
