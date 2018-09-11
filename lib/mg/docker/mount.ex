defmodule Mg.Docker.Mount do
  @moduledoc """
  Describe mount structure
  """
  @type source :: String.t
  @type type :: :bind | :volume | :tmpfs
  @type consistency :: :default | :consistent | :cached | :delegated

  @type t :: %__MODULE__{
    target: Path.t,
    source: source,
    type: type,
    read_only: boolean,
    consistency: consistency,
    bind_options: [],
    volume_options: []
  }

  defstruct target: nil,
    source: nil,
    type: nil,
    read_only: nil,
    consistency: nil,
    bind_options: nil,
    volume_options: nil
end
