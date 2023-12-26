defmodule Ngepa.ProductOrderMessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ngepa.ProductOrderMessages` context.
  """

  @doc """
  Generate a product_order_message.
  """
  def product_order_message_fixture(attrs \\ %{}) do
    {:ok, product_order_message} =
      attrs
      |> Enum.into(%{
        message: "some message",
        sms_status: true,
        email_status: true
      })
      |> Ngepa.ProductOrderMessages.create_product_order_message()

    product_order_message
  end
end
