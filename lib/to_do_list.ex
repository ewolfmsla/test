defmodule ToDoList do
  @moduledoc false

  def new(), do: MultiDict.new()

  def add(to_do_list, day, task) do
    MultiDict.add_entry(to_do_list, day, task)
  end

  def tasks_for(to_do_list, day), do: MultiDict.entries(to_do_list, day)
end
