defmodule NgepaWeb.ShopLive.Failed do
  use NgepaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content pt-12 ">
          failed error
        </div>
      </div>
    </div>
    """
  end
end
