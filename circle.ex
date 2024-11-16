defmodule Shape do
  @moduledoc """
    Provides basic utility function
    to operate on geometric shapes
  """

  alias IO, as: Shit
  @pi 3.14159

  def area(args) do
    case args do
      {:circle, r} -> area(:circle, r)
    end
  end

  @doc "gets area of a circle"
  def area(:circle, r), do: @pi * r * r
  @doc "gets area of a rectangle"
  def area(:rect, a, b), do: a * b
  def area(:donut, outter, inner), do: area(:circle, outter) - area(:circle, inner)

  def say(name), do: Shit.puts(to_string(name))
  #
  # def circumference(r) do 
  #   2 * 3.14 * r
  # end
end

defmodule Foo do
  def foo do
    IO.puts("bar")
  end
  @spec puts_faggot_ages(list(integer()), map) :: atom
  def puts_faggot_ages(faggots, ages) do
    case faggots do
      [] ->
        :ok
      [name | tail] -> 
        IO.puts("#{name}'s age is #{ages[String.to_atom name]}")
        puts_faggot_ages(tail, ages)
    end
  end
end

faggots = ["tigran", "egor", "daniil"]
ages = %{tigran: 21, egor: 24, daniil: 27}
Foo.puts_faggot_ages(faggots, ages)
