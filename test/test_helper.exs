ExUnit.start

Mix.Task.run "ecto.create", ~w(-r SlackEx.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r SlackEx.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(SlackEx.Repo)

