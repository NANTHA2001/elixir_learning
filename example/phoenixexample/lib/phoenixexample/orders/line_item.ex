defmodule Phoenixexample.Orders.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_line_items" do
    field :price, :decimal
    field :quantity, :integer
    # field :order_id, :id
    # field :product_id, :id
    belongs_to :order, Phoenixexample.Orders.Order
   belongs_to :product, Phoenixexample.Catalog.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:price, :quantity])
    |> validate_required([:price, :quantity])
  end
end
