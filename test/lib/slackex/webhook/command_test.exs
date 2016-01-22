defmodule SlackEx.Webhook.CommandTest do
  use ExUnit.Case, async: true

  setup do
    command = %SlackEx.Webhook.Command{ command: "/ping" }
    { :ok, [request: command] }
  end

  test "valid? returns true if token matches the command", %{ request: request } do
    request = Map.put(request, :token, "test-token")

    assert SlackEx.Webhook.Command.valid?(request)
  end

  test "valid returns false if token does not match the command", %{ request: request } do
    request = Map.put(request, :token, "foobar")

    refute SlackEx.Webhook.Command.valid?(request)
  end
end
