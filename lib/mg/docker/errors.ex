defmodule Mg.Docker.Errors do

  defmodule FifoConnectionError do
    defexception message: "Error connecting to FiFo", plug_status: 500
  end
end
