defmodule ZxWeb.Router do
  use ZxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ZxWeb do
    pipe_through :api

    resources "/partners", PartnerController, except: [:new, :edit]
  end
end
