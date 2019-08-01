defmodule ZxWeb.Router do
  use ZxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ZxWeb do
    pipe_through :api

    resources "/partners", PartnerController, except: [:new, :edit]

    get "/partners_by_location/:lat/:lng", PartnerController, :search_by_location
    get "/nearest_covering_partner/:lat/:lng", PartnerController, :get_nearest_covering
  end
end
