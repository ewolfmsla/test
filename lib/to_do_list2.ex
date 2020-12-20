defmodule ToDoList2 do
  @moduledoc false

  defstruct auto_id: 1, entries: %{}

  def new(), do: %ToDoList2{}

  def add_entry(to_do_list, entry) do
    entry = Map.put(entry, :id, to_do_list.auto_id)
    new_entries = Map.put(to_do_list.entries, to_do_list.auto_id, entry)
    %ToDoList2{to_do_list | entries: new_entries, auto_id: to_do_list.auto_id + 1}
  end

  def entries(to_do_list, weekday) do
    to_do_list.entries
    |> Stream.filter(fn {_, entry} -> entry.weekday == weekday end)
    |> Enum.map(fn {_, entry} -> entry.task end)
  end

  defp get_task(entry) do
    cond do
      entry == nil -> "unknown"
      true -> entry.task
    end
  end

  def get_entry_by_id(to_do_list, target_id) do
    to_do_list.entries
    |> Stream.filter(fn {id, _} -> id == target_id end)
    |> Enum.map(fn {_id, entry} -> entry end)
    |> Enum.at(0)
    |> get_task
  end

  def update_task(to_do_list, target_id, updated_task) do
    #    entries = to_do_list.entries
    #    |> Enum.map(fn {id, entry} ->
    #      cond do
    #        id == target_id -> {id, %{entry | task: updated_task}}
    #        true -> {id, entry}
    #           end
    #    end)
    #    %ToDoList2{to_do_list | entries: entries}

    %ToDoList2{
      to_do_list
      | entries:
          Enum.map(to_do_list.entries, fn {k, v} ->
            cond do
              k == target_id -> {k, %{v | task: updated_task}}
              true -> {k, v}
            end
          end)
    }
  end

  defp update_entry(to_do_list, id, entry) do
    %ToDoList2{to_do_list | entries: Map.put(to_do_list.entries, id, entry)}
  end

  def update_task2(to_do_list, id, updated_task) do
    case Map.fetch!(to_do_list.entries, id) do
      :error -> to_do_list
      entry -> update_entry(to_do_list, id, %{entry | task: updated_task})
    end
  end
end
