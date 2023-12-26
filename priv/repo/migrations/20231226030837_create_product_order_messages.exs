defmodule Ngepa.Repo.Migrations.CreateProductOrderMessages do
  use Ecto.Migration

  def change do
    create table(:product_order_messages) do
      add :message, :string
      add :sms_status, :boolean, default: false, null: false
      add :email_status, :boolean, default: false, null: false
      add :product_order_id, references(:product_orders, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
