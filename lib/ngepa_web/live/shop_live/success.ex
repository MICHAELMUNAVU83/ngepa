defmodule NgepaWeb.ShopLive.Success do
  use NgepaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content pt-12 ">
          Success
        </div>
      </div>
    </div>
    """
  end
end
