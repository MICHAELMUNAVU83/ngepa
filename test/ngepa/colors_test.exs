defmodule Ngepa.ColorsTest do
  use Ngepa.DataCase

  alias Ngepa.Colors

  describe "colors" do
    alias Ngepa.Colors.Color

    import Ngepa.ColorsFixtures

    @invalid_attrs %{name: nil}

    test "list_colors/0 returns all colors" do
      color = color_fixture()
      assert Colors.list_colors() == [color]
    end

    test "get_color!/1 returns the color with given id" do
      color = color_fixture()
      assert Colors.get_color!(color.id) == color
    end

    test "create_color/1 with valid data creates a color" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Color{} = color} = Colors.create_color(valid_attrs)
      assert color.name == "some name"
    end

    test "create_color/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Colors.create_color(@invalid_attrs)
    end

    test "update_color/2 with valid data updates the color" do
      color = color_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Color{} = color} = Colors.update_color(color, update_attrs)
      assert color.name == "some updated name"
    end

    test "update_color/2 with invalid data returns error changeset" do
      color = color_fixture()
      assert {:error, %Ecto.Changeset{}} = Colors.update_color(color, @invalid_attrs)
      assert color == Colors.get_color!(color.id)
    end

    test "delete_color/1 deletes the color" do
      color = color_fixture()
      assert {:ok, %Color{}} = Colors.delete_color(color)
      assert_raise Ecto.NoResultsError, fn -> Colors.get_color!(color.id) end
    end

    test "change_color/1 returns a color changeset" do
      color = color_fixture()
      assert %Ecto.Changeset{} = Colors.change_color(color)
    end
  end
end
