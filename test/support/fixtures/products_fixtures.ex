defmodule Ngepa.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ngepa.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description",
        collection: "some collection",
        primary_image: "some primary_image",
        in_stock: true,
        price: 42
      })
      |> Ngepa.Products.create_product()

    product
  end
end
