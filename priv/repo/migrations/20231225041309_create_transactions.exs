defmodule Ngepa.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :message, :string
      add :amount, :string
      add :status, :integer
      add :success, :boolean, default: false, null: false
      add :transaction_code, :string
      add :transaction_reference, :string
      add :phone_number, :string
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end
  end
end
