defmodule Ngepa.ProductOrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ngepa.ProductOrders` context.
  """

  @doc """
  Generate a product_order.
  """
  def product_order_fixture(attrs \\ %{}) do
    {:ok, product_order} =
      attrs
      |> Enum.into(%{
        status: "some status",
        location: "some location",
        color: "some color",
        quantity: 42,
        customer_name: "some customer_name",
        customer_email: "some customer_email",
        customer_phone_number: "some customer_phone_number",
        more_location_details: "some more_location_details",
        latitude: 120.5,
        longitude: 120.5,
        total_price: 42,
        product_order_id: "some product_order_id"
      })
      |> Ngepa.ProductOrders.create_product_order()

    product_order
  end
end
