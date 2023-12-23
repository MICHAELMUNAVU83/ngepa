defmodule Ngepa.Colors.Color do
  use Ecto.Schema
  import Ecto.Changeset

  schema "colors" do
    field :name, :string
    belongs_to :product, Ngepa.Products.Product

    timestamps()
  end

  @doc false
  def changeset(color, attrs) do
    color
    |> cast(attrs, [:name, :product_id])
    |> validate_required([:name, :product_id])
  end
end
