defmodule Mg.Docker do
  @moduledoc """
  Mingus.Docker is a docker engine API for SmartOS (through Project Fifo services)
  """
  use Application

  require Logger

  defstruct sockets: [], children: []

  @doc false
  def start(_type, _args) do
    state =
      :mingus_docker
      |> Application.get_env(:listen, [])
      |> Enum.reduce(%__MODULE__{}, &cowboy_spec/2)
    
    {:ok, pid} = Supervisor.start_link(state.children, strategy: :one_for_one)
    {:ok, pid, state}
  end

  @doc false
  def stop(state) do
    state.sockets
    |> Enum.each(fn sock ->
      Logger.info("Cleanup socket #{sock}")
      File.rm!(sock)
    end)
  end

  ###
  ### Priv
  ###
  defp cowboy_spec({{:local, path}, port}, acc) do
    child = {Plug.Adapters.Cowboy2, scheme: :http, plug: Mg.Docker.Api,
             options: [ip: {:local, path}, port: port]}
    %{acc | children: [child | acc.children], sockets: [path | acc.sockets]}
  end
end
