defmodule AppUniteWeb.ErrorView do
  use AppUniteWeb, :view

  alias Ecto.Changeset

  def render("error.json", %{changeset: changeset, type: type}) do
    %{
      message: "Error during operating on #{type}.",
      errors: translate_errors(changeset)
    }
  end

  defp translate_errors(changeset) do
    changeset
    |> Changeset.traverse_errors(fn {msg, opts} ->
      opts
      |> Enum.reduce(msg, fn {key, value}, acc_msg ->
        String.replace(acc_msg, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.map(fn {field, [first_message | _others]} ->
      %{field: field, message: first_message}
    end)
  end
end
