defmodule AdventOfCode.Day03 do
  def part1(args) do
    indexed_matrix =
      args
      |> String.split("\n", trim: true)
      |> Enum.with_index()

    indexed_matrix
    |> Enum.map(fn {line, index} ->
      part_number_indexes =
        Enum.map(Regex.scan(~r/\d+/, line, return: :index), fn [tuple] -> tuple end)

      {previous_line, _} = Enum.at(indexed_matrix, max(index - 1, 0))
      {next_line, _} = Enum.at(indexed_matrix, min(index + 1, length(indexed_matrix) - 1))

      part_number_indexes
      |> Enum.filter(fn {index, length} ->
        get_slice(previous_line, index, length) ||
          get_slice(line, index, length) ||
          get_slice(next_line, index, length)
      end)
      |> Enum.map(fn {index, length} -> String.slice(line, index..(index + length - 1)) end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
      |> dbg()
    end)
    |> Enum.sum()
  end

  def part2(_args) do
  end

  defp has_symbol?(slice) do
    slice =~ ~r/[^.\d]/
  end

  defp get_slice(line, index, length) do
    slice_range = max(index - 1, 0)..min(index + length, String.length(line) - 1)
    dbg()
    has_symbol?(String.slice(line, slice_range))
  end
end
