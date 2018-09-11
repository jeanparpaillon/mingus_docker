defmodule Mg.Docker.Api.V1_24 do
  @moduledoc """
  Docker engine API v1.24 implementation
  """
  use Plug.Router

  alias Mg.Docker.Containers
  alias Mg.Docker.Api

  require Logger

  @api_vsn "1.24"
  
  plug :match
  plug :dispatch
  plug :fetch_query_params

  get "/containers/json" do
    containers = Containers.find(conn.query_params)
    send_resp(conn, 200, Jason.encode!(containers))
  end

  get "/version" do
    resp =
      Api.version(%{"ApiVersion" => @api_vsn})
      |> Jason.encode!()
    send_resp(conn, 200, resp)
  end
  
  def version do
    %{ "ApiVersion" => @api_vsn }
  end
end
