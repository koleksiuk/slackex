defmodule SlackEx.Webhook do
  def get_token(action) when is_binary(action) do
    String.to_atom(action) |> validate_token
  end

  def get_token(action) when is_atom(action) do
    action |> validate_token
  end

  defp validate_token(action) do
    hook_token = Application.get_env(:slackex, :webhook)[action]

    case hook_token do
      nil        -> {:error, :invalid_service}
      hook_token -> {:ok, hook_token}
    end
  end
end
