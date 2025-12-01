defmodule Day1 do
    @size 100
    @start_pos 50

    def solve(filePath) do
        {pos, num0} =
            File.stream!(filePath, [], :line)
            |> Stream.map(&String.trim_trailing/1)
            |> Enum.reduce({@start_pos,0}, fn<<dir::binary-size(1), num::binary>>, {pos, num0} ->
                steps = String.to_integer(num)
                delta = case dir do
                    "L" -> -steps
                    "R" -> steps
                end
                new_pos = Integer.mod(pos + delta, @size)
                num0 = if new_pos == 0 do num0 + 1 else num0 end
                {new_pos, num0}
            end)
        IO.puts("Final position: #{pos}")
        IO.puts("Number of 0s: #{num0}")
    end
end


Day1.solve("day1/input.txt")
