defmodule Friends.Repo.Migrations.CreateMoviesActors do
  use Ecto.Migration

  def change do
    create table(:movie_actors, primary_key: false) do
      add :movie_id, references(:movies)
      add :actor_id, references(:actor)
    end

    create unique_index(:movie_actors, [:movie_id, :actor_id])

  end
end
# I'm new!
