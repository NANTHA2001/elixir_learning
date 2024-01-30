defmodule PhoenixexampleWeb.PageController do
  use PhoenixexampleWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  #   conn
  # |> put_resp_content_type("text/plain")
  # |> send_resp(201, "")

  end
end
