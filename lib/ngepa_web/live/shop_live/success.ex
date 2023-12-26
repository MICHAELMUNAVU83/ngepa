defmodule NgepaWeb.ShopLive.Success do
  use NgepaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content pt-12 ">
          Success
          <%= live_redirect to: Routes.product_order_show_path(@socket , :show , @product_order_id ) do %>
            <button class="bg-black text-white">
              View Your Product Order
            </button>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
