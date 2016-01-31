defmodule SlackEx.Notification.Worker do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def send_notification(worker, notification) do
    GenServer.cast(worker, {:notify, notification})
  end

  def init([]) do
    {:ok, 0}
  end

  def handle_cast({:notify, notification}, notifications_sent) do
    {:noreply, notifications_sent + 1}
  end
end
