defmodule NgepaWeb.ShopLive.Success do
  use NgepaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content pt-12 ">
          <div class="flex w-[100%] flex-col gap-1">
            <p class="text-green-500 poppins-bold ">
              Payment Successful
            </p>
            <p class="bg-green-500 h-[2px] w-[100%] " />
          </div>
          <div class="flex justify-center text-[200px] items-center">
            <i class="fa fa-check text-green-500" aria-hidden="true"></i>
          </div>

          <p class="raleway-bold text-xl text-center">
            Thank you for your order , you have received an SMS and Email with a link to track your order status
          </p>
          <div class="flex justify-center mt-4">
            <%= live_redirect to: Routes.product_order_show_path(@socket , :show , @product_order_id ) do %>
              <button class="bg-green-500 p-2 rounded-md hover:scale-105 transition-all ease-in-out duration-500 text-white">
                View Your Product Order
              </button>
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
