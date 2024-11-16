defmodule WeaponStore do
  @type t :: %WeaponStore{store: HashDict.t()}
  defstruct [
    :store
  ]

  @moduledoc """
  Documentation for `WeaponStore`.
  """

  def start do
    spawn(WeaponStore, :loop, [%WeaponStore{store: []}])
  end

  def loop(state) do
    new_state =
      receive do
        {:put, from_id, {:error, reason}} ->
          send(from_id, {:error, reason})
          state

        {:put, from_id, weapon} ->
          IO.puts("got :put message, from #{inspect(from_id)}")
          new_state = Map.put(state, :store, [weapon | state.store])
          send(from_id, :ok)
          new_state

        {:get, from_id, :all} ->
          IO.puts("got :get message, from #{inspect(from_id)}")
          weapons = state.store
          new_state = Map.put(state, :store, [])
          send(from_id, {:ok, weapons})
          new_state

        {_, from_id, _} ->
          IO.puts("got unknown message, from #{inspect(from_id)}")
          send(from_id, {:error, :unknown_command})
          state
      end

    loop(new_state)
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
    cond do
      String.contains?(name, @forbidden_contents) ->
        {:error, "name containes forbidden symbols #{inspect(@forbidden_contents)}"}

      String.length(name) <= 3 ->
        {:error, "name must be bigger then 3"}

      not String.printable?(name) ->
        {:error, "name must be printable"}

      String.first(name) != String.upcase(String.first(name)) ->
        {:error, "the first letter of the name must be uppercase"}

      true ->
        :ok
    end
  end
end
