defmodule Mg.DockerTest do
  use ExUnit.Case
  doctest Mg.Docker

  test "greets the world" do
    assert Mg.Docker.hello() == :world
  end
end
