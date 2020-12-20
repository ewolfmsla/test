defmodule HelloTest do
  use ExUnit.Case
  doctest Hello

  test "greets the world" do
    assert Hello.hello() == :world
  end

  test "NumTest.max" do
    assert NumTest.max(5, 7) == 7
  end

  test "Util.Extract.from success" do
    extracted = Util.Extract.from(%{"first_name" => "first", "last_name" => "last", "age" => 30})
    assert extracted === %{age: 30, first: "first"}
  end

  test "Util.Extract.from failure" do
    extracted = Util.Extract.from(%{"first_name" => "first", "last_name" => "last"})
    assert {:error, :age_missing} === extracted
  end

  test "length.calc" do
    assert Length.calc([1, 3, 2, 1]) === 4
  end

  test "to do list test" do
    to_do_list =
      ToDoList.new()
      |> ToDoList.add("x", 1)
      |> ToDoList.add("x", 2)
      |> ToDoList.add("x", 3)
      |> ToDoList.add("y", 1)
      |> ToDoList.add("y", 2)
      |> ToDoList.add("z", 3)

    tasks = ToDoList.tasks_for(to_do_list, "x")
    assert [1, 2, 3] === tasks
  end

  test "user validation good" do
    user = %{"first_name" => "foo", "last_name" => "bar", "age" => 24}
    assert {:ok, []} == UserValidation.validate(user)
  end

  test "user validation missing last_name and age" do
    user = %{"first_name" => "foo"}
    assert {:error, ["last_name", "age"]} == UserValidation.validate(user)
  end

  test "reduce test num" do
    assert Enum.reduce([1, 2, 3], 0, fn x, sum -> sum + x end) === 6
  end

  test "reduce test letter" do
    assert Enum.reduce(["a", "b", "c"], "", fn x, val -> val <> x end) === "abc"
  end

  test "comprehension test" do
    val =
      for x <- [1, 2, 3] do
        cond do
          x === 2 -> x * x * 4
          true -> x * x
        end
      end

    assert val === [1, 16, 9]
  end

  test "comprehension test two" do
    assert Enum.reduce(5..1, [], fn x, a -> [x | a] end) === [1, 2, 3, 4, 5]
    assert Enum.reduce(5..1, [], &[&1 | &2]) === [1, 2, 3, 4, 5]
  end

  test "streams and comps" do
    expected = """
    1. foo
    2. bar
    """

    expected = String.trim(expected)

    generated =
      ["foo", "bar"]
      |> Stream.with_index()
      |> Enum.reduce("", fn {name, idx}, a -> a <> "#{idx + 1}. #{name}\n" end)

    generated = String.trim(generated)

    assert generated === expected
  end

  test "struct" do
    person = %Person{first: "Foo", last: "Bar"}
    person = %{person | age: 24}
    assert person.age === 24
    assert person.__struct__ === Person
  end

  test "todo list 2" do
    todos =
      ToDoList2.new()
      |> ToDoList2.add_entry(%{:weekday => "mon", :task => "drink coffee"})
      |> ToDoList2.add_entry(%{:weekday => "tue", :task => "read book"})
      |> ToDoList2.add_entry(%{:weekday => "mon", :task => "eat breakfast"})

    assert ToDoList2.entries(todos, "mon") == ["drink coffee", "eat breakfast"]
    assert ToDoList2.get_entry_by_id(todos, 2) == "read book"
    assert ToDoList2.get_entry_by_id(todos, 5) == "unknown"
  end

  test "todo list 2 update" do
    todos =
      ToDoList2.new()
      |> ToDoList2.add_entry(%{:weekday => "mon", :task => "drink coffee"})
      |> ToDoList2.add_entry(%{:weekday => "tue", :task => "read book"})
      |> ToDoList2.add_entry(%{:weekday => "mon", :task => "eat breakfast"})

    todos = ToDoList2.update_task(todos, 2, "read elixir book")
    todos = ToDoList2.update_task(todos, 1, "drink some coffee")

    todos = ToDoList2.update_task(todos, 5, "key doesn't exit, don't alter to do list")

    assert ToDoList2.get_entry_by_id(todos, 2) == "read elixir book"
    assert ToDoList2.get_entry_by_id(todos, 1) == "drink some coffee"
  end

  test "todo list 2 update2" do
    todos =
      ToDoList2.new()
      |> ToDoList2.add_entry(%{:weekday => "mon", :task => "drink coffee"})
      |> ToDoList2.add_entry(%{:weekday => "tue", :task => "read book"})
      |> ToDoList2.add_entry(%{:weekday => "mon", :task => "eat breakfast"})

    todos = ToDoList2.update_task2(todos, 2, "read elixir book")

    assert ToDoList2.get_entry_by_id(todos, 2) === "read elixir book"
    assert ToDoList2.get_entry_by_id(todos, 1) === "drink coffee"
  end
end
