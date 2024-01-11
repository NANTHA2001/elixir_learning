defmodule Friends.Repo.Migrations.CreateActors do
  use Ecto.Migration

  def change do
    create table(:actor) do
      add :name, :string
    end
  end
end
