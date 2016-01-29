defmodule SlackEx.Bot.GithubStatus do
  use GenServer
  require Logger

  def start_link(url \\ nil) do
    GenServer.start_link(__MODULE__, %{ status: nil, url: url }, name: __MODULE__)
  end

  @interval 5000
  @url "https://status.github.com/api/status.json"

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

  def handle_info(:check_status, state = %{ url: url }) do
    status = check_status

    {:noreply, Map.put(state, :status, status)}
  end

  defp check_status do
    status = case fetch_status do
      "good" ->
        :ok
      "minor" ->
        :warn
      "major" ->
        :error
    end

    Logger.debug "#{__MODULE__}: #{status}"

    status
  end

  defp fetch_status do
    {:ok, json } = fetch_response.body |> Poison.decode

    json["status"]
  end

  defp fetch_response do
    @url
    |> HTTPoison.get!
  end
end
