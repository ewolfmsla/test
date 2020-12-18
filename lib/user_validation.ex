defmodule UserValidation do
  @moduledoc false

  def validate(user) do
    fields = ["first_name", "last_name", "age"]
    case Enum.filter(fields, &(not Map.has_key?(user, &1))) do
      [] -> {:ok, []}
      missing_fields -> {:error, missing_fields}
    end
  end

end
