defmodule NgepaWeb.PageLive.Index do
  use NgepaWeb, :live_view

  def mount(_params, _session, socket) do
    todos_list =
      if Todos.find(:shopping) == :error do
        Todos.new(:shopping)
        Todos.find(:shopping)
      else
        Todos.find(:shopping)
      end

    {:ok, cart} = todos_list

    IO.inspect(cart)

    {:ok,
     socket
     |> assign(:page_title, "Listing Products")}
  end
end
