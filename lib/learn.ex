defmodule Learn do
  require Logger

  def apply_f(x, f) do
    f.(x)
  end

  def plus_one(x) do
    x + 1
  end

  def add_one(x) do
    plus_one(x)
  end

  def tup() do
    {"dog", "spur dog"}
  end

  def deal_with_line(line) do
    line = String.trim(line)
    line = "-->" <> line <> "<--"
    IO.puts(line)
  end

  def run do
    IO.puts("let's do some learning")
    x = 3.8
    t1 = {:a, "the letter a", :b, ~s("the letter b #{x}")}
    IO.puts(elem(t1, 3))
    Enum.each(["hello", ~s("the letter b #{x}")], &IO.puts/1)

    double = fn x ->
      x * 2
    end

    res = apply_f(14.5, double)

    IO.puts("res = #{res}")
    IO.puts("res2 = #{apply_f(14, fn x -> x + 1 end)}")

    IO.puts(res == 29)
    IO.puts("res3 = #{apply_f(10, &add_one/1)}")

    outside_var = 5
    lamda = fn -> IO.puts("outside_var = #{outside_var}") end
    lamda.()
    outside_var = 6
    lamda.()

    IO.puts(outside_var)

    {:ok, pid} = Agent.start_link(fn -> 0 end)
    fun = fn -> Agent.get_and_update(pid, fn i -> {i, i + 1} end) end
    IO.puts(fun.())
    IO.puts(fun.())
    IO.puts(fun.())

    # IO.puts("lam1: #{lam.()}")
    # IO.puts("lam2: #{lam.()}")
    # # IO.puts("lam3: #{lam.()}")

    IO.puts(elem(tup(), 1))

    Counter.start_link(5)
    IO.puts(Counter.value())
    Counter.increment()
    Counter.increment()
    IO.puts(Counter.value())

    ms = MapSet.new([:monday, :tuesday])
    ms = MapSet.put(ms, :wednesday)

    Enum.each(ms, &IO.puts/1)

    # stream = File.stream!("README.md")
    # Enum.each(stream, &deal_with_line/1)

    x = Enum.fetch(ms, 2)

    if x != :error do
      IO.puts("ok => #{elem(x, 1)}")
    else
      IO.puts("ouch")
    end

    IO.puts(NumTest.sign(5))
    IO.puts(NumTest.sign(0))
    IO.puts(NumTest.sign(-1))
    IO.puts(NumTest.sign("foo"))
    IO.puts(NumTest.who(1))

    IO.puts("[] empty ? #{EmptyHelper.empty?([])}")
    IO.puts("[:cat] empty ? #{EmptyHelper.empty?([:cat])}")
  end

  def run2 do
    x = Fact.fact(3)
    IO.puts(x)

    x = Fact.zip(10)
    IO.puts(x)
    IO.puts(CurrencyFormatter.format(x * 100, "USD"))

    max = NumTest.max(5, 7)
    IO.puts("NumTest.max(5, 7) = #{max}")

    IO.puts("NumTest.case_test: #{NumTest.case_test(4)}")

    list = [0, 1, 2, 3, 4, 5, 6]

    fx = &NumTest.case_test/1

    #    Enum.each(list, fn x -> fx.(x) |> IO.puts() end)

    foo = fn x -> fx.(x) |> IO.puts() end

    Enum.each(list, foo)
  end

  def handle_ian({:ok, content}) do
    Logger.debug(inspect(":ok => #{content}"))
  end

  def handle_ian({:error, reason}) do
    Logger.debug(inspect(":error => #{reason}"))
  end

  def ian(0), do: {:ok, "nice job, Ian!"}
  def ian(_), do: {:error, "oh, shoot!"}

  def print(1), do: IO.puts(1)

  def print(n) do
    print(n - 1)
    IO.puts(n)
  end

  def run3() do
    import Util.Extract, only: [from: 1]

    person = %{"first_name" => "eric", "last_name" => "wolf", "age" => 61}
    extracted = from(person)

    Logger.debug("extracted first: #{extracted[:first]}, age: #{extracted[:age]}")
    Logger.debug(inspect(from(%{"first_name" => "Enrique"})))
    Logger.debug(inspect(from(Map.new([{"first_name", "Sally"}, {"age", 51}]))))

    ian(1) |> handle_ian
    ian(0) |> handle_ian

    #    print(3)

    sum = Summer.sum(100)

    Logger.debug("sum = #{inspect(sum)}")

    kk = [1, 2, 3, 4]
    IO.puts(hd(kk))

    Logger.debug("len [1, 2, 3, 4, 5, 3, 2] = #{inspect(Length.calc([1, 2, 3, 4, 5, 3, 2]))}")

    to_do_list = ToDoList.new() |>
      ToDoList.add("mon", "get out of bed")
      |> ToDoList.add("mon", "drink coffee!!")
      |> ToDoList.add("mon", "learn elixir")

    Logger.info(">>>> #{inspect(ToDoList.tasks_for(to_do_list, "mon"))}")

    to_do_list = ToDoList.add(to_do_list, "mon", "more coffee!!!!")
    to_do_list = ToDoList.add(to_do_list, "mon", "learn more elixir!")
    to_do_list = ToDoList.add(to_do_list, "mon", "take a break from learning")

    mon_tasks = ToDoList.tasks_for(to_do_list, "mon")
#    mon_tasks = ToDoList.add(mon_tasks, "mon", "eat!")
    Logger.debug("monday tasks: #{inspect(mon_tasks)}")

    to_dos = ToDoList.new()
    to_dos = ToDoList.add(to_dos, "mon", "hello")
    to_dos = ToDoList.add(to_dos, "mon", "goodbye!")
    Logger.debug("to_dos: #{inspect(ToDoList.tasks_for(to_dos, "mon"))}")

    ParamTest.try({:ok, "worked"})
    ParamTest.try({:error, "worked"})
    ParamTest.try({:foo, "worked"})
    {:ok, "great"} |> ParamTest.try

#    ["eric", "sally"] |>
#    Stream.with_index |>
#    Enum.each(fn {name, idx} -> IO.puts("#{idx + 1}. #{name}") end)

    st = ["eric", "sally"] |>
      Stream.with_index |>
      Enum.reduce("", fn {name, idx}, a ->  a <> "#{idx + 1}. #{name}\n" end)

    IO.puts(st)
  end
end
