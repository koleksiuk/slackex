defmodule SlackEx.Api.PingController do
  use SlackEx.Web, :controller

  def show(conn, _params) do
    response = %{ text: "pong" }

    render conn, "show.json", response: response
  end
end
