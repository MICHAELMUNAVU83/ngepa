defmodule Ngepa.ProductOrderMessagesTest do
  use Ngepa.DataCase

  alias Ngepa.ProductOrderMessages

  describe "product_order_messages" do
    alias Ngepa.ProductOrderMessages.ProductOrderMessage

    import Ngepa.ProductOrderMessagesFixtures

    @invalid_attrs %{message: nil, sms_status: nil, email_status: nil}

    test "list_product_order_messages/0 returns all product_order_messages" do
      product_order_message = product_order_message_fixture()
      assert ProductOrderMessages.list_product_order_messages() == [product_order_message]
    end

    test "get_product_order_message!/1 returns the product_order_message with given id" do
      product_order_message = product_order_message_fixture()
      assert ProductOrderMessages.get_product_order_message!(product_order_message.id) == product_order_message
    end

    test "create_product_order_message/1 with valid data creates a product_order_message" do
      valid_attrs = %{message: "some message", sms_status: true, email_status: true}

      assert {:ok, %ProductOrderMessage{} = product_order_message} = ProductOrderMessages.create_product_order_message(valid_attrs)
      assert product_order_message.message == "some message"
      assert product_order_message.sms_status == true
      assert product_order_message.email_status == true
    end

    test "create_product_order_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductOrderMessages.create_product_order_message(@invalid_attrs)
    end

    test "update_product_order_message/2 with valid data updates the product_order_message" do
      product_order_message = product_order_message_fixture()
      update_attrs = %{message: "some updated message", sms_status: false, email_status: false}

      assert {:ok, %ProductOrderMessage{} = product_order_message} = ProductOrderMessages.update_product_order_message(product_order_message, update_attrs)
      assert product_order_message.message == "some updated message"
      assert product_order_message.sms_status == false
      assert product_order_message.email_status == false
    end

    test "update_product_order_message/2 with invalid data returns error changeset" do
      product_order_message = product_order_message_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductOrderMessages.update_product_order_message(product_order_message, @invalid_attrs)
      assert product_order_message == ProductOrderMessages.get_product_order_message!(product_order_message.id)
    end

    test "delete_product_order_message/1 deletes the product_order_message" do
      product_order_message = product_order_message_fixture()
      assert {:ok, %ProductOrderMessage{}} = ProductOrderMessages.delete_product_order_message(product_order_message)
      assert_raise Ecto.NoResultsError, fn -> ProductOrderMessages.get_product_order_message!(product_order_message.id) end
    end

    test "change_product_order_message/1 returns a product_order_message changeset" do
      product_order_message = product_order_message_fixture()
      assert %Ecto.Changeset{} = ProductOrderMessages.change_product_order_message(product_order_message)
    end
  end
end
