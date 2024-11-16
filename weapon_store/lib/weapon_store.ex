defmodule WeaponStore do
  @moduledoc """
  Documentation for `WeaponStore`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WeaponStore.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule Weapon do
  defstruct [
    :name,
    :type
  ]

  def new(name, type) do
    with :ok <- is_type(type),
         :ok <- is_valid_name(name) do
      {:ok, %Weapon{name: name, type: type}}
    end
  end

  @types [:firegun, :laser, :watergun, :explosive]
  @types_str "[#{Enum.join(Enum.map(@types, fn tp -> Atom.to_string(tp) end), " ")}]"
  defp is_type(type) do
    if type in @types do
      :ok
    else
      {:error, "type must be one of #{@types_str}, got '#{type}'"}
    end
  end

  @forbidden_contents ["dildo", "%", "$", "^"]
  defp is_valid_name(name) do
    with true <- not String.contains?(name, @forbidden_contents),
         true <- String.length(name) > 3,
         true <- String.printable?(name),
         true <- String.first(name) == String.upcase(String.first(name)) do
      :ok
    else
      _ -> {:error, "invalid name, got '#{name}'"}
    end
  end
end
