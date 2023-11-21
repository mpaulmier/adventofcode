defmodule Day1 do
  @input "inputs/1"

  defp normalize(content) do
    content
    |> String.split("\n", trim: true)
    |> Stream.map(&(String.to_integer(&1)))
  end

  defp get_input do
    {:ok, content} = File.read(@input)
    normalize(content)
  end

  defp fuel_required(mass) do
    Integer.floor_div(mass, 3) - 2
  end

  def part1() do
    get_input()
    |> Stream.map(&fuel_required/1)
    |> Enum.sum
  end

  defp total_required(mass) do
    Stream.iterate(mass, &fuel_required/1)
    |> Stream.take_while(&(&1 > 0))
    |> Stream.drop(1)
    |> Enum.sum
  end

  def part2() do
    get_input()
    |> Stream.map(&total_required/1)
    |> Enum.sum
  end
end

IO.puts("Part 1: #{Day1.part1()}")
IO.puts("Part 2: #{Day1.part2()}")
