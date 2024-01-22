defmodule Friends.Movie do
  use Ecto.Schema

  schema "movies" do
    field :title, :string
    field :tagline, :string
    has_many :characters, Friends.Character #This line establishes a one-to-many association between the Friends.Movie schema and the Friends.Character schema.
    #It indicates that a movie can have multiple characters associated with it.


    has_one :distributor, Friends.Distributor #This line establishes a one-to-one association between the Friends.Movie schema and the Friends.Distributor schema. It indicates that a movie has a single distributor associated with it. The :distributor atom is used as the name of the association,
    # and Friends.Distributor is the schema of the associated data.


    many_to_many :actors, Friends.Actor, join_through: "movies_actors"

    #join_through: "movies_actors": This option specifies the name of the join table that holds the many-to-many relationship.
    # In this case, the join table is named "movies_actors."
    #A join table is an intermediate table used to link records from the two associated tables (Friends.Movie and Friends.Actor in this case).
  end
end



# Belongs To: Indicates that a record in one table belongs to a record in another table. The table with the foreign key is said to "belong to" the table with the primary key.

# Has One: Indicates that a record in one table has a single related record in another table. This is essentially the reverse of "belongs to."

# Has Many: Indicates that a record in one table can have multiple related records in another table. This is a one-to-many relationship.

# Many To Many: Indicates that records in both tables can have multiple related records in the other. This involves a join table that facilitates the many-to-many relationship.
