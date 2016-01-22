defmodule SlackEx.Router do
  use SlackEx.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    scope "/api", SlackEx.Api, as: :api do
      get "/ping", PingController, :show
    end
  end

  scope "/", SlackEx do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SlackEx do
  #   pipe_through :api
  # end
end
