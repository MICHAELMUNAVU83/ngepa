defmodule NgepaWeb.ShopLive.Failed do
  use NgepaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content pt-12 ">
          <div class="flex w-[100%] flex-col gap-1">
            <p class="text-red-500 poppins-bold ">
              Payment Unsuccessful
            </p>
            <p class="bg-red-500 h-[2px] w-[100%] " />
          </div>

          <div class="flex justify-center text-[200px] items-center">
            <i class="fa fa-times " style="color: #F87171;" aria-hidden="true"></i>
          </div>

          <p class="text-center raleway-bold text-xl text-red-500">
            Your payment was unsuccessful. Please try again.
          </p>
        </div>
      </div>
    </div>
    """
  end
end
