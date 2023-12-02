defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ":", trim: true))
    |> Enum.filter(fn [_, cubes] ->
      tokens = String.split(cubes, ";", trim: true)

      filtered =
        Enum.filter(tokens, fn token ->
          check_color(token, 12, "red") and check_color(token, 13, "green") and
            check_color(token, 14, "blue")
        end)

      length(filtered) == length(tokens)
    end)
    |> Enum.map(fn [game, _] ->
      case Regex.run(~r/Game (\d+)/, game) do
        [_, game_number] -> String.to_integer(game_number)
        _ -> nil
      end
    end)
    |> Enum.sum()
  end

  def part2(_args) do
  end

  defp check_color(string, max, color) do
    case Regex.scan(~r/(\d+) #{color}/, string) do
      [[_, x]] -> String.to_integer(x) <= max
      [] -> true
    end
  end
end
