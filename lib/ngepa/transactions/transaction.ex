defmodule Ngepa.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :message, :string
    field :status, :integer
    field :success, :boolean, default: false
    field :amount, :string
    field :transaction_code, :string
    field :transaction_reference, :string
    field :phone_number, :string
    belongs_to :product, Ngepa.Products.Product

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [
      :message,
      :amount,
      :status,
      :success,
      :phone_number,
      :transaction_code,
      :product_id,
      :transaction_reference
    ])
    |> validate_required([
      :message,
      :status,
      :phone_number,
      :success,
      :transaction_reference,
      :product_id
    ])
  end
end
