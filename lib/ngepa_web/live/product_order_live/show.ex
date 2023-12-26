defmodule NgepaWeb.ProductOrderLive.Show do
  use NgepaWeb, :live_view

  alias Ngepa.ProductOrders
  alias Ngepa.Accounts
  alias Ngepa.ProductOrderMessages.ProductOrderMessage
  alias Ngepa.ProductOrderMessages
  alias Ngepa.Notify

  @impl true
  def mount(_params, session, socket) do
    user_signed_in =
      if is_nil(session["user_token"]) do
        false
      else
        true
      end

    current_user =
      if user_signed_in do
        Accounts.get_user_by_session_token(session["user_token"])
      else
        nil
      end

    {:ok,
     socket
     |> assign(:user_signed_in, user_signed_in)
     |> assign(:current_user, current_user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    product_order = ProductOrders.get_product_order_by_product_id!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
       :product_order_messages,
       ProductOrderMessages.list_product_order_messages()
       |> Enum.filter(fn product_order_message ->
         product_order_message.product_order_id == product_order.id
       end)
     )
     |> assign(:product_order_message, %ProductOrderMessage{})
     |> assign(:product_order, ProductOrders.get_product_order_by_product_id!(id))}
  end

  def handle_event("send_sms", params, socket) do
    product_order_message = ProductOrderMessages.get_product_order_message!(params["id"])
    product_order = ProductOrders.get_product_order!(product_order_message.product_order_id)

    Notify.send_order_message_as_sms(
      product_order.customer_phone_number,
      product_order_message.message,
      product_order.customer_name,
      "order_link"
    )

    {:ok, _product_order_message} =
      ProductOrderMessages.update_product_order_message(
        product_order_message,
        %{
          sms_status: true
        }
      )

    product_order = ProductOrders.get_product_order!(product_order_message.product_order_id)

    {:noreply,
     socket
     |> assign(
       :product_order,
       product_order
     )
     |> assign(
       :product_order_messages,
       ProductOrderMessages.list_product_order_messages()
       |> Enum.filter(fn product_order_message ->
         product_order_message.product_order_id == product_order.id
       end)
     )
     |> put_flash(:info, "SMS sent successfully")}
  end

  def handle_event("send_email", params, socket) do
    product_order_message = ProductOrderMessages.get_product_order_message!(params["id"])
    product_order = ProductOrders.get_product_order!(product_order_message.product_order_id)

    Notify.send_order_message_as_email(
      product_order.customer_email,
      product_order_message.message,
      product_order.customer_name,
      "order_link"
    )

    {:ok, _product_order_message} =
      ProductOrderMessages.update_product_order_message(
        product_order_message,
        %{
          email_status: true
        }
      )

    {:noreply,
     socket
     |> assign(
       :product_order,
       ProductOrders.get_product_order!(product_order_message.product_order_id)
     )
     |> assign(
       :product_order_messages,
       ProductOrderMessages.list_product_order_messages()
       |> Enum.filter(fn product_order_message ->
         product_order_message.product_order_id == product_order.id
       end)
     )
     |> put_flash(:info, "Email sent successfully")}
  end

  defp page_title(:show), do: "Show Product order"
  defp page_title(:edit_on_show), do: "Edit Product order"
  defp page_title(:new_message), do: "Send message"
end
