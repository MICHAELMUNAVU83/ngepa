defmodule NgepaWeb.ShopLive.Index do
  use NgepaWeb, :live_view

  alias Ngepa.Products
  alias Ngepa.ProductOrders
  alias Ngepa.ProductOrders.ProductOrder
  alias Ngepa.TransactionAlgorithim
  alias Ngepa.Chpter
  alias Ngepa.Notify
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("hey", _, socket) do
    transaction_reference =
      TransactionAlgorithim.code_reference_for_product_order(
        "1",
        "254740769596"
      )

    # case Chpter.initiate_payment(
    #        "pk_0b51e48bc6ac135ce3f65b1355248cae71ef085c0223bc0273535a4e174dce07",
    #        "254740769596",
    #        "John Doe",
    #        "test@gmail.com",
    #        1,
    #        "juja",
    #        "https://90ea-105-160-50-193.ngrok-free.app/api/transactions",
    #        transaction_reference
    #      ) do
    #   {:ok, %HTTPoison.Response{status_code: 200, body: _body}} ->
    #     customer_record =
    #       Chpter.check_for_payment(
    #         transaction_reference,
    #         "https://90ea-105-160-50-193.ngrok-free.app/api/transactions"
    #       )

    #     IO.inspect(customer_record)
    # end

    # customer_record =
    #   Chpter.check_for_payment(
    #     "120237695961225084340254740",
    #     "https://90ea-105-160-50-193.ngrok-free.app/api/transactions"
    #   )

    IO.inspect(
      Chpter.initiate_payment(
        "pk_0b51e48bc6ac135ce3f65b1355248cae71ef085c0223bc0273535a4e174dce07",
        "254740769596",
        "John Doe",
        "test@gmail.com",
        1,
        "juja",
        "https://0ac1-105-160-50-193.ngrok-free.app/api/transactions",
        transaction_reference
      )
    )

    customer_record =
      Chpter.check_for_payment(
        transaction_reference,
        "https://0ac1-105-160-50-193.ngrok-free.app/api/transactions"
      )

    IO.inspect(customer_record)

    {:noreply,
     socket
     |> put_flash(:info, "Hey there")}
  end

  defp apply_action(socket, :index, %{"product_name" => product_name}) do
    product = Products.get_product_by_name!(product_name)

    colors =
      product.colors
      |> Enum.map(fn color -> {color.name, color.id} end)

    socket
    |> assign(:product, product)
    |> assign(:colors, colors)
    |> assign(:page_title, "#{product.name}")
  end

  defp apply_action(socket, :buy, %{"product_name" => product_name}) do
    product = Products.get_product_by_name!(product_name)

    colors =
      product.colors
      |> Enum.map(fn color -> color.name end)

    socket
    |> assign(:product, product)
    |> assign(:colors, colors)
    |> assign(:product_order, %ProductOrder{})
    |> assign(:changeset, ProductOrders.change_product_order(%ProductOrder{}))
    |> assign(:page_title, "#{product.name}")
  end

  defp apply_action(socket, :success, %{
         "product_name" => product_name,
         "product_order_id" => product_order_id
       }) do
    product = Products.get_product_by_name!(product_name)

    socket
    |> assign(:product, product)
    |> assign(:page_title, "Success")
  end

  defp apply_action(socket, :failed, %{
         "product_name" => product_name
       }) do
    product = Products.get_product_by_name!(product_name)

    socket
    |> assign(:product, product)
    |> assign(:page_title, "Failed")
  end

  def handle_event("validate", %{"product_order" => product_order_params}, socket) do
    changeset =
      socket.assigns.product_order
      |> ProductOrders.change_product_order(product_order_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_order" => product_order_params}, socket) do
    transaction_reference =
      TransactionAlgorithim.code_reference_for_product_order(
        product_order_params["product_id"],
        product_order_params["customer_phone_number"]
      )

    product = Products.get_product!(product_order_params["product_id"])

    total_price = product.price * String.to_integer(product_order_params["quantity"])

    new_product_order_params =
      product_order_params
      |> Map.put("product_order_id", transaction_reference)
      |> Map.put("status", "pending")
      |> Map.put("total_price", total_price)

    case IO.inspect(
           Chpter.initiate_payment(
             "pk_0b51e48bc6ac135ce3f65b1355248cae71ef085c0223bc0273535a4e174dce07",
             product_order_params["customer_phone_number"],
             product_order_params["customer_name"],
             product_order_params["customer_email"],
             1,
             product_order_params["location"],
             "https://90ea-105-160-50-193.ngrok-free.app/api/transactions",
             transaction_reference
           )
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: _body}} ->
        customer_record =
          Chpter.check_for_payment(
            transaction_reference,
            "https://90ea-105-160-50-193.ngrok-free.app/api/transactions"
          )

        if customer_record["success"] == true do
          case ProductOrders.create_product_order(new_product_order_params) do
            {:ok, _product_order} ->
              # Notify.send_product_order_as_sms(
              #   product_order_params["customer_phone_number"],
              #   product_order_params["customer_name"],
              #   product.name,
              #   product_order_params["quantity"],
              #   product_order_params["location"],
              #   "https://mwambarugby.com/product_orders/#{transaction_reference}"
              # )

              # Notify.send_product_order_as_email(
              #   product_order_params["customer_email"],
              #   product_order_params["customer_name"],
              #   product.name,
              #   product_order_params["quantity"],
              #   product_order_params["location"],
              #   "https://mwambarugby.com/product_orders/#{transaction_reference}"
              # )

              {:noreply,
               socket
               |> put_flash(
                 :info,
                 "Product order created successfully , check your mail and phone for delivery instructions"
               )
               |> push_redirect(
                 to:
                   Routes.product_order_show_path(
                     MwambaRfcWeb.Endpoint,
                     :show,
                     transaction_reference
                   )
               )}

            {:error, %Ecto.Changeset{} = changeset} ->
              {:noreply,
               socket
               |> assign(:changeset, changeset)
               |> push_redirect(
                 to:
                   Routes.shop_index_path(
                     NgepaWeb.Endpoint,
                     :success,
                     product.name,
                     transaction_reference
                   )
               )}
          end
        else
          {:noreply,
           socket
           |> put_flash(:error, "Payment Failed , #{customer_record["message"]}")
           |> push_redirect(
             to:
               Routes.shop_index_path(
                 NgepaWeb.Endpoint,
                 :failed,
                 product.name
               )
           )}
        end

      {:error, %HTTPoison.Error{reason: :timeout, id: nil}} ->
        customer_record =
          Chpter.check_for_payment(
            transaction_reference,
            "https://90ea-105-160-50-193.ngrok-free.app/api/transactions"
          )

        if customer_record["success"] == true do
          case ProductOrders.create_product_order(new_product_order_params) do
            {:ok, _product_order} ->
              # Notify.send_product_order_as_sms(
              #   product_order_params["customer_phone_number"],
              #   product_order_params["customer_name"],
              #   product.name,
              #   product_order_params["quantity"],
              #   product_order_params["location"],
              #   "https://mwambarugby.com/product_orders/#{transaction_reference}"
              # )

              # Notify.send_product_order_as_email(
              #   product_order_params["customer_email"],
              #   product_order_params["customer_name"],
              #   product.name,
              #   product_order_params["quantity"],
              #   product_order_params["location"],
              #   "https://mwambarugby.com/product_orders/#{transaction_reference}"
              # )

              {:noreply,
               socket
               |> push_redirect(
                 to:
                   Routes.shop_index_path(
                     NgepaWeb.Endpoint,
                     :success,
                     product.name,
                     transaction_reference
                   )
               )}

            {:error, %Ecto.Changeset{} = changeset} ->
              {:noreply,
               socket
               |> assign(:changeset, changeset)
               |> push_redirect(
                 to:
                   Routes.shop_index_path(
                     NgepaWeb.Endpoint,
                     :failed,
                     product.name
                   )
               )}
          end
        else
          {:noreply,
           socket
           |> put_flash(:error, "Payment Failed , #{customer_record["message"]}")
           |> push_redirect(
             to:
               Routes.shop_index_path(
                 NgepaWeb.Endpoint,
                 :failed,
                 product.name
               )
           )}
        end

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:noreply,
         socket
         |> put_flash(:error, "Payment Failed")
         |> push_redirect(
           to:
             Routes.shop_index_path(
               NgepaWeb.Endpoint,
               :failed,
               product.name
             )
         )}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:noreply,
         socket
         |> put_flash(:error, "Payment Failed , Timeout error")
         |> push_redirect(
           to:
             Routes.shop_index_path(
               NgepaWeb.Endpoint,
               :failed,
               product.name
             )
         )}
    end
  end
end