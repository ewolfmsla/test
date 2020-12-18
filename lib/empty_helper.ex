defmodule EmptyHelper do
  @moduledoc false

  def empty?([]), do: :true
  def empty?([_|_]), do: :false

end
