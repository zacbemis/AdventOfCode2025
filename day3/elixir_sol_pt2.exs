defmodule Day3 do
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
    |> find_max_pair()
    total + line_highest
  end

  defp find_max_pair([first | rest]) do
    {best, _best_first} =
      Enum.reduce(rest, {0, first}, &is_greater/2)
    best
  end

  defp is_greater(num, {best, best_first}) do
    new_num = best_first * 10 + num
    new_best = max(new_num, best)
    new_first = max(num, best_first)
    {new_best, new_first}
  end
end

total = Day3.solve("day3/input.txt")
IO.puts("Total: #{total}")
