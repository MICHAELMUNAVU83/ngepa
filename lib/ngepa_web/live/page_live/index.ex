defmodule NgepaWeb.PageLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Products

  def mount(_params, _session, socket) do
    Todos.start_link()

    todos_list =
      if Todos.find(:shopping) == :error do
        Todos.new(:shopping)
        Todos.find(:shopping)
      else
        Todos.find(:shopping)
      end

    {:ok, cart} = todos_list

    products =
      Products.list_products()
      |> Enum.filter(fn product -> product.in_stock == true end)

    {:ok,
     socket
     |> assign(:products, products)
     |> assign(:page_title, "Listing Products")}
  end
end
