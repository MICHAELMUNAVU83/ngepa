defmodule Ngepa.ProductsTest do
  use Ngepa.DataCase

  alias Ngepa.Products

  describe "products" do
    alias Ngepa.Products.Product

    import Ngepa.ProductsFixtures

    @invalid_attrs %{
      name: nil,
      description: nil,
      collection: nil,
      primary_image: nil,
      in_stock: nil,
      price: nil
    }

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        collection: "some collection",
        primary_image: "some primary_image",
        in_stock: true,
        price: 42
      }

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.collection == "some collection"
      assert product.primary_image == "some primary_image"
      assert product.in_stock == true
      assert product.price == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        collection: "some updated collection",
        primary_image: "some updated primary_image",
        in_stock: false,
        price: 43
      }

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.collection == "some updated collection"
      assert product.primary_image == "some updated primary_image"
      assert product.in_stock == false
      assert product.price == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
