defmodule Scratchcard do
  defstruct [:id, :winning_numbers, :numbers]

  def parse(line) do
    [id_token, numers_token] = String.split(line, ":")
    [id] = Enum.map(Regex.run(~r/\d+/, id_token), fn id -> String.to_integer(id) end)

    [winning_numbers, numbers] =
      numers_token
      |> String.split("|")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.split(&1, ~r/\s+/))
      |> Enum.map(fn number_list -> Enum.map(number_list, &String.to_integer/1) end)

    %Scratchcard{id: id, winning_numbers: winning_numbers, numbers: numbers}
  end
end

defmodule AdventOfCode.Day04 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn scratchcard -> Scratchcard.parse(scratchcard) end)
    |> Enum.map(fn %Scratchcard{winning_numbers: winning_numbers, numbers: numbers} ->
      numbers
      |> Enum.filter(fn number -> number in winning_numbers end)
      |> Enum.count()
    end)
    |> Enum.filter(fn count -> count > 0 end)
    |> Enum.map(fn count -> Integer.pow(2, count - 1) end)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn scratchcard -> Scratchcard.parse(scratchcard) end)
    |> count_won_scratchcards()
  end

  defp count_won_scratchcards(scratchcards) do
    scratchcards
    |> Enum.into(%{}, fn %Scratchcard{id: id} = scratchcard ->
      {id, {scratchcard, count_wins(scratchcard)}}
    end)
    |> count_won_scratchcards(Enum.to_list(1..length(scratchcards)))
  end

  defp count_wins(%Scratchcard{
         numbers: numbers,
         winning_numbers: winning_numbers
       }) do
    numbers
    |> Enum.filter(fn number -> number in winning_numbers end)
    |> Enum.count()
  end

  defp count_won_scratchcards(
         map,
         ids
       ) do
    child_count =
      ids
      |> Enum.map(fn id ->
        {_, local_count} = map[id]

        if local_count == 0 do
          0
        else
          count_won_scratchcards(
            map,
            Enum.to_list((id + 1)..(id + local_count))
          )
        end
      end)
      |> Enum.sum()

    child_count + length(ids)
  end
end
