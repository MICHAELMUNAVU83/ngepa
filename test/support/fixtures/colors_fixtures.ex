defmodule Ngepa.ColorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ngepa.Colors` context.
  """

  @doc """
  Generate a color.
  """
  def color_fixture(attrs \\ %{}) do
    {:ok, color} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Ngepa.Colors.create_color()

    color
  end
end
