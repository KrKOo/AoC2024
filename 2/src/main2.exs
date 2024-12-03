defmodule Report do
  def _isSafe(_, _, -1), do: false
  def _isSafe([], _, _), do: true
  def _isSafe([_], _, _), do: true
  def _isSafe([first, second, third | rest], isDecreasing, remainingRemoves) do
    case isDecreasing do
      true ->
        cond do
          first - second >= 1 and first - second <= 3 and second - third >= 1 and second - third <= 3
            -> _isSafe([second, third | rest], isDecreasing, remainingRemoves)
          true -> _isSafe([first, second | rest], isDecreasing, remainingRemoves - 1) or
                  _isSafe([first, third | rest], isDecreasing, remainingRemoves - 1) or
                  _isSafe([second, third | rest], isDecreasing, remainingRemoves - 1)
        end
      false ->
        cond do
          second - first >= 1 and second - first <= 3 and third - second >= 1 and third - second <= 3
            -> _isSafe([second, third | rest], isDecreasing, remainingRemoves)
          true -> _isSafe([first, second | rest], isDecreasing, remainingRemoves - 1) or
                  _isSafe([first, third | rest], isDecreasing, remainingRemoves - 1) or
                  _isSafe([second, third | rest], isDecreasing, remainingRemoves - 1)
        end
    end
  end


  def _isSafe([first, second], isDecreasing, _) do
    case isDecreasing do
      true -> first - second >= 1 and first - second <= 3
      false -> second - first >= 1 and second - first <= 3
    end
  end

  def isSafe(nums) do
    _isSafe(nums, true, 1) or _isSafe(nums, false, 1)
  end
end

{:ok, contents} = File.read("data/input.txt")

numSafe = contents
|> String.split("\n")
|> Enum.map(&String.split(&1, " "))
|> Enum.map(
  fn x -> Enum.map(x, fn y -> case Integer.parse(y) do
      {int, _} -> int
      :error -> nil
    end
  end)
end)
|> Enum.map(&Report.isSafe/1)
|> Enum.map(fn x -> if x, do: 1, else: 0 end)
|> Enum.sum()

IO.inspect(numSafe)
