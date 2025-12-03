defmodule Day2 do
  def solve(file_path) do
    file_path
    |> File.read!()
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(fn range ->
      [min, max] = String.split(range, "-")
      {String.to_integer(min), String.to_integer(max)}
    end)
    |> Enum.reduce(0, &logic/2)
  end

  defp logic({min, max}, total) do
    Enum.reduce(min..max, total, fn num, acc ->
      acc + validate_num(num)
    end)
  end

  defp validate_num(num) do
    s = Integer.to_string(num)
    len = String.length(s)

    if repeating_pattern?(s, len), do: num, else: 0
  end

  defp repeating_pattern?(_s, len) when len < 2, do: false
  defp repeating_pattern?(s, len) do
    1..div(len, 2)
    |> Enum.any?(fn block_size ->
      rem(len, block_size) == 0 and match_blocks?(s, block_size)
    end)
  end

  defp match_blocks?(s, block_size) do
    <<chunk::binary-size(block_size), rest::binary>> = s
    match_rest(rest, chunk, block_size)
  end

  defp match_rest(<<>>, _chunk, _block_size), do: true
  defp match_rest(rest, chunk, block_size) do
    case rest do
      <<^chunk::binary-size(block_size), next_rest::binary>> -> match_rest(next_rest, chunk, block_size)
      _ -> false
    end
  end
end

total = Day2.solve("day2/input.txt")
IO.puts("Total: #{total}")
