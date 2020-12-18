defmodule Util.Extract do
  @moduledoc false

  defp extract_fn(%{"first_name" => first_name}), do: {:ok, first_name}
  defp extract_fn(_), do: {:error, :first_name_missing}

  defp extract_age(%{"age" => age}), do: {:ok, age}
  defp extract_age(_), do: {:error, :age_missing}

  def from(person) do
    with {:ok, first_name} <- extract_fn(person),
         {:ok, age} <- extract_age(person) do
      %{:first => first_name, :age => age}
    end
  end

end
