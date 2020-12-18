defmodule MultiDict do
  @moduledoc false

  def new(), do: %{}

  def add_entry(dict, key, val) do
    Map.update(dict, key, [val], &([val | &1]))
  end

  def entries(dict, key) do
    Enum.reverse(Map.get(dict, key))
  end
end
