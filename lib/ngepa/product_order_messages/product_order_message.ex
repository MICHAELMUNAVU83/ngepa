defmodule Ngepa.ProductOrderMessages.ProductOrderMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_order_messages" do
    field :message, :string
    field :sms_status, :boolean, default: false
    field :email_status, :boolean, default: false

    belongs_to :product_order, Ngepa.ProductOrders.ProductOrder
    timestamps()
  end

  @doc false
  def changeset(product_order_message, attrs) do
    product_order_message
    |> cast(attrs, [:message, :sms_status, :email_status, :product_order_id])
    |> validate_required([:message, :sms_status, :email_status, :product_order_id])
  end
end
