defmodule Day1 do
  @size 100
  @start_pos 50

  def solve(filePath) do
    {pos, num0, cross0} =
      File.stream!(filePath, [], :line)
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.reduce({@start_pos, 0, 0}, fn <<dir::binary-size(1), num::binary>>, {pos, num0, cross0} ->
        steps = String.to_integer(num)
        delta =
          case dir do
            "L" -> -steps
            "R" -> steps
          end
        raw = pos + delta
        new_pos = Integer.mod(raw, @size)
        num0 = if new_pos == 0, do: num0 + 1, else: num0
        crosses = find_crosses(pos, delta)
        {new_pos, num0, cross0 + crosses}
      end)
    IO.puts("Final position: #{pos}")
    IO.puts("Number of 0s: #{num0}")
    IO.puts("Number of crosses: #{num0 + cross0}")
  end

  defp find_crosses(_pos, 0), do: 0

  defp find_crosses(pos, delta) do
    loops = div(abs(delta), @size)
    remainder = rem(delta, @size)
    extra =
      cond do
        remainder > 0 and pos + remainder >= @size -> 1
        remainder < 0 and pos > 0 and pos + remainder <= 0 -> 1
        true -> 0
      end
    total_crosses = loops + extra
    new_pos = Integer.mod(pos + delta, @size)
    if new_pos == 0 do
      total_crosses - 1
    else
      total_crosses
    end
  end
end

Day1.solve("day1/input.txt")
