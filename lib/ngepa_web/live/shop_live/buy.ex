defmodule NgepaWeb.ShopLive.Buy do
  use NgepaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content ralewa-regular pt-12 ">
          <div>
            <h2 class="text-3xl font-bold my-4"><%= @title %> ~ <%= @product.price %> KES /=</h2>
            <p class="poppins-regular">
              Fill in the form to pay with Mpesa
            </p>

            <.form
              let={f}
              for={@changeset}
              id="product_order-form"
              phx-change="validate"
              phx-submit="save"
            >
              <div class="flex flex-col gap-2">
                <%= hidden_input(f, :latitude, id: "delivery_latitude_product_order") %>
                <%= hidden_input(f, :longitude, id: "delivery_longitude_product_order") %>
                <%= hidden_input(f, :product_id, value: @product.id) %>

                <div class="w-[100%] flex md:flex-row flex-col gap-2 justify-between">
                  <div class="flex flex-col gap-2  w-[100%] md:w-[48%]">
                    <%= label(f, :full_name, class: "text-xl font-semibold") %>
                    <%= text_input(f, :customer_name,
                      class:
                        "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent",
                      placeholder: "Enter your full name"
                    ) %>
                    <p class="my-2">
                      <%= error_tag(f, :customer_name) %>
                    </p>
                  </div>
                  <div class="flex flex-col gap-2 w-[100%] md:w-[48%]">
                    <%= label(f, :email, class: "text-xl font-semibold") %>
                    <%= text_input(f, :customer_email,
                      class:
                        "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent",
                      placeholder: "Enter your email"
                    ) %>
                    <p class="my-2">
                      <%= error_tag(f, :customer_email) %>
                    </p>
                  </div>
                </div>

                <div class="flex flex-col gap-2 w-[100%]">
                  <div class="flex flex-col gap-2  w-[100%] ">
                    <%= label(f, :customer_phone_number, class: "text-xl font-semibold") %>
                    <%= text_input(f, :customer_phone_number,
                      placeholder: "Enter your mpesa phone number",
                      class:
                        "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent"
                    ) %>
                    <p class="text-red-500 text-xs">
                      Ensure the number is of the format 2547XXXXXXXX
                    </p>
                    <p class="my-2">
                      <%= error_tag(f, :customer_phone_number) %>
                    </p>
                  </div>
                </div>
                <div class="w-[100%] flex md:flex-row flex-col gap-2 justify-between">
                  <div class="flex flex-col gap-2  w-[100%] md:w-[48%]">
                    <%= label(f, :color, class: "text-xl font-semibold") %>
                    <%= select(f, :color, @colors,
                      prompt: "Select color",
                      class:
                        "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent"
                    ) %>
                    <p class="my-2">
                      <%= error_tag(f, :customer_name) %>
                    </p>
                  </div>
                  <div class="flex flex-col gap-2 md:w-[48%]  w-[100%]">
                    <%= label(f, :quantity, class: "text-xl font-semibold") %>
                    <%= select(f, :quantity, [1, 2, 3, 4, 5, 6, 7],
                      prompt: "Select quantity",
                      class:
                        "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent"
                    ) %>
                    <p class="my-2">
                      <%= error_tag(f, :quantity) %>
                    </p>
                  </div>
                </div>
                <div id="ProductLocation" phx-hook="ProductLocation" class="flex flex-col gap-2">
                  <%= label(f, :location, class: "text-xl font-semibold") %>
                  <%= text_input(f, :location,
                    placeholder: "Enter your location",
                    id: "product_order_location",
                    class:
                      "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent"
                  ) %>
                  <p class="my-2">
                    <%= error_tag(f, :location) %>
                  </p>
                </div>

                <div class="flex flex-col gap-2">
                  <%= label(f, :more_location_details, class: "text-xl font-semibold") %>
                  <%= textarea(f, :more_location_details,
                    placeholder: "add more details on your pickup location",
                    class:
                      "w-[100%] rounded-md  h-[80px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent"
                  ) %>
                </div>

                <%= if @total_price != "" do %>
                  The total price for <%= @quantity %> products would be <%= @total_price %> KES /=
                <% end %>

                <div class="flex justify-center items-center">
                  <%= submit("Buy Product",
                    phx_disable_with: "Processing Payment..",
                    class: "bg-[#000] text-white p-2 rounded-md"
                  ) %>
                </div>
              </div>
            </.form>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
