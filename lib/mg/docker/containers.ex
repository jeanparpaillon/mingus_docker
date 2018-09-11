defmodule Mg.Docker.Containers do
  @moduledoc """
  Operations on containers
  """

  alias Mg.Docker.Container

  @doc """
  Find containers
  """
  def find(_opts) do
    :ls_vm.list()
    |> elem(1)
    |> Enum.map(fn uuid -> {:ok, vm} = :ls_vm.get(uuid); vm end)
    |> Enum.map(&Container.from_sniffle/1)
  end
end
