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
    IO.puts("Number of crosses: #{cross0}")
    IO.puts("Total (0s + crosses): #{num0 + cross0}")
  end

  defp find_crosses(_pos, 0), do: 0

  defp find_crosses(pos, delta) do
    loops = div(abs(delta), @size)
    remainder = rem(delta, @size)
    nsum = pos + remainder
    extra =
      cond do
        nsum > @size or (loops == 0 and nsum == @size) -> 1
        nsum < 0 or (loops == 0 and nsum == 0 and pos > 0) -> 1
        true -> 0
      end
    loops + extra
  end
end

Day1.solve("day1/input.txt")
