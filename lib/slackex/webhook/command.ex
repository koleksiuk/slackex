defmodule SlackEx.Webhook.Command do
  defstruct token: nil, team_id: nil, team_domain: "", channel_id: nil, channel_name: "",
    user_id: nil, user_name: "", command: "", text: "", response_url: ""

  def valid?(request) do
    {:ok, valid_token} = request.command |> action_for |> SlackEx.Webhook.get_token

    request.token == valid_token
  end

  defp action_for(command) do
    command |> String.slice(1..-1)
  end
end
