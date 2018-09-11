defmodule Mg.Docker.Api.V1_38 do
  @moduledoc """
  Docker engine API v1.38 implementation
  """
  use Plug.Router

  require Logger

  alias Mg.Docker.Api

  @api_vsn "1.38"
  
  plug :match
  plug :dispatch

  get "/containers/json" do
    Logger.debug(fn -> "#{inspect conn}"end)
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
