defmodule Fact do
  @moduledoc false

  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)

  def zip(0), do: 0
  def zip(n), do: n + zip(n-1)

end
