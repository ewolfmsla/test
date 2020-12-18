defmodule Length do
  @moduledoc false

  def calc([]), do: 0

  def calc([_head | tail]) do
    1 + calc(tail)
  end

end
