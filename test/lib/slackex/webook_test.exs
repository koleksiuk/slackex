defmodule SlackEx.WebhookTest do
  use ExUnit.Case, async: true

  test "get_token returns token for given hook" do
    { :ok, token } = SlackEx.Webhook.get_token("ping")

    assert token == "test-token"
  end

  test "get_token returns error if hook does not exist" do
    assert SlackEx.Webhook.get_token("foo") == { :error, :invalid_service }
  end

  test "get_token allows to fetch token by passing atom" do
    { :ok, token } = SlackEx.Webhook.get_token(:ping)

    assert token == "test-token"
  end
end
