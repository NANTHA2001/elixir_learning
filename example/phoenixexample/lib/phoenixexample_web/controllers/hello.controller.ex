defmodule PhoenixexampleWeb.HelloController do
  use PhoenixexampleWeb, :controller


   def index(conn, _params) do
      render(conn, :index)
   end

#    def show(conn, %{"messenger" => messenger} = params) do
#     render(conn, :show, messenger: messenger)
#     # text(conn, "From messenger #{messenger}")
#     # json(conn, %{id: messenger})
#  end
def show(conn, %{"messenger" => messenger}) do
  conn
  |> assign(:messenger, messenger)
  |> assign(:receiver, "Dweezil")
  |> render(:show)
end
end
