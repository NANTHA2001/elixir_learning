defmodule PhoenixexampleWeb.Router do
  use PhoenixexampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html","json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhoenixexampleWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhoenixexampleWeb.Plugs.Locale, "en"

  end

  # plug :put_view, html: PhoenixexampleWeb.PageHTML, json: PhoenixexampleWeb.PageJSON

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixexampleWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/hello", HelloController, :index
    get "hello/:messenger", HelloController, :show
    resources "/products", ProductController
  end

  # scope "/api", HelloWeb.Api, as: :api do
  #   pipe_through :api

  #   scope "/v1", V1, as: :v1 do
  #     resources "/images",  ImageController
  #     resources "/reviews", ReviewController
  #     resources "/users",   UserController
  #   end
  # end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixexampleWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phoenixexample, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixexampleWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
