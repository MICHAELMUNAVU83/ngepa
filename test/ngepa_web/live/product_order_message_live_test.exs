defmodule NgepaWeb.ProductOrderMessageLiveTest do
  use NgepaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ngepa.ProductOrderMessagesFixtures

  @create_attrs %{message: "some message", sms_status: true, email_status: true}
  @update_attrs %{message: "some updated message", sms_status: false, email_status: false}
  @invalid_attrs %{message: nil, sms_status: false, email_status: false}

  defp create_product_order_message(_) do
    product_order_message = product_order_message_fixture()
    %{product_order_message: product_order_message}
  end

  describe "Index" do
    setup [:create_product_order_message]

    test "lists all product_order_messages", %{conn: conn, product_order_message: product_order_message} do
      {:ok, _index_live, html} = live(conn, Routes.product_order_message_index_path(conn, :index))

      assert html =~ "Listing Product order messages"
      assert html =~ product_order_message.message
    end

    test "saves new product_order_message", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.product_order_message_index_path(conn, :index))

      assert index_live |> element("a", "New Product order message") |> render_click() =~
               "New Product order message"

      assert_patch(index_live, Routes.product_order_message_index_path(conn, :new))

      assert index_live
             |> form("#product_order_message-form", product_order_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_order_message-form", product_order_message: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_order_message_index_path(conn, :index))

      assert html =~ "Product order message created successfully"
      assert html =~ "some message"
    end

    test "updates product_order_message in listing", %{conn: conn, product_order_message: product_order_message} do
      {:ok, index_live, _html} = live(conn, Routes.product_order_message_index_path(conn, :index))

      assert index_live |> element("#product_order_message-#{product_order_message.id} a", "Edit") |> render_click() =~
               "Edit Product order message"

      assert_patch(index_live, Routes.product_order_message_index_path(conn, :edit, product_order_message))

      assert index_live
             |> form("#product_order_message-form", product_order_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_order_message-form", product_order_message: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_order_message_index_path(conn, :index))

      assert html =~ "Product order message updated successfully"
      assert html =~ "some updated message"
    end

    test "deletes product_order_message in listing", %{conn: conn, product_order_message: product_order_message} do
      {:ok, index_live, _html} = live(conn, Routes.product_order_message_index_path(conn, :index))

      assert index_live |> element("#product_order_message-#{product_order_message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_order_message-#{product_order_message.id}")
    end
  end

  describe "Show" do
    setup [:create_product_order_message]

    test "displays product_order_message", %{conn: conn, product_order_message: product_order_message} do
      {:ok, _show_live, html} = live(conn, Routes.product_order_message_show_path(conn, :show, product_order_message))

      assert html =~ "Show Product order message"
      assert html =~ product_order_message.message
    end

    test "updates product_order_message within modal", %{conn: conn, product_order_message: product_order_message} do
      {:ok, show_live, _html} = live(conn, Routes.product_order_message_show_path(conn, :show, product_order_message))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product order message"

      assert_patch(show_live, Routes.product_order_message_show_path(conn, :edit, product_order_message))

      assert show_live
             |> form("#product_order_message-form", product_order_message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#product_order_message-form", product_order_message: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_order_message_show_path(conn, :show, product_order_message))

      assert html =~ "Product order message updated successfully"
      assert html =~ "some updated message"
    end
  end
end
