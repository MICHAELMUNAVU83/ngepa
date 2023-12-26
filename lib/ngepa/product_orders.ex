defmodule Ngepa.ProductOrders do
  @moduledoc """
  The ProductOrders context.
  """

  import Ecto.Query, warn: false
  alias Ngepa.Repo

  alias Ngepa.ProductOrders.ProductOrder

  @doc """
  Returns the list of product_orders.

  ## Examples

      iex> list_product_orders()
      [%ProductOrder{}, ...]

  """
  def list_product_orders do
    Repo.all(ProductOrder)
  end

  @doc """
  Gets a single product_order.

  Raises `Ecto.NoResultsError` if the Product order does not exist.

  ## Examples

      iex> get_product_order!(123)
      %ProductOrder{}

      iex> get_product_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_order!(id), do: Repo.get!(ProductOrder, id)

  def get_product_order_by_product_id!(product_order_id),
    do: Repo.get_by!(ProductOrder, product_order_id: product_order_id) |> Repo.preload(:product)

  @doc """
  Creates a product_order.

  ## Examples

      iex> create_product_order(%{field: value})
      {:ok, %ProductOrder{}}

      iex> create_product_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_order(attrs \\ %{}) do
    %ProductOrder{}
    |> ProductOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_order.

  ## Examples

      iex> update_product_order(product_order, %{field: new_value})
      {:ok, %ProductOrder{}}

      iex> update_product_order(product_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_order(%ProductOrder{} = product_order, attrs) do
    product_order
    |> ProductOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_order.

  ## Examples

      iex> delete_product_order(product_order)
      {:ok, %ProductOrder{}}

      iex> delete_product_order(product_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_order(%ProductOrder{} = product_order) do
    Repo.delete(product_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_order changes.

  ## Examples

      iex> change_product_order(product_order)
      %Ecto.Changeset{data: %ProductOrder{}}

  """
  def change_product_order(%ProductOrder{} = product_order, attrs \\ %{}) do
    ProductOrder.changeset(product_order, attrs)
  end
end
