defmodule AdventOfCode.Day01 do
  @digits ~w(0 1 2 3 4 5 6 7 8 9)

  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&get_calibration_values(&1, nil, nil, :part1))
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  # def part1(args) do
  #   args
  #   |> String.split("\n", trim: true)
  #   |> Enum.map(fn line -> String.graphemes(line) end)
  #   |> Enum.map(fn line ->
  #     first =
  #       line
  #       |> Enum.find(fn char -> Regex.match?(~r/\d/, char) end)
  #
  #     last =
  #       line
  #       |> Enum.reverse()
  #       |> Enum.find(fn char -> Regex.match?(~r/\d/, char) end)
  #
  #     String.to_integer(first <> last)
  #   end)
  #   |> Enum.sum()
  # end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&get_calibration_values(&1, nil, nil, :part2))
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end


  defp get_calibration_values([hd | tl], first, _, part) when hd in @digits do
    get_calibration_values(tl, first || hd, hd, part)
  end

  defp get_calibration_values(["o", "n", "e" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "1", "1", :part2)
  defp get_calibration_values(["t", "w", "o" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "2", "2", :part2)
  defp get_calibration_values(["t", "h", "r", "e", "e" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "3", "3", :part2)
  defp get_calibration_values(["f", "o", "u", "r" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "4", "4", :part2)
  defp get_calibration_values(["f", "i", "v", "e" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "5", "5", :part2)
  defp get_calibration_values(["s", "i", "x" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "6", "6", :part2)
  defp get_calibration_values(["s", "e", "v", "e", "n" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "7", "7", :part2)
  defp get_calibration_values(["e", "i", "g", "h", "t" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "8", "8", :part2)
  defp get_calibration_values(["n", "i", "n", "e" | _] = [ _hd | tl], first, _, :part2), 
    do: get_calibration_values(tl, first || "9", "9", :part2)

  defp get_calibration_values([_|tl], first, last, part), do: get_calibration_values(tl, first, last, part)
  defp get_calibration_values([], first, last, _), do: first<>last
end
