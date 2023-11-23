defmodule Day2 do
  @input "inputs/2"

  defp normalize(content) do
    content
    |> String.split(",", trim: true)
    |> Stream.map(&(String.trim(&1)))
    |> Enum.map(&(String.to_integer(&1)))
  end

  defp get_input do
    {:ok, content} = File.read(@input)
    normalize(content)
end

  defp compute(op, intcode, pos) do
    pos1 = Enum.at(intcode, pos + 1)
    pos2 = Enum.at(intcode, pos + 2)
    output_pos = Enum.at(intcode, pos + 3)
    value1 = Enum.at(intcode, pos1)
    value2 = Enum.at(intcode, pos2)
    value = case op do
      :add -> value1 + value2
      :mult -> value1 * value2
    end
    List.replace_at(intcode, output_pos, value)
  end

  defp run(intcode) do
    all_positions = Stream.take_every(0..length(intcode), 4)

    Enum.reduce_while(all_positions, intcode, fn pos, acc ->
      opcode = Enum.at(acc, pos)
      case opcode do
        1  -> {:cont, compute(:add, acc, pos)}
        2  -> {:cont, compute(:mult, acc, pos)}
        99 -> {:halt, acc}
      end
    end)
  end

  defp set_state(intcode, noun, verb) do
    intcode
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end

  def part1 do
    get_input()
    |> set_state(12, 2)
    |> run
    |> List.first
  end

  def part2 do
    goal = 19690720
    Enum.filter(100..9999, fn x ->
      [noun, verb] = [div(x, 100), rem(x, 100)]
      res = get_input()
      |> set_state(noun, verb)
      |> run
      |> List.first
      res === goal
    end)
    |> List.first
  end

end

IO.puts("Part 1: #{Day2.part1()}")
IO.puts("Part 2: #{Day2.part2()}")
