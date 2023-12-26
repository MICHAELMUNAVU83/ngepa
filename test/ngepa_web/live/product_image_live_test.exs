defmodule NgepaWeb.ProductImageLiveTest do
  use NgepaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ngepa.ProductImagesFixtures

  @create_attrs %{image_url: "some image_url"}
  @update_attrs %{image_url: "some updated image_url"}
  @invalid_attrs %{image_url: nil}

  defp create_product_image(_) do
    product_image = product_image_fixture()
    %{product_image: product_image}
  end

  describe "Index" do
    setup [:create_product_image]

    test "lists all product_images", %{conn: conn, product_image: product_image} do
      {:ok, _index_live, html} = live(conn, Routes.product_image_index_path(conn, :index))

      assert html =~ "Listing Product images"
      assert html =~ product_image.image_url
    end

    test "saves new product_image", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.product_image_index_path(conn, :index))

      assert index_live |> element("a", "New Product image") |> render_click() =~
               "New Product image"

      assert_patch(index_live, Routes.product_image_index_path(conn, :new))

      assert index_live
             |> form("#product_image-form", product_image: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_image-form", product_image: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_image_index_path(conn, :index))

      assert html =~ "Product image created successfully"
      assert html =~ "some image_url"
    end

    test "updates product_image in listing", %{conn: conn, product_image: product_image} do
      {:ok, index_live, _html} = live(conn, Routes.product_image_index_path(conn, :index))

      assert index_live |> element("#product_image-#{product_image.id} a", "Edit") |> render_click() =~
               "Edit Product image"

      assert_patch(index_live, Routes.product_image_index_path(conn, :edit, product_image))

      assert index_live
             |> form("#product_image-form", product_image: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_image-form", product_image: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_image_index_path(conn, :index))

      assert html =~ "Product image updated successfully"
      assert html =~ "some updated image_url"
    end

    test "deletes product_image in listing", %{conn: conn, product_image: product_image} do
      {:ok, index_live, _html} = live(conn, Routes.product_image_index_path(conn, :index))

      assert index_live |> element("#product_image-#{product_image.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_image-#{product_image.id}")
    end
  end

  describe "Show" do
    setup [:create_product_image]

    test "displays product_image", %{conn: conn, product_image: product_image} do
      {:ok, _show_live, html} = live(conn, Routes.product_image_show_path(conn, :show, product_image))

      assert html =~ "Show Product image"
      assert html =~ product_image.image_url
    end

    test "updates product_image within modal", %{conn: conn, product_image: product_image} do
      {:ok, show_live, _html} = live(conn, Routes.product_image_show_path(conn, :show, product_image))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product image"

      assert_patch(show_live, Routes.product_image_show_path(conn, :edit, product_image))

      assert show_live
             |> form("#product_image-form", product_image: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#product_image-form", product_image: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_image_show_path(conn, :show, product_image))

      assert html =~ "Product image updated successfully"
      assert html =~ "some updated image_url"
    end
  end
end
