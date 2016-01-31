defmodule SlackEx.Notification.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_options = [
      name: {:local, :notification_worker},
      worker_module: SlackEx.Notification.Worker,
      size: 5,
      max_overflow: 10
    ]

    children = [
      :poolboy.child_spec(:notification_worker, pool_options, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
