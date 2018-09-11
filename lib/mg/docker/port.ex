defmodule Mg.Docker.Port do
  @moduledoc """
  Describes Docker port structure
  """

  @type type :: :tcp | :udp | :sctp

  @type t :: %__MODULE__{
    ip: :inet.ip_address,
    private_port: integer,
    public_port: integer,
    type: type
  }

  defstruct ip: nil,
    private_port: nil,
    public_port: nil,
    type: nil
end
