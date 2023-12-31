defmodule Ngepa.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :primary_image, :string
      add :in_stock, :boolean, default: false, null: false
      add :price, :integer
      add :collection, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:products, :name)
  end
end
