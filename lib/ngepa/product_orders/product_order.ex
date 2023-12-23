defmodule Ngepa.ProductOrders.ProductOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_orders" do
    field :status, :string
    field :location, :string
    field :color, :string
    field :quantity, :integer
    field :customer_name, :string
    field :customer_email, :string
    field :customer_phone_number, :string
    field :more_location_details, :string
    field :latitude, :float
    field :longitude, :float
    field :total_price, :integer
    field :product_order_id, :string
    belongs_to :product, Ngepa.Products.Product

    timestamps()
  end

  @doc false
  def changeset(product_order, attrs) do
    product_order
    |> cast(attrs, [
      :quantity,
      :customer_name,
      :customer_email,
      :customer_phone_number,
      :location,
      :more_location_details,
      :status,
      :latitude,
      :longitude,
      :total_price,
      :color,
      :product_order_id,
      :product_id
    ])
    |> validate_required([
      :quantity,
      :customer_name,
      :customer_email,
      :customer_phone_number,
      :location,
      :more_location_details,
      :status,
      :latitude,
      :longitude,
      :total_price,
      :color,
      :product_order_id
    ])
  end
end
