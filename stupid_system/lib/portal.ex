defmodule Portal do
  use Agent

  def spawn(color) when is_atom(color) do
    Agent.start_link(fn -> [] end, name: color)
  end
end
