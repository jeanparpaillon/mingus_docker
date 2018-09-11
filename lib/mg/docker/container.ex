defmodule Mg.Docker.Container do
  @moduledoc """
  Describe Docker container
  """

  alias Mg.Docker.Port

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
    %__MODULE__{
      id: data |> :ft_vm.uuid(),
      names: data |> :ft_vm.alias() |> List.wrap(),
      image: data |> :ft_vm.dataset(),
      image_id: data |> :ft_vm.dataset(),
      created: data |> :ft_vm.created_at(),
      state: data |> :ft_vm.state(),
      status: data |> :ft_vm.state()
    }
  end
end

defimpl Jason.Encoder, for: Mg.Docker.Container do
  def encode(data, opts) do
    %{
      "Id" => data.id,
      "Names" => data.names,
      "Image" => data.image,
      "ImageID" => data.image_id,
      "Created" => data.created,
      "state" => data.state,
      "status" => data.status
    }
    |> Jason.Encode.map(opts)
  end
end
