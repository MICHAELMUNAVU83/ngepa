defmodule Ngepa.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Ngepa.Repo

  alias Ngepa.Transactions.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction) |> Repo.preload(:product)
  end

  def list_transactions_by_search(search) do
    if search == "" do
      Repo.all(Transaction)
      |> Repo.preload(:product)
    else
      Repo.all(Transaction)
      |> Enum.filter(fn transaction -> transaction.success == true end)
      |> Repo.preload(:product)
      |> Enum.filter(fn transaction ->
        String.contains?(
          String.downcase(transaction.transaction_code),
          String.downcase(search)
        ) or
          String.contains?(
            String.downcase(transaction.transaction_reference),
            String.downcase(search)
          ) or
          String.contains?(
            String.downcase(transaction.amount),
            String.downcase(search)
          ) or
          String.contains?(
            String.downcase(transaction.product.name),
            String.downcase(search)
          ) or
          String.contains?(
            String.downcase(transaction.phone_number),
            String.downcase(search)
          ) or
          String.contains?(String.downcase(transaction.phone_number), String.downcase(search))
      end)
    end
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
