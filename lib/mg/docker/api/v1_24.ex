defmodule Mg.Docker.Api.V1_24 do
  @moduledoc """
  Docker engine API v1.24 implementation
  """
  use Plug.Router

  alias Mg.Docker.Api

  require Logger

  @api_vsn "1.24"
  
  plug :match
  plug :dispatch

  get "/containers/json" do
    send_resp(conn, 200, Jason.encode!([]))
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
