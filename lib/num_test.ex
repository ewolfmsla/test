defmodule NumTest do
  @moduledoc false


  def foo() do
  end

  def sign(x) do
    cond do
      is_number(x) and x > 0 -> :positive
      x == 0 -> :zero
      is_number(x) and x < 0 -> :negative
      true -> :nan
    end
  end

  def who(x) do
    cond do
      x == 1 -> :eric
      true -> :wolf
    end
  end

  def max(a, b) do
    cond do
      a >= b -> a
      true -> b
    end
  end

  def case_test(x) do
    case x do
      0 -> :zero
      1 -> :one
      n when n > 1 and n < 5 -> :between_2_and_4
      _ -> :yikes
    end
  end
end
