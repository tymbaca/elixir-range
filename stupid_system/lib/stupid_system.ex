defmodule StupidSystem do
  @moduledoc """
  Documentation for `StupidSystem`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> StupidSystem.hello()
      :world

  """
  def hello do
    case Portal.spawn(:orange) do
      {:ok, pid} -> IO.puts inspect(pid)
    end
    :world
  end
end
