defmodule Mg.Docker.Utils do
  @moduledoc false

  @doc false
  def remap_fields(data, mapping) do
    Enum.reduce(mapping, %{}, fn {to, from}, acc ->
      data
      |> Map.fetch(from)
      |> case do
           {:ok, val} ->
             Map.put(acc, to, val)

           _ ->
             acc
         end
    end)
  end
end
