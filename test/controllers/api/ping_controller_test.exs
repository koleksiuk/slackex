defmodule SlackEx.Api.PingControllerTest do
  use SlackEx.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "POST /api/ping", %{conn: conn} do
    conn = get conn, api_ping_path(conn, :show), %{ }

    assert json_response(conn, 200)["text"] == "pong"
  end
end
