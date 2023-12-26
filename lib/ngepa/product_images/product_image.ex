defmodule Ngepa.ProductImages.ProductImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_images" do
    field :image_url, :string
    belongs_to :product, Ngepa.Products.Product

    timestamps()
  end

  @doc false
  def changeset(product_image, attrs) do
    product_image
    |> cast(attrs, [:image_url, :product_id])
    |> validate_required([:image_url, :product_id])
  end
end
