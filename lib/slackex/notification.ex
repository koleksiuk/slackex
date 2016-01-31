defmodule SlackEx.Notification do
  def process(notification) do
    token = :poolboy.transaction(:notification_worker, &notify(&1, notification))

    {:ok, token}
  end

  def notify(worker, notification) do
    SlackEx.Notification.Worker.send_notification(worker, notification)
  end
end
