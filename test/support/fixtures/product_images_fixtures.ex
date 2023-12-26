defmodule Ngepa.ProductImagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ngepa.ProductImages` context.
  """

  @doc """
  Generate a product_image.
  """
  def product_image_fixture(attrs \\ %{}) do
    {:ok, product_image} =
      attrs
      |> Enum.into(%{
        image_url: "some image_url"
      })
      |> Ngepa.ProductImages.create_product_image()

    product_image
  end
end
