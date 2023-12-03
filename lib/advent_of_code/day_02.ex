defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ":", trim: true))
    |> Enum.filter(fn [_, cubes] ->
      tokens = String.split(cubes, ";", trim: true)

      filtered =
        Enum.filter(tokens, fn token ->
          count_color(token, "red") <= 12 and count_color(token, "green") <= 13 and
            count_color(token, "blue") <= 14
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

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, cubes] = String.split(line, ":", trim: true)
      cubes
    end)
    |> Enum.map(&String.split(&1, ";", trim: true))
    |> Enum.map(fn tokens -> 
       Enum.reduce(tokens, {-1, -1, -1}, fn token, {red, green, blue} ->
        {max(red, count_color(token, "red")), max(green, count_color(token, "green")),
         max(blue, count_color(token, "blue"))}
      end)
    end)
    |> Enum.map(fn {red, green, blue} -> red*green*blue end)
    |> Enum.sum()
  end

  defp count_color(string, color) do
    case Regex.scan(~r/(\d+) #{color}/, string) do
      [[_, x]] ->
        String.to_integer(x)
      [] ->
        -1
    end
  end
end
