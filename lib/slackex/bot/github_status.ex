defmodule SlackEx.Bot.GithubStatus do
  use GenServer
  require Logger

  def start_link(url \\ nil) do
    GenServer.start_link(__MODULE__, %{ status: nil, url: url }, name: __MODULE__)
  end

  @interval 5000
  @url "https://status.github.com/api/status.json"
  @hook_url "https://hooks.slack.com/services/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"

  def status do
    GenServer.call(__MODULE__, :status)
  end

  # Private API
  def init(state) do
    :timer.send_interval(@interval, :check_status)

    {:ok, state}
  end

  def handle_call(:status, _from, state = %{ status: status }) do
    {:reply, status, state}
  end

  def handle_info(:check_status, state = %{ status: current_status, url: url }) do
    status = check_github_status(current_status)

    {:noreply, Map.put(state, :status, status)}
  end

  defp check_github_status(current_status) do
    new_status = case fetch_status do
      "good" -> :ok
      "minor" -> :warn
      "major" -> :error
    end

    case current_status do
      nil -> new_status_notification(new_status)
      new_status -> nil
      _ -> new_status_notification(new_status)
    end

    new_status
  end

  defp fetch_status do
    {:ok, json } = fetch_response.body |> Poison.decode

    json["status"]
  end

  defp fetch_response do
    @url
    |> HTTPoison.get!
  end

  defp new_status_notification(new_status) do
    Logger.debug("#{__MODULE__}: New status: #{new_status}")
    :ok = SlackEx.Notification.process("New status: #{new_status}")
  end
end
