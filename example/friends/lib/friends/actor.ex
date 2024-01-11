defmodule Friends.Actor do
  use Ecto.Schema

  schema "actor" do
    field :name, :string
    many_to_many :movies, Friends.Movie, join_through: "movies_actors"
  end
end
