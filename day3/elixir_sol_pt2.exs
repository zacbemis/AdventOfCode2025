defmodule Day3 do
  @num_digits 12
  def solve(file_path) do
    file_path
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(0, &logic/2)
  end

  defp logic(line, total) do
    line_highest = String.graphemes(line)
    |> Enum.map(&String.to_integer/1)
    |> find_highest_num()
    total + line_highest
  end

  defp find_highest_num(line) do
    
  end
end
total = Day3.solve("day3/input.txt")
IO.puts("Total: #{total}")
