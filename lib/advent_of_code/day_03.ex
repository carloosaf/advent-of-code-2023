defmodule AdventOfCode.Day03 do
  # This code is kind of a mess, but it works. I don't have time to clean it up 🤷

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
        has_symbol?(get_slice(previous_line, index, length)) ||
          has_symbol?(get_slice(line, index, length)) ||
          has_symbol?(get_slice(next_line, index, length))
      end)
      |> Enum.map(fn {index, length} -> String.slice(line, index..(index + length - 1)) end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2(args) do
    indexed_matrix =
      args
      |> String.split("\n", trim: true)
      |> Enum.with_index()

    indexed_matrix
    |> Enum.map(fn {line, index} ->
      asterisks = Enum.map(Regex.scan(~r/\*/, line, return: :index), fn [tuple] -> tuple end)

      {previous_line, _} = Enum.at(indexed_matrix, max(index - 1, 0))
      {next_line, _} = Enum.at(indexed_matrix, min(index + 1, length(indexed_matrix) - 1))

      previous_line_ranges = get_number_ranges(previous_line)
      line_ranges = get_number_ranges(line)
      next_line_ranges = get_number_ranges(next_line)

      asterisks
      |> Enum.map(fn {index, _} ->
        previous = process_ranges(previous_line_ranges, previous_line, index)
        line = process_ranges(line_ranges, line, index)
        next = process_ranges(next_line_ranges, next_line, index)
        combined = previous ++ line ++ next

        if length(combined) == 2 do
          combined
          |> Enum.map(fn {line, range} ->
            String.to_integer(hd(Regex.run(~r/\d+/, String.slice(line, range))))
          end)
          |> Enum.product()
        else
          0
        end
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  defp has_symbol?(slice) do
    slice =~ ~r/[^.\d]/
  end

  defp get_slice(line, index, length) do
    String.slice(line, get_slice_range(line, index, length))
  end

  defp get_number_ranges(line) do
    Enum.map(Regex.scan(~r/\d+/, line, return: :index), fn [{index, length}] ->
      get_slice_range(line, index, length)
    end)
  end

  defp get_slice_range(line, index, length),
    do: max(index - 1, 0)..min(index + length, String.length(line) - 1)

  def process_ranges(ranges, line, index) do
    Enum.flat_map(ranges, fn range ->
      if index in range do
        [{line, range}]
      else
        []
      end
    end)
  end
end
