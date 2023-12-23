defmodule Ngepa.ProductOrdersTest do
  use Ngepa.DataCase

  alias Ngepa.ProductOrders

  describe "product_orders" do
    alias Ngepa.ProductOrders.ProductOrder

    import Ngepa.ProductOrdersFixtures

    @invalid_attrs %{
      status: nil,
      location: nil,
      color: nil,
      quantity: nil,
      customer_name: nil,
      customer_email: nil,
      customer_phone_number: nil,
      more_location_details: nil,
      latitude: nil,
      longitude: nil,
      total_price: nil,
      product_order_id: nil
    }

    test "list_product_orders/0 returns all product_orders" do
      product_order = product_order_fixture()
      assert ProductOrders.list_product_orders() == [product_order]
    end

    test "get_product_order!/1 returns the product_order with given id" do
      product_order = product_order_fixture()
      assert ProductOrders.get_product_order!(product_order.id) == product_order
    end

    test "create_product_order/1 with valid data creates a product_order" do
      valid_attrs = %{
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
      }

      assert {:ok, %ProductOrder{} = product_order} =
               ProductOrders.create_product_order(valid_attrs)

      assert product_order.status == "some status"
      assert product_order.location == "some location"
      assert product_order.color == "some color"
      assert product_order.quantity == 42
      assert product_order.customer_name == "some customer_name"
      assert product_order.customer_email == "some customer_email"
      assert product_order.customer_phone_number == "some customer_phone_number"
      assert product_order.more_location_details == "some more_location_details"
      assert product_order.latitude == 120.5
      assert product_order.longitude == 120.5
      assert product_order.total_price == 42
      assert product_order.product_order_id == "some product_order_id"
    end

    test "create_product_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductOrders.create_product_order(@invalid_attrs)
    end

    test "update_product_order/2 with valid data updates the product_order" do
      product_order = product_order_fixture()

      update_attrs = %{
        status: "some updated status",
        location: "some updated location",
        color: "some updated color",
        quantity: 43,
        customer_name: "some updated customer_name",
        customer_email: "some updated customer_email",
        customer_phone_number: "some updated customer_phone_number",
        more_location_details: "some updated more_location_details",
        latitude: 456.7,
        longitude: 456.7,
        total_price: 43,
        product_order_id: "some updated product_order_id"
      }

      assert {:ok, %ProductOrder{} = product_order} =
               ProductOrders.update_product_order(product_order, update_attrs)

      assert product_order.status == "some updated status"
      assert product_order.location == "some updated location"
      assert product_order.color == "some updated color"
      assert product_order.quantity == 43
      assert product_order.customer_name == "some updated customer_name"
      assert product_order.customer_email == "some updated customer_email"
      assert product_order.customer_phone_number == "some updated customer_phone_number"
      assert product_order.more_location_details == "some updated more_location_details"
      assert product_order.latitude == 456.7
      assert product_order.longitude == 456.7
      assert product_order.total_price == 43
      assert product_order.product_order_id == "some updated product_order_id"
    end

    test "update_product_order/2 with invalid data returns error changeset" do
      product_order = product_order_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ProductOrders.update_product_order(product_order, @invalid_attrs)

      assert product_order == ProductOrders.get_product_order!(product_order.id)
    end

    test "delete_product_order/1 deletes the product_order" do
      product_order = product_order_fixture()
      assert {:ok, %ProductOrder{}} = ProductOrders.delete_product_order(product_order)

      assert_raise Ecto.NoResultsError, fn ->
        ProductOrders.get_product_order!(product_order.id)
      end
    end

    test "change_product_order/1 returns a product_order changeset" do
      product_order = product_order_fixture()
      assert %Ecto.Changeset{} = ProductOrders.change_product_order(product_order)
    end
  end
end
