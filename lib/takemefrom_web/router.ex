defmodule TakemefromWeb.Router do
  use TakemefromWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TakemefromWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TakemefromWeb.Plugs.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TakemefromWeb.Plugs.SetCurrentUser
  end

  scope "/", TakemefromWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
    resources "/registrations", RegistrationController, only: [:new, :create]
    resources "/play", PlayController, only: [:show]

    resources "/games", GameController, only: [:new, :edit, :index, :create, :delete] do
      get "/code", GameCodeController, :edit
      post "/code", GameCodeController, :update

      resources "/play", PlayV2Controller, only: [:show]
      resources "/observe", ObserveController, only: [:show]
    end

    get "/oauth2/github", Oauth2Controller, :github

    get "/oauth2/github/callback", Oauth2CallbacksController, :github
  end

  # Other scopes may use custom stacks.
  scope "/api", TakemefromWeb do
    pipe_through :api

    resources "/games", Api.GameController, only: [:show, :update]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TakemefromWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
