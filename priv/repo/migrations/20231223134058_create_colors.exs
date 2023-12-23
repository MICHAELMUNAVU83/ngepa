defmodule Ngepa.Repo.Migrations.CreateColors do
  use Ecto.Migration

  def change do
    create table(:colors) do
      add :name, :string
      add :product_id, references(:products, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
