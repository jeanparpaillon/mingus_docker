defmodule Mg.Docker.Containers do
  @moduledoc """
  Operations on containers
  """
  alias Mg.Docker.Errors.FifoConnectionError
  alias Mg.Docker.Container

  @doc """
  Find containers
  """
  def find(_opts) do
    case :ls_vm.list() do
      {:ok, uuids} ->
        uuids
        |> Enum.map(&get/1)
        |> Enum.map(&Container.from_sniffle/1)

      {:error, :connect} ->
        raise FifoConnectionError
    end
  end

  @doc """
  Get container details
  """
  def get(uuid) do
    case :ls_vm.get(uuid) do
      {:ok, vm} ->
        vm

      {:error, :connect} ->
        raise FifoConnectionError
    end
  end
end
