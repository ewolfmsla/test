defmodule ParamTest do
  @moduledoc false

  def try({ret, val}) do
    case {ret, val} do
      {:ok, _val} -> IO.puts("is ok")
      {:error, _val} -> IO.puts("error!")
      {_, _} -> IO.puts("unknown error")
    end
  end
end
