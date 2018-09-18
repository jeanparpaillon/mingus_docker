defmodule Mg.Docker.Api.V1_24 do
  @moduledoc """
  Docker engine API v1.24 implementation
  """
  use Plug.Router
  use Plug.ErrorHandler

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

  def handle_errors(conn, %{kind: :error, reason: reason, stack: _stack}) do
    send_resp(conn, Plug.Exception.status(reason), Exception.message(reason))
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, 500, "Something went wrong")
  end
  
  def version do
    %{ "ApiVersion" => @api_vsn }
  end
end
