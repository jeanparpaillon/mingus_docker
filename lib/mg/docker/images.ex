defmodule Mg.Docker.Images do
  @moduledoc """
  Manages and cache images
  """
  alias Mg.Docker.Errors.FifoConnectionError
  alias Mg.Docker.Image

  @doc """
  Get image from UUID

  Results are cached
  """
  @spec get(Image.id) :: Image.t | nil
  def get(uuid) do
    case :ls_dataset.get(uuid) do
      {:ok, ds} ->
        Image.from_sniffle(ds)

      {:error, :connect} ->
        raise FifoConnectionError

      :not_found ->
        nil
    end
  end
end
