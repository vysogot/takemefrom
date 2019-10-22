defmodule TakemefromWeb.Router do
  use TakemefromWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TakemefromWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TakemefromWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/registrations", RegistrationController, only: [:new, :create]
    resources "/play", PlayController, only: [:show]
    resources "/games", GamesController, only: [:new, :edit, :index, :create]
  end

  # Other scopes may use custom stacks.
  scope "/api", TakemefromWeb do
    pipe_through :api

    resources "/games", Api.GamesController, only: [:update]
  end
end
