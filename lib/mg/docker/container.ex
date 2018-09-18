defmodule Mg.Docker.Container do
  @moduledoc """
  Describe Docker container
  """

  alias Mg.Docker.{Image, Images, Port}

  @type id :: String.t
  @type name :: String.t
  @type image_name :: String.t
  @type image_id :: String.t
  @type command :: String.t
  @type label :: String.t
  @type state :: String.t
  @type status :: String.t

  @type host_config :: {:network_mode, network_mode}
  @type network_mode :: String.t

  @type network_setting :: {:networks, endpoint_settings}
  @type endpoint_settings :: map
  
  @type t :: %__MODULE__{
    id: id,
    names: [name],
    image: image_name,
    image_id: image_id,
    command: command,
    created: integer,
    ports: [Port.t],
    size_rw: integer,
    size_root_fs: integer,
    labels: [label],
    state: state,
    status: status,
    host_config: [host_config],
    network_settings: [network_setting],
    mounts: [Mount.t]
  }

  defstruct id: nil,
    names: [],
    image: nil,
    image_id: nil,
    command: nil,
    created: nil,
    ports: [],
    size_rw: 0,
    size_root_fs: 0,
    labels: [],
    state: nil,
    status: nil,
    host_config: nil,
    network_settings: nil,
    mounts: []
  
  @doc """
  Build a new container structure from sniffle
  """
  def from_sniffle(data) do
    config = data |> :ft_vm.config()

    names =
      config
      |> Map.get("hostname")
      |> List.wrap()
      |> Enum.concat(data |> :ft_vm.alias() |> List.wrap())

    image_id = data |> :ft_vm.dataset()
    image_name =
      image_id
      |> Images.get()
      |> case do
           nil ->
             ""

           image ->
             image |> Image.tags() |> List.first()
         end
    size_root_fs = Map.get(config, "quota", 0) * 1_000_000
    
    %__MODULE__{
      id: data |> :ft_vm.uuid(),
      names: names,
      image_id: image_id,
      image: image_name,
      command: "<image>",
      created: data |> :ft_vm.created_at(),
      state: data |> :ft_vm.state(),
      status: data |> :ft_vm.state() |> to_docker_status(),
      ports: [],     # ???
      labels: %{},   # ???
      size_rw: 1,    # ???
      size_root_fs: size_root_fs
    }
  end

  ###
  ### Priv
  ###
  defp to_docker_status(:failed), do: "failed"
  defp to_docker_status(_), do: "running"
end

defimpl Jason.Encoder, for: Mg.Docker.Container do
  alias Mg.Docker.Utils
  
  @to_json [
    {"Id", :id},
    {"Names", :names},
    {"Image", :image},
    {"ImageID", :image_id},
    {"Command", :command},
    {"Created", :created},
    {"State", :state},
    {"Status", :status},
    {"Ports", :ports},
    {"Labels", :labels},
    {"SizeRw", :size_rw},
    {"SizeRootFs", :size_root_fs}
  ]
  
  def encode(data, opts) do
    data
    |> Utils.remap_fields(@to_json)
    |> Jason.Encode.map(opts)
  end
end
