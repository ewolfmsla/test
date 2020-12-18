defmodule Summer do
  @moduledoc false

  def sum(1), do: 1
  def sum(n) do
    n + sum(n - 1)
  end
end
