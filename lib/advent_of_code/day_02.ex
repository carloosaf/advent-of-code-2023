defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ":", trim: true))
    |> Enum.filter(fn [_, cubes] ->
      cubes
      |> String.split(";", trim: true)
      |> Enum.all?(&valid_pull?/1)
    end)
    |> Enum.map(fn [game, _] -> get_game_number(game) end)
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
    |> Enum.map(&get_min_balls/1)
    |> Enum.map(fn {red, green, blue} -> red * green * blue end)
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

  defp get_game_number(game) do
    case Regex.run(~r/Game (\d+)/, game) do
      [_, game_number] -> String.to_integer(game_number)
      _ -> nil
    end
  end

  defp get_min_balls(pulls) do
    Enum.reduce(pulls, {-1, -1, -1}, fn pull, {red, green, blue} ->
      {max(red, count_color(pull, "red")), max(green, count_color(pull, "green")),
       max(blue, count_color(pull, "blue"))}
    end)
  end

  defp valid_pull?(pull) do
        count_color(pull, "red") <= 12 and count_color(pull, "green") <= 13 and
          count_color(pull, "blue") <= 14
  end
end
