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
end
