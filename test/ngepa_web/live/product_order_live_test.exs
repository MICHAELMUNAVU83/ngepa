defmodule NgepaWeb.ProductOrderLiveTest do
  use NgepaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ngepa.ProductOrdersFixtures

  @create_attrs %{status: "some status", location: "some location", color: "some color", quantity: 42, customer_name: "some customer_name", customer_email: "some customer_email", customer_phone_number: "some customer_phone_number", more_location_details: "some more_location_details", latitude: 120.5, longitude: 120.5, total_price: 42, product_order_id: "some product_order_id"}
  @update_attrs %{status: "some updated status", location: "some updated location", color: "some updated color", quantity: 43, customer_name: "some updated customer_name", customer_email: "some updated customer_email", customer_phone_number: "some updated customer_phone_number", more_location_details: "some updated more_location_details", latitude: 456.7, longitude: 456.7, total_price: 43, product_order_id: "some updated product_order_id"}
  @invalid_attrs %{status: nil, location: nil, color: nil, quantity: nil, customer_name: nil, customer_email: nil, customer_phone_number: nil, more_location_details: nil, latitude: nil, longitude: nil, total_price: nil, product_order_id: nil}

  defp create_product_order(_) do
    product_order = product_order_fixture()
    %{product_order: product_order}
  end

  describe "Index" do
    setup [:create_product_order]

    test "lists all product_orders", %{conn: conn, product_order: product_order} do
      {:ok, _index_live, html} = live(conn, Routes.product_order_index_path(conn, :index))

      assert html =~ "Listing Product orders"
      assert html =~ product_order.status
    end

    test "saves new product_order", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.product_order_index_path(conn, :index))

      assert index_live |> element("a", "New Product order") |> render_click() =~
               "New Product order"

      assert_patch(index_live, Routes.product_order_index_path(conn, :new))

      assert index_live
             |> form("#product_order-form", product_order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_order-form", product_order: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_order_index_path(conn, :index))

      assert html =~ "Product order created successfully"
      assert html =~ "some status"
    end

    test "updates product_order in listing", %{conn: conn, product_order: product_order} do
      {:ok, index_live, _html} = live(conn, Routes.product_order_index_path(conn, :index))

      assert index_live |> element("#product_order-#{product_order.id} a", "Edit") |> render_click() =~
               "Edit Product order"

      assert_patch(index_live, Routes.product_order_index_path(conn, :edit, product_order))

      assert index_live
             |> form("#product_order-form", product_order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_order-form", product_order: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_order_index_path(conn, :index))

      assert html =~ "Product order updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes product_order in listing", %{conn: conn, product_order: product_order} do
      {:ok, index_live, _html} = live(conn, Routes.product_order_index_path(conn, :index))

      assert index_live |> element("#product_order-#{product_order.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_order-#{product_order.id}")
    end
  end

  describe "Show" do
    setup [:create_product_order]

    test "displays product_order", %{conn: conn, product_order: product_order} do
      {:ok, _show_live, html} = live(conn, Routes.product_order_show_path(conn, :show, product_order))

      assert html =~ "Show Product order"
      assert html =~ product_order.status
    end

    test "updates product_order within modal", %{conn: conn, product_order: product_order} do
      {:ok, show_live, _html} = live(conn, Routes.product_order_show_path(conn, :show, product_order))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product order"

      assert_patch(show_live, Routes.product_order_show_path(conn, :edit, product_order))

      assert show_live
             |> form("#product_order-form", product_order: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#product_order-form", product_order: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_order_show_path(conn, :show, product_order))

      assert html =~ "Product order updated successfully"
      assert html =~ "some updated status"
    end
  end
end
