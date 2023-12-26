defmodule Ngepa.ProductOrderMessages do
  @moduledoc """
  The ProductOrderMessages context.
  """

  import Ecto.Query, warn: false
  alias Ngepa.Repo

  alias Ngepa.ProductOrderMessages.ProductOrderMessage

  @doc """
  Returns the list of product_order_messages.

  ## Examples

      iex> list_product_order_messages()
      [%ProductOrderMessage{}, ...]

  """
  def list_product_order_messages do
    Repo.all(ProductOrderMessage)
  end

  @doc """
  Gets a single product_order_message.

  Raises `Ecto.NoResultsError` if the Product order message does not exist.

  ## Examples

      iex> get_product_order_message!(123)
      %ProductOrderMessage{}

      iex> get_product_order_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_order_message!(id), do: Repo.get!(ProductOrderMessage, id)

  @doc """
  Creates a product_order_message.

  ## Examples

      iex> create_product_order_message(%{field: value})
      {:ok, %ProductOrderMessage{}}

      iex> create_product_order_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_order_message(attrs \\ %{}) do
    %ProductOrderMessage{}
    |> ProductOrderMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_order_message.

  ## Examples

      iex> update_product_order_message(product_order_message, %{field: new_value})
      {:ok, %ProductOrderMessage{}}

      iex> update_product_order_message(product_order_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_order_message(%ProductOrderMessage{} = product_order_message, attrs) do
    product_order_message
    |> ProductOrderMessage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_order_message.

  ## Examples

      iex> delete_product_order_message(product_order_message)
      {:ok, %ProductOrderMessage{}}

      iex> delete_product_order_message(product_order_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_order_message(%ProductOrderMessage{} = product_order_message) do
    Repo.delete(product_order_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_order_message changes.

  ## Examples

      iex> change_product_order_message(product_order_message)
      %Ecto.Changeset{data: %ProductOrderMessage{}}

  """
  def change_product_order_message(%ProductOrderMessage{} = product_order_message, attrs \\ %{}) do
    ProductOrderMessage.changeset(product_order_message, attrs)
  end
end
