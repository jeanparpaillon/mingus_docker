defmodule Mg.Docker.Image do
  @moduledoc """
  Describe and manipulate images
  """
  @type id :: String.t
  @type tag :: String.t
  
  @type t :: %__MODULE__{
    id: id,
    tags: [tag]
  }
  
  defstruct id: nil, tags: []

  @doc """
  Build image structure from sniffle
  """
  def from_sniffle(data) do
    tags = [ "#{:ft_dataset.name(data)}/#{:ft_dataset.version(data)}" ]
    
    %__MODULE__{
      id: data |> :ft_dataset.uuid(),
      tags: tags
    }
  end

  @doc """
  Get tags from image
  """
  def tags(%__MODULE__{tags: tags}), do: tags
end
