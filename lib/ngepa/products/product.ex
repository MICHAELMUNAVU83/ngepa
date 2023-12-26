defmodule Ngepa.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :collection, :string
    field :primary_image, :string
    field :in_stock, :boolean, default: false
    field :price, :integer
    belongs_to :user, Ngepa.Users.User
    has_many :colors, Ngepa.Colors.Color
    has_many :product_images, Ngepa.ProductImages.ProductImage
    has_many :product_orders, Ngepa.ProductOrders.ProductOrder

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :primary_image, :in_stock, :price, :collection, :user_id])
    |> validate_required([
      :name,
      :description,
      :primary_image,
      :in_stock,
      :price,
      :collection,
      :user_id
    ])
    |> unique_constraint(:name)
  end
end
