defmodule Mg.Docker.Api do
  @moduledoc """
  Entry point plug
  """
  use Plug.Router

  require Logger

  alias Mg.Docker.Api

  @min_api_vsn "1.24"
  @default_vsn Api.V1_38


  @vsn Mix.Project.get().project() |> Keyword.get(:version, "0.0.0")
  @os :os.cmd('uname -s') |> to_string() |> String.trim()
  @kernel_version :os.cmd('uname -r') |> to_string() |> String.trim()
  @go_version "elixir" <> (System.build_info() |> Map.get(:version))
  @git_commit "deadbee"
  @arch :os.cmd('uname -m') |> to_string() |> String.trim()
  @build_time DateTime.utc_now() |> DateTime.to_iso8601()
  @experimental true

  @version %{
    "Version" => @vsn,
    "Os" => @os,
    "KernelVersion" => @kernel_version,
    "GoVersion" => @go_version,
    "GitCommit" => @git_commit,
    "Arch" => @arch,
    "ApiVersion" => "",
    "MinAPIVersion" => @min_api_vsn,
    "BuildTime" => @build_time,
    "Experimental" => @experimental
  }
  
  plug :match
  plug :dispatch

  match "/_ping" do
    send_resp(conn, 200, "OK")
  end

  match "/version" do
    data =
      @default_vsn.version()
      |> version()
      |> Jason.encode!()
    send_resp(conn, 200, data)
  end

  forward "/v1.24", to: Api.V1_24
  forward "/v1.38", to: Api.V1_38

  match "/v*vsn" do
    send_resp(conn, 400, "Bad Request")
  end
  
  match _, to: Api.V1_38

  ###
  ### Common functions
  ###
  def version(custom) do
    @version
    |> Map.merge(custom)
  end
end
