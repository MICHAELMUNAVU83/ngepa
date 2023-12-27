defmodule Ngepa.Repo.Migrations.CreateProductOrders do
  use Ecto.Migration

  def change do
    create table(:product_orders) do
      add :quantity, :integer
      add :customer_name, :string
      add :customer_email, :string
      add :customer_phone_number, :string
      add :location, :string
      add :more_location_details, :text
      add :status, :string
      add :latitude, :float
      add :longitude, :float
      add :total_price, :integer
      add :color, :string
      add :product_order_id, :string
      add :product_id, references(:products, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
