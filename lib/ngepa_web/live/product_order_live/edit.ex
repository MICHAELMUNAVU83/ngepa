defmodule NgepaWeb.ProductOrderLive.Edit do
  use NgepaWeb, :live_component
  alias Ngepa.ProductOrders

  def render(assigns) do
    ~H"""
    <div>
      <div id="myModal" class="modal">
        <div class="modal-content pt-12 ">
          <.form
            let={f}
            for={@changeset}
            id="product_order-form"
            phx-target={@myself}
            phx-change="validate"
            phx-submit="save"
          >
            <div class="flex flex-col gap-2">
              <%= label(f, :status, class: "text-xl font-semibold") %>
              <%= select(
                f,
                :status,
                [
                  {"pending", "pending"},
                  {"packed", "packed"},
                  {"shipped", "shipped"},
                  {"delivered", "delivered"}
                ],
                prompt: "Select status",
                class:
                  "w-[100%] rounded-md  h-[40px] focus:outline-none focus:ring-2 focus:ring-[#000] focus:border-transparent"
              ) %>
              <p class="my-2">
                <%= error_tag(f, :status) %>
              </p>
            </div>

            <div class="flex justify-center items-center">
              <%= submit("Change Status",
                phx_disable_with: "Changing..",
                class: "bg-[#000] text-white p-2 rounded-md"
              ) %>
            </div>
          </.form>
        </div>
      </div>
    </div>
    """
  end

  def update(%{product_order: product_order} = assigns, socket) do
    changeset = ProductOrders.change_product_order(product_order)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product_order" => product_order_params}, socket) do
    changeset =
      socket.assigns.product_order
      |> ProductOrders.change_product_order(product_order_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_order" => product_order_params}, socket) do
    case ProductOrders.update_product_order(socket.assigns.product_order, product_order_params) do
      {:ok, _product_order} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product order updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
