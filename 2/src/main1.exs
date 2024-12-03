defmodule Report do
  def _isSafe([], _), do: true
  def _isSafe([_], _), do: true
  def _isSafe([first, second | rest], isDecreasing) do
    case isDecreasing do
      true ->
        cond do
          first - second >= 1 and first - second <= 3 -> _isSafe([second | rest], isDecreasing)
          true -> false
        end
      false ->
        cond do
          second - first >= 1 and second - first <= 3 -> _isSafe([second | rest], isDecreasing)
          true -> false
        end
    end
  end

  def isSafe(nums) do
    _isSafe(nums, true) or _isSafe(nums, false)
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
